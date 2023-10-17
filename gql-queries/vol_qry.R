library(glue)

vol_qry <- function(id, from, to) {
  query <- '
  query {{
    trafficData(
      trafficRegistrationPointId: "{id}",
      timeSeries: [
        {{
          type: COUNT,
          aggregation: SUM,
          granularity: MINUTE,
          interval: 15,
          startTime: "{from}",
          endTime: "{to}"
        }}
      ]
    ) {{
      trafficData {{
        timestamp
        value
      }}
    }}
  }}
  '
  
  # Use glue to replace placeholders with provided values
  result_query <- glue(query, .open = '{', .close = '}')
  return(result_query)
}