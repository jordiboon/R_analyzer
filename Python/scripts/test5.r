# Retrieve bud burst data
# ---
# NaaVRE:
#  cell:
#   params:
#    - param_dataverse_api_key:
#       type: String
#       default_value: ''
#   outputs:
#    - event_file: String
#    - occurrence_file: String
#    - extendedmeasurementorfact_file: String
#   dependencies:
#    - name: dplyr
#    - name: purrr
#    - name: stringr
#    - name: httr
#    - name: jsonlite
#    - name: lubridate
#    - name: tidyr
#    - name: taxize
# ...

dir.create("/tmp/data")

# Part I: Retrieve data ---------------------------------------------------

# Function to retrieve data from Dataverse
retrieve_dataverse_data <- function(dataset,
                                    version = ":latest",
                                    server = "demo.dataverse.nl",
                                    key = param_dataverse_api_key) {

  # Check if dataset is provided in right format (i.e., starting with "doi:")
  if(!stringr::str_starts(string = dataset, pattern = "doi:")) {

    dataset_doi <- paste0("doi:", stringr::str_remove(string = dataset, pattern = "DOI:|https://doi.org/"))

  } else {

    dataset_doi <- dataset

  }

  # Retrieve ID that belongs to the data set of interest
  dataset_id <- httr::GET(url = paste0("https://", server, "/api/",
                                       "datasets/:persistentId?persistentId=", dataset_doi),
                          httr::add_headers("X-Dataverse-key" = key)) |>
    httr::content(as = "text", encoding = "UTF-8") |>
    jsonlite::fromJSON() |>
    purrr::pluck("data") |>
    purrr::pluck("id")

  # Retrieve list of data files that are part of the data set
  dataset_files <- httr::GET(url = paste0("https://", server, "/api/",
                                          "datasets/", dataset_id, "/",
                                          "versions/", version, "/",
                                          "files"),
                             httr::add_headers("X-Dataverse-key" = key)) |>
    httr::content(as = "text", encoding = "UTF-8") |>
    jsonlite::fromJSON() |>
    purrr::pluck("data") |>
    purrr::pluck("dataFile")

  # Retrieve each data file in list using their unique IDs
  data <- purrr::map(.x = dataset_files$id,
                     .f = ~{

                       httr::GET(url = paste0("https://", server, "/api/",
                                              "access/datafile/", .x),
                                 httr::add_headers("X-Dataverse-key" = key)) |>
                         httr::content(encoding = "UTF-8")

                     }) |>
    purrr::set_names(stringr::str_remove_all(string = dataset_files$filename, "\\..*"))

  # If API is unsuccessful, prompt message to check DOI, version and/or server
  if(purrr::is_empty(data)) {

    stop("Dataverse API failed to fulfill the request. Check whether the provided dataset DOI, version, and/or server are correct.")

  } else {

    return(data)

  }

}

# Retrieve data
dataverse_list <- retrieve_dataverse_data(dataset = "doi:10.80227/test-QMGPSW")

# Store each table as separate R objects for easier use, and exclude README
purrr::walk2(.x = names(dataverse_list)[-1],
             .y = dataverse_list[-1],
             .f = ~{

               assign(.x, .y, envir = globalenv())

             })

# Part II: create event file (= core of DwC-Archive) ----------------------

## 1. Create help file to create event IDs ####

# Assign area names and abbreviations to sampled trees
d_tree <- tbl_tree %>%
  dplyr::left_join(tbl_area %>%
                     dplyr::select("AreaID", "AreaName", "AreaAbr" = "AreaShortName"),
                   by = "AreaID")

# Assign area names to bud burst data
d_budburst <- tbl_budburst %>%
  dplyr::left_join(d_tree %>%
                     dplyr::select("Area" = "AreaName", "TreeID", "AreaAbr"),
                   by = "TreeID")

# Rename Hoge Veluwe to avoid problems with space between words
d_budburst <- d_budburst %>%
  dplyr::mutate("Area" = stringr::str_replace(string = Area, pattern = " ", replacement = "_"))

