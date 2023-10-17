
transform_metadata_to_df<-  function(stations_metadata) {
  # Creating an empty list to store individual data frames
  df_list <- list()
  
  # Looping through the list elements
  for (i in seq_along(stations_metadata$trafficRegistrationPoints)) {
    station <- stations_metadata$trafficRegistrationPoints[[i]]
    
    # Extracting relevant information from the station although i am not sure if there was a 6th column
    id <- station$id
    name <- station$name
    latestData <- as.POSIXct(station$latestData$volumeByHour, format = "%Y-%m-%dT%H:%M:%S", tz = "UTC")
    lat <- station$location$coordinates$latLon$lat
    lon <- station$location$coordinates$latLon$lon
    
    # Creating a data frame for the station
    station_df <- tibble(id = id, name = name, latestData = latestData, lat = lat, lon = lon)
    
    # Appending the station data frame to the list
    df_list[[i]] <- station_df
  }
  
  # Combine all station data frames into one tibble
  result_df <- bind_rows(df_list)
  
  return(result_df)
}



to_iso8601<- function(){
  
}






