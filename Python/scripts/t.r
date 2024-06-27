temp <- purrr::map(.x = 1988:2023,
                        .f = ~{

                          # Retrieve data for period 1 (1 Dec to 1 March)
                          period1 <- retrieve_knmi_edr_data(bbox = bbox,
                                                            variable = "mean temperature",
                                                            start_date = lubridate::make_date(.x - 1, 12, 1),
                                                            start_time = "00:00:00",
                                                            end_date = lubridate::make_date(.x, 3, 1),
                                                            end_time = "23:59:59")

                          # Retrieve data for period 2 (2 March to 31 May)
                          period2 <- retrieve_knmi_edr_data(bbox = bbox,
                                                            variable = "mean temperature",
                                                            start_date = lubridate::make_date(.x, 3, 2),
                                                            start_time = "00:00:00",
                                                            end_date = lubridate::make_date(.x, 5, 31),
                                                            end_time = "23:59:59")

                          # Match temperature data to dates and coordinates
                          data1 <- tidyr::expand_grid(date = period1$domain$axes$t$values,
                                                      y = period1$domain$axes$y$values,
                                                      x = period1$domain$axes$x$values) |>
                            dplyr::mutate(temperature = period1$ranges$temperature$values)

                          data2 <- tidyr::expand_grid(date = period2$domain$axes$t$values,
                                                      y = period2$domain$axes$y$values,
                                                      x = period2$domain$axes$x$values) |>
                            dplyr::mutate(temperature = period2$ranges$temperature$values)

                          # Bind output of two periods
                          data <- dplyr::bind_rows(data1, data2)

                          return(data)

                        },
                        .progress = TRUE) |>
  purrr::list_c()