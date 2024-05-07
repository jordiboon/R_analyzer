Sys.setenv(
    "AWS_ACCESS_KEY_ID" = param_s3_access_key_id,
    "AWS_SECRET_ACCESS_KEY" = param_s3_secret_access_key,
    "AWS_S3_ENDPOINT" = param_s3_endpoint
    )
datain1 = paste0(conf_output,"Phytoplankton__Progetto_Strategico_2009_2012_Australia.csv")
datain2 = paste0(conf_output,"2_FILEinformativo_OPERATORE.csv")
# Upload file to bucket: uploads `myfile_local.csv` to your personal folder on MinIO as `myfile.csv`
save_object(region="", bucket="naa-vre-user-data", file=datain1, object=paste0(param_s3_prefix, "/myfile/Phytoplankton__Progetto_Strategico_2009_2012_Australia.csv"))
save_object(region="", bucket="naa-vre-user-data", file=datain2, object=paste0(param_s3_prefix, "/myfile/2_FILEinformativo_OPERATORE.csv"))

