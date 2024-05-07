# density
if('density'%in%CompTraits){
  df.merged[,'density'] = rep(NA,length=nrow(df.merged))
  # default method to calculate the density
  if(param_CountingStrategy=='density0'){  
    df.merged.concat = df.merged[(is.na(df.merged[,'volumeofsedimentationchamber'])) & (is.na(df.merged[,'transectcounting'])),]
    df.temp = df.merged[!is.na(df.merged[,'volumeofsedimentationchamber']) & !is.na(df.merged[,'transectcounting']),]
    df.temp1 = subset(df.temp,volumeofsedimentationchamber <= 5)
    df.temp1[,'density'] = df.temp1[,'organismquantity']/df.temp1[,'transectcounting']*1000/0.001979
    df.merged.concat = rbind(df.merged.concat,df.temp1)
    df.temp2 = subset(df.temp,(volumeofsedimentationchamber > 5) & (volumeofsedimentationchamber <= 10))
    df.temp2[,'density'] = df.temp2[,'organismquantity']/df.temp2[,'transectcounting']*1000/0.00365
    df.merged.concat = rbind(df.merged.concat,df.temp2)
    df.temp3 = subset(df.temp,(volumeofsedimentationchamber > 10) & (volumeofsedimentationchamber <= 25))
    df.temp3[,'density'] = df.temp3[,'organismquantity']/df.temp3[,'transectcounting']*1000/0.010555
    df.merged.concat = rbind(df.merged.concat,df.temp3)
    df.temp4 = subset(df.temp,(volumeofsedimentationchamber > 25) & (volumeofsedimentationchamber <= 50))
    df.temp4[,'density'] = df.temp4[,'organismquantity']/df.temp4[,'transectcounting']*1000/0.021703
    df.merged.concat = rbind(df.merged.concat,df.temp4)
    df.temp5 = subset(df.temp,volumeofsedimentationchamber > 50)
    df.temp5[,'density'] = df.temp5[,'organismquantity']/df.temp5[,'transectcounting']*1000/0.041598
    df.merged.concat = rbind(df.merged.concat,df.temp5)
    df.merged.concat = df.merged.concat[order(df.merged.concat[,'index']),]
    df.merged = df.merged.concat
    df.merged[,'density'] = round(df.merged[,'density'],2)
  }
  else if(param_CountingStrategy=='density1'){
    df.merged[,'areaofsedimentationchamber'] = ((df.merged[,'diameterofsedimentationchamber']/2)^2)*pi
    df.merged[,'areaofcountingfield'] = ((df.merged[,'diameteroffieldofview']/2)^2)*pi
    df.merged[,'density'] = round(df.merged[,'organismquantity']*1000*df.merged[,'areaofsedimentationchamber']/df.merged[,'numberofcountedfields']*df.merged[,'areaofcountingfield']*df.merged[,'settlingvolume'],2)
  }
  else if(param_CountingStrategy=='density2'){
    df.merged[,'density'] = round(((df.merged[,'organismquantity']/df.merged[,'numberoftransects'])*(pi/4)*(df.merged[,'diameterofsedimentationchamber']/df.merged[,'diameteroffieldofview']))*1000/df.merged[,'settlingvolume'],2)
  }
  else if(param_CountingStrategy=='density3'){
    df.merged[,'density'] = round((df.merged[,'organismquantity']*1000)/df.merged[,'settlingvolume'],2)
  }
  df.merged[,'density'] = df.merged[,'density']/df.merged[,'dilutionfactor']
}   