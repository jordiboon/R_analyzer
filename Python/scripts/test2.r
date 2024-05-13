#Size class

# ---
# NaaVRE:
#  cell:
#   inputs:
#    - output_filtering: String
#   outputs:
#    - output_SizeClass: String
#    - file_graph: String
#   params:
#    - param_s3_prefix: String
#    - param_s3_secret_access_key: String
#    - param_s3_endpoint: String
#    - param_s3_access_key_id: String
#   confs:
#    - conf_output:
#       assignation: "conf_output = '/tmp/data/'"
#   dependencies:
#    - name: aws.s3
#    - name: dendextend
#    - name: dplyr
#    - name: fields
#    - name: reshape
#    - name: stringr
#    - name: vegan
#    - name: stringi
# ...
### DESCRIPTION ###
# Script to visualize the distribution of phytoplankton in different size classes 
# selected on the basis of logarithmic values of biovolume or carbon content.
# OUTPUT: .zip file containing a summary table in .csv format and one or more 
# bar plots according to the selected clusters in .pdf format
# if no selection of the spatial and temporal level is made, the analysis runs on the whole dataset

### INPUT VARIABLES ###
# datain: the input file 
# SizeUnit: one among biovolume or cellcarboncontent
# cluster: one or more among country,locality,year,month,day,parenteventid,eventid
# base: one numeric value among 2, 2.718, 10 

#packages
install.packages("stringr",repos = "http://cran.us.r-project.org")
library(stringr)

install.packages("dplyr",repos = "http://cran.us.r-project.org")
library(dplyr)

Sys.setenv(
    "AWS_ACCESS_KEY_ID" = param_s3_access_key_id,
    "AWS_SECRET_ACCESS_KEY" = param_s3_secret_access_key,
    "AWS_S3_ENDPOINT" = param_s3_endpoint
    )

#save_object(region="", bucket="naa-vre-user-data", file=output_filtering, object=paste0(param_s3_prefix, "/myfile/df_filtering.csv"))
dataset=read.csv(output_filtering,stringsAsFactors=FALSE,sep = ";", dec = ".")


conf_SizeUnit = 'biovolume'
conf_cluster_whole = 0
conf_cluster_country = 1
conf_cluster_locality = 1
conf_cluster_year = 1
conf_cluster_month = 1
conf_cluster_day = 1
conf_cluster_parenteventid = 1
conf_cluster_eventid = 1
conf_base = 2

# in case the mandatory fields are not provided, the script provides an empty output
if(!'biovolume'%in%names(dataset)) dataset[,'biovolume']=NA
if(!'cellcarboncontent'%in%names(dataset)) dataset[,'cellcarboncontent']=NA

# we need to initialize these variables so they are not showing up as inputs
ID = ''
ccfun = ''
subt = ''
subtitle = ''
data_rbind = ''
x = ''
xlb = ''
xlabz = ''
mainz = ''
logvar = ''
cclist = ''
i = ''
idz = ''
ttz = ''
m = ''
var = ''
info = ''
final = ''
mu = ''
cctab = ''
file_graph = ''

cluster = c()
if (conf_cluster_whole==1) cluster="whole"
if (conf_cluster_country==1) cluster=append(cluster,"country")
if (conf_cluster_locality==1) cluster=append(cluster,"locality")
if (conf_cluster_year==1) cluster=append(cluster,"year")
if (conf_cluster_month==1) cluster=append(cluster,"month")
if (conf_cluster_day==1) cluster=append(cluster,"day")
if (conf_cluster_parenteventid==1) cluster=append(cluster,"parenteventid")
if (conf_cluster_eventid==1) cluster=append(cluster,"eventid")

if(conf_SizeUnit=='biovolume') {
  var=dataset[,'biovolume'][!is.na(dataset[,'biovolume'])]   # use the biovolume values
  if (conf_base==2 || conf_base==10) {xlabz=bquote(paste('log'[.(conf_base)]*' biovolume (',mu,m^3,')'))   # x label for the graphs
  } else {xlabz=bquote(paste('ln biovolume (',mu,m^3,')'))}
# } else if (conf_SizeUnit=='cellcarboncontent'){
#   var=dataset[,'cellcarboncontent'][!is.na(dataset[,'cellcarboncontent'])]   # use the carbon content values
#   if (conf_base==2 || conf_base==10) {xlabz=bquote(paste('log'[.(conf_base)]*' cell carbon content (pg C)'))         # x label for the graphs
#   } else {xlabz='ln cell carbon content (pg C)'}
}

if (conf_cluster_whole==1) {      # if no temporal/spatial selection, no clusterization (the whole dataset is used)
  
  logvar=ceiling(log(var,base=conf_base))    # logarithmic value of biovolume/carbon content
  if (min(logvar,na.rm=T)>0) min_logvar = 1
  else min_logvar = min(logvar,na.rm=T)
  ttz=table(logvar)                   # frequency table
    
 # plot and export the graph as pdf
    #file_graph=paste(conf_output,'SizeClassOutput.pdf',sep='')
  file_graph='SizeClassOutput.pdf'
  pdf(file_graph)
  par(mar=c(5.1,5.1,4.1,2.1))
  barplot(ttz,xlab=xlabz,ylab='N of cells',main="Whole dataset",ylim=range(pretty(c(0, ttz))))
  
  cctab=as.data.frame(ttz)          # data to be exported in .csv (N of cells)
  colnames(cctab)=c('conf_SizeUnit',"N of cells")
  
} else {                        # if temporal/spatial selection -> clusterization
  
  if(length(cluster)>1) {
    ID=apply(dataset[, cluster], 1, function(x)paste(x,collapse = '.'))[!is.na(dataset[,'biovolume'])]
    info=as.matrix(unique(dataset[,cluster]))
    rownames(info)=apply(info,1,function(x)paste(x,collapse = '.'))
  } else if (length(cluster) == 1) {
    ID=dataset[, cluster][!is.na(dataset[,'biovolume'])]
    info=as.matrix(unique(dataset[,cluster]))
    rownames(info)=info[,1]
    colnames(info)=cluster }
  
  
  subt = paste('cluster: ',paste(cluster,collapse = ', '))  
  subtitle = paste(strwrap(subt,width=50),collapse="\n")       # subtitle with the spatial and temporal levels 
  
  # function to plot the size class distribution for each cluster
  ccfun=function(x, mainz, xlb,subtitle) {            
    logvar = ceiling(log(var[x], base = conf_base))
      if (min(logvar,na.rm=T)>0) min_logvar = 1
    else min_logvar = min(logvar,na.rm=T)
    ttz = table(factor(logvar,levels=min(logvar,na.rm=TRUE):max(logvar,na.rm=TRUE)))
    par(mar=c(7,5.1,4.1,2.1))
    barplot(ttz,xlab=xlb,ylab='N of cells',main=paste(strwrap(mainz,width=50),collapse="\n"),ylim=range(pretty(c(0,ttz))))
    mtext(subtitle,side=1,line=5.5,cex=0.9)
    return(ttz)
  }
  
  # export the graphs as pf
  file_graph=paste(conf_output,'SizeClassOutput.pdf',sep='')
  pdf(file_graph)
  
  # create a list containing the distribution information
  idz=unique(ID)
  cclist=list()
  length(cclist)=length(idz)
  names(cclist)=idz
  for (i in 1:length(idz))
    cclist[[i]]=ccfun(var[ID == idz[i]], mainz = idz[i],xlb=xlabz,subtitle=subtitle)    # call the function for plotting
                         
  dev.off()
                         
  # merge the information in a data frame to export to csv
  # Whit bind_rows, columns are matched by name, and any missing columns will be filled with NA    
  data_rbind = as.data.frame(bind_rows(cclist))                  
  data_rbind = data_rbind[ ,str_sort(names(data_rbind), numeric = TRUE)]
  # Add columns with the spatial/temporal clusters
  if (length(unique(ID))>1)final=cbind(info[names(cclist),],data_rbind)
  if (length(unique(ID))==1) final=cbind(info,data_rbind)
  if(length(cluster)==1)colnames(final)[1]=cluster
  final[is.na(final)] = 0

}

# export the csv table
output_SizeClass = paste(conf_output, "df_sizeclass.csv",sep = "")
write.table(final,output_SizeClass,row.names=FALSE,sep = ";",dec = ".",quote=FALSE)
put_object(region="", bucket="naa-vre-user-data", file=output_SizeClass, object=paste0(param_s3_prefix, "/myfile/df_sizeclass.csv"))
put_object(region="", bucket="naa-vre-user-data", file=file_graph, object=paste0(param_s3_prefix, "/myfile/SizeClassOutput.pdf"))

     
