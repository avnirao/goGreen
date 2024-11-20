# API INFO

## General
Base url: https://api.climatiq.io
Errors: uses HTTP codes.
 - 200 for OK
 - 400 for Bad Request
 - full error code list: https://www.climatiq.io/docs/api-reference/errors

## Authentification
Every operation requires authentification using an API Key.
Always provide the Authorization header containing your API key as bearer token:
`--header "Authorization: Bearer $CLIMATIQ_API_KEY" \`

## Models
### Selector
Used to select specific emission factors. 2 ways to do this:
1. Use the activity ID for the chosen activity (get this from EmissionFactors.id)
2. Use a unique ID which will always refer to the same emission factor

Most relevant info to pass to the API: 
 - data_version (String): The data version. Access from EmissionFactors.dataVersion
 - activity_id (String): The activity id. Access from EmissionFactors.id
 - region (String, optional): the geographical region the emission factor is from
 - region_fallback (boolean, optional): Set this to true if you're willing to accept a less specific geographical region than the one you've specified. 
       Climatiq will then attempt to fall back to the larger region if it does not find any emission factors with the initial region. 
       Only one fallback can be specified at a time. Default is false
 - year (int, optional): The year in which the emission factor is considered most relevant, according to the source. Access from the entry date.
Full list: https://www.climatiq.io/docs/api-reference/models/selector

A Selector for a specific activity might look like this: 
```
  "emission_factor": {
    "data_version": "^3",
    "activity_id": "electricity-supply_grid-source_production_mix",
    "source": "MfE",
    "region": "NZ",
    "year": 2020
  }
```

### Parameters
See https://www.climatiq.io/docs/api-reference/models/parameters. Link contains info for:
 - all parameter options
 - supported currency list & currency codes

Example:
```
{
  //...
  "parameters": {
      "twenty_foot_equivalent": 2,
      "distance": 100,
      "distance_unit": "km"
  }
  //...
}
```

### Estimation
Many endpoints return 1 or more Estimation models. See https://www.climatiq.io/docs/api-reference/models/estimation for full list.
 - For this project, use 'co2e', which is a float that provides the carbon dioxide equivalent for the emission factor
 - 'co2e_unit' provides the unit in which the co2e field is expressed

## Data Versioning
See https://www.climatiq.io/docs/api-reference/data-version for more info. By default, EmissionFactors use ^19.

 - For repeatable results, choose the latest fixed version. This is currently: 19
 - For up-to-date emission factors, use the latest dynamic version. This is currently: ^19
 - If unsure, opt for the latest dynamic version. This is currently: ^19

## Errors
An error will look like this:
```
{
  "error": "bad_request",
  "error_code": "invalid_input",
  "message": "Selector should either provide an 'id', OR a 'data_version' and an 'activity_id'. It must not provide both. The latest 'data_version' is '6.6'"
  // might include additional fields
}
``` 

### Status Codes
 - 200 OK: Everything worked as expected.
 - 400 Bad Request: The request was unacceptable, probably due to missing a required parameter.
 - 401 Unauthorized: No valid API key was provided.
 - 403 Forbidden: An API key was provided, but it was not valid for the operation you tried to attempt.
 - 404 Not Found: The requested resource doesn't exist.
 - 429 Too Many Requests: You have performed too many requests recently.
 - 500 Internal Server Error: Something went wrong on our end. Please try again a bit later.
 - 503 Service Unavailable: We're temporarily having trouble providing this service. Please inspect the Retry-After Header for an appropriate time to retry this request. (https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Retry-After)