# Create eventDate and (hierarchical) eventID of:
# level 1 (<area abbreviation><year>; e.g., HV1988)
# level 2 (<level 1 ID>_<day of year>; e.g., HV1988_119)
# level 3 (<level 2 ID>_<TreeID>; e.g., HV1988_119_412)
hierarchical_events <-
  d_budburst %>%
  dplyr::select("Year", "Month", "Day", "BudburstID", "Area", "AreaAbr", "TreeID") %>%
  dplyr::mutate(eventDate = lubridate::make_date(year = Year, month = Month, day = Day),
                DOY = lubridate::yday(eventDate),
                eventID_L1 = paste(AreaAbr, Year, sep = ""),
                eventID_L2 = paste(eventID_L1, DOY, sep = "_"),
                eventID_L3 = paste(eventID_L2, TreeID, sep = "_"))

## 2. Create event file for Level 1: Years ####

# Get all areas sampled within each year
areas_per_year <-
  d_budburst %>%
  dplyr::group_by(Year) %>%
  dplyr::distinct(Area, .keep_all = TRUE) %>%
  dplyr::summarise(location = paste(Area, collapse = ", ")) %>%
  dplyr::ungroup()

# Create associated event file
d_events_level1 <-
  hierarchical_events %>%
  dplyr::select("eventID_L1", "Year") %>%
  dplyr::distinct(eventID_L1, .keep_all = TRUE) %>%
  dplyr::mutate(eventDate = as.character(Year),
                month = NA,
                day = NA,
                samplingProtocol = NA,
                sampleSizeValue = NA,
                sampleSizeUnit = NA,
                parentEventID = NA,
                decimalLatitude = NA,
                decimalLongitude = NA,
                geodeticDatum = NA,
                minimumElevationInMeters = NA,
                maximumElevationInMeters = NA,
                verbatimLocality = areas_per_year$location[match(.$Year, areas_per_year$Year)]) %>%
  dplyr::rename("eventID" = "eventID_L1",
                "year" = "Year")

## 3. Create event file for level 2: Sampling day within each year ####

# Get all the areas that have been sampled on a specific day (in each year)
areas_per_day <-
  hierarchical_events %>%
  dplyr::group_by(eventDate) %>%
  dplyr::distinct(Area, .keep_all = TRUE) %>%
  dplyr::summarise(location = paste(Area, collapse = ", ")) %>%
  dplyr::ungroup()

# Create event file
d_events_level2 <-
  hierarchical_events %>%
  dplyr::select("eventID_L2", "eventID_L1", "eventDate", "Year", "Month", "Day") %>%
  dplyr::distinct(eventID_L2, .keep_all = TRUE) %>%
  dplyr::mutate(samplingProtocol = NA,
                sampleSizeValue = NA,
                sampleSizeUnit = NA,
                decimalLatitude = NA,
                decimalLongitude = NA,
                geodeticDatum = NA,
                minimumElevationInMeters = NA,
                maximumElevationInMeters = NA,
                verbatimLocality = areas_per_day$location[match(.$eventDate, areas_per_day$eventDate)]) %>%
  dplyr::rename("eventID" = "eventID_L2",
                "parentEventID" = "eventID_L1",
                "year" = "Year",
                "month" = "Month",
                "day" = "Day") %>%
  # Convert dates to characters to avoid merging problems later on
  dplyr::mutate(eventDate = as.character(eventDate))


## 4. Create event file for level 3: bud burst observation on each tree within each year ####

# Connect Tree table to bud burst table and h1
d_budburst <- d_budburst %>%
  dplyr::left_join(hierarchical_events %>%
                     dplyr::select("eventID" = "eventID_L3", "BudburstID"),
                   by = "BudburstID")

