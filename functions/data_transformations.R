
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



to_iso8601 <- function(datetime, offset_days = 0) {
  iso_time <- as.character(datetime + days(offset_days))
  formatted_iso_time <- iso8601(anytime(iso_time))
  return(formatted_iso_time)
}


transform_volumes<- function(json_response) {

  # Parse the JSON data
  data <- fromJSON(json_response, simplifyDataFrame = TRUE)
  
  # Check if the data contains the 'volume' field
  if (!"volume" %in% colnames(data)) {
    stop("JSON data does not contain 'volume' field.")
  }
  
  # Extract relevant data and convert to a data frame
  volumes_df <- data %>%
    select(node.hour, node.volume) %>%
    rename(hour = node.hour, volume = node.volume) %>%
    as.data.frame()
  
  return(volumes_df)
}