# Create associated event file
d_events_level3 <-
  hierarchical_events %>%
  dplyr::select("eventID_L3", "eventID_L2", "eventDate", "Year", "Month", "Day", "TreeID") %>%
  dplyr::mutate(samplingProtocol = "https://doi.org/10.1098/rspb.2000.1363",
                sampleSizeValue = 1,
                sampleSizeUnit = "tree",
                decimalLatitude = d_tree$Latitude[match(.$TreeID, d_tree$TreeID)],
                decimalLongitude = d_tree$Longitude[match(.$TreeID, d_tree$TreeID)],
                minimumElevationInMeters = d_tree$Elevation[match(.$TreeID, d_tree$TreeID)],
                maximumElevationInMeters = minimumElevationInMeters,
                verbatimLocality = d_budburst$Area[match(.$eventID_L3, d_budburst$eventID)]) %>%
  dplyr::rename("eventID" = "eventID_L3",
                "parentEventID" = "eventID_L2",
                "year" = "Year",
                "month" = "Month",
                "day" = "Day") %>%
  dplyr::select(!"TreeID")

# Add geodetic Datum only for events where coordinates are given
d_events_level3 <-
  d_events_level3 %>%
  dplyr::mutate(geodeticDatum = dplyr::case_when(!is.na(decimalLatitude) ~ "EPSG:4326",
                                                 TRUE ~ NA_character_),
                eventDate = as.character(eventDate))

# Combine all three event files into the final event-core file
event <-
  dplyr::bind_rows(d_events_level1, d_events_level2, d_events_level3) %>%
  dplyr::arrange(eventDate, eventID)

# Add DwC columns that apply to all event levels
event <-
  event %>%
  dplyr::mutate(language = "en",
                country = "Netherlands",
                countryCode = "NL",
                institutionID = "https://ror.org/01g25jp36",
                institutionCode = "NIOO",
                type = "Event") %>%
  # Reorder event file according to GBIF list
  dplyr::select("eventID", "parentEventID", "samplingProtocol", "sampleSizeValue",
                "sampleSizeUnit", "eventDate", "year", "month", "day", "country",
                "countryCode", "verbatimLocality", "minimumElevationInMeters",
                "maximumElevationInMeters", "decimalLatitude", "decimalLongitude",
                "geodeticDatum", "type", "language", "institutionID", "institutionCode") %>%
  # Rename "Hoge Veluwe" back to original name
  dplyr::mutate(verbatimLocality = stringr::str_replace(string = verbatimLocality, pattern = "_", replacement = " "))

# Save file as text file
event_file <- "/tmp/data/event.csv"
write.csv(event, file = event_file, row.names = FALSE)


# Part III. Create occurrence table ---------------------------------------

# Merge tables to assign tree species to each measurement
tree_species <-
  d_tree %>%
  dplyr::select("TreeID", "TreeSpeciesID") %>%
  #dplyr::select("TreeID", "TreeSpeciesID", "Remarks") %>%
  dplyr::left_join(tbl_treeSpecies, by = "TreeSpeciesID") %>%
  dplyr::right_join(d_budburst, by = "TreeID")


## 1. Get the taxonomic information of all species ####

# Add scientific names to tree table
tree_species <-
  tree_species %>%
  dplyr::mutate(species = dplyr::case_when(TreeSpeciesName == "European oak" ~ "Quercus robur",
                                           TreeSpeciesName == "American oak" ~ "Quercus rubra",
                                           TreeSpeciesName == "Larch" ~ "Larix kaempferi",
                                           TreeSpeciesName == "Pine" ~ "Pinus sylvestris",
                                           TreeSpeciesName == "Birch" ~ "Betula pendula",
                                           TRUE ~ "Tracheophyta"))

# Get all scientific Names to query the taxonomic information in the next step
sciNames <- unique(tree_species$species)

# Query for all species
tax <- taxize::get_gbifid_(sci = sciNames) %>%
  dplyr::bind_rows() %>%
  dplyr::filter(status == "ACCEPTED" & matchtype == "EXACT") %>%
  tidyr::separate(canonicalname, c("Genus", "specificEpithet"), remove = FALSE) %>%
  dplyr::select("scientificName" = "scientificname", "canonicalname",
                "kingdom", "phylum", "class", "order", "family", "genus", "specificEpithet")


# Bind taxonomic information to each observation
tree_species_tax <- dplyr::left_join(tree_species,
                                     tax,
                                     by = c("species" = "canonicalname"))


## 2. Create occurrence IDs ####

# Check whether there is any occasion in which more than one tree was sampled at a sampling event
# (should not be the case here as we know that one measurement is only one tree at a time)
if(d_budburst %>% dplyr::count(eventID) %>% dplyr::filter(n > 1) %>% nrow() > 0) {

  stop(paste("In", d_budburst %>% dplyr::count(eventID) %>% dplyr::filter(n > 1) %>% nrow(),
             "instances of an event, more than one tree was sampled.",
             "This should not be the case for level-3 events."))

}

# Create occurrenceID by extending eventID with '_1'
occID <-
  d_events_level3 %>%
  dplyr::arrange(eventDate) %>%
  dplyr::mutate(occurrenceID = paste(eventID, 1, sep = "_"))

# Create occurrence file
occurrence <-
  tree_species_tax %>%
  dplyr::select("eventID", "Observer",
                "kingdom", "phylum", "class", "order",
                "family", "genus", "specificEpithet", "scientificName", "TreeID") %>%
  dplyr::mutate(individualCount = 1,
                basisOfRecord = "HumanObservation",
                occurrenceStatus = "present",
                occurrenceRemarks = NA,
                recordedByID = Observer,
                occurrenceID = occID$occurrenceID[match(.$eventID, occID$eventID)]) %>%
  dplyr::rename("organismID" = "TreeID") %>%
  dplyr::select("eventID", "occurrenceID", "recordedByID",
                "individualCount", "basisOfRecord", "occurrenceStatus",
                "occurrenceRemarks", "organismID", "scientificName", "kingdom", "phylum", "class", "order",
                "family", "genus", "specificEpithet")

# Save file as text file
occurrence_file <- "/tmp/data/occurrence.csv"
write.csv(occurrence, file = occurrence_file, row.names = FALSE)

# Part IV: Create Measurement or fact file --------------------------------

## 1. Create measurement or fact file ####
measurement_or_fact <-
  tree_species_tax %>%
  tidyr::pivot_longer(col = c("TreeTopScore", "TreeAllScore"),
                      names_to = "measurementType",
                      values_to = "measurementValue")  %>%
  dplyr::select("eventID", "measurementType", "measurementValue")%>%
  dplyr::mutate(measurementUnit = NA,
                measurementMethod = "https://doi.org/10.1098/rspb.2000.1363",
                measurementRemarks = NA)

## 2. Create measurementID ####

# Number the measurements per occurrence
measurement_or_fact <-
  measurement_or_fact %>%
  dplyr::group_by(eventID) %>%
  dplyr::mutate("ID" = 1:dplyr::n()) %>%
  dplyr::ungroup()

# Add occurrenceID & create measurementID by extending occurrenceID by number of measurement
measurement_or_fact <-
  measurement_or_fact %>%
  dplyr::left_join(occurrence %>%
                     dplyr::select("occurrenceID", "eventID"),
                   by = "eventID") %>%
  dplyr::mutate(measurementID = paste(occurrenceID, ID, sep = "_")) %>%
  dplyr::select(!c("ID", "occurrenceID")) %>%
  # Rename measurement types to fit more controlled vocabulary
  dplyr::mutate(measurementType = dplyr::case_when(measurementType == "TreeTopScore" ~ "bud burst stage (PO:0025532) of the tree crown",
                                                   measurementType == "TreeAllScore" ~ "bud burst stage (PO:0025532) of the whole tree")) %>%
  # Reorder columns according to GBIF list
  dplyr::select("measurementID", "eventID", "measurementType", "measurementValue",
                "measurementUnit", "measurementMethod", "measurementRemarks")

# Save file as text file
extendedmeasurementorfact_file <- "/tmp/data/extendedmeasurementorfact.csv"
write.csv(measurement_or_fact, file = extendedmeasurementorfact_file, row.names = FALSE)