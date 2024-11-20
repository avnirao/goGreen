import 'dart:convert';

import 'package:go_green/models/emission_factors/emission_factors.dart';
// possible fix if this fails: try 'as https' instead
import 'package:http/http.dart' as http;

/** API INFO: 
 ** GENERAL:
 * Base url: https://api.climatiq.io
 * Errors: uses HTTP codes.
 *  - 200 for OK
 *  - 400 for Bad Request
 *  - full error code list: https://www.climatiq.io/docs/api-reference/errors
 * 
 ** AUTHENTIFICATION:
 * Every operation requires authentification using an API Key.
 * Always provide the Authorization header containing your API key as bearer token:
 *  Authorization: Bearer CLIMATIQ_API_KEY
 * 
 ** SELECTOR:
 * This is the model we'll use so we can select emission factors ourselves. 2 methods:
 * 1. Use the activity ID for the chosen activity (get this from EmissionFactors.id)
 * 2. Use a unique ID which will always refer to the same emission factor
 * 
 * Most relevant info to pass to the API: 
 *  - data_version (String): The data version. Access from EmissionFactors.dataVersion
 *  - activity_id (String): The activity id. Access from EmissionFactors.id
 *  - region (String, optional): the geographical region the emission factor is from
 *  - region_fallback (boolean, optional): Set this to true if you're willing to accept a less specific geographical region than the one you've specified. 
 *        Climatiq will then attempt to fall back to the larger region if it does not find any emission factors with the initial region. 
 *        Only one fallback can be specified at a time. Default is false
 *  - year (int, optional): The year in which the emission factor is considered most relevant, according to the source. Access from the entry date.
 * Full list: https://www.climatiq.io/docs/api-reference/models/selector
 * 
 * A Selector for a specific activity might look like this: 
  "emission_factor": {
    "data_version": "^3",
    "activity_id": "electricity-supply_grid-source_production_mix",
    "source": "MfE",
    "region": "NZ",
    "year": 2020
  }
 *
 * 
 */

/// Used to check the amount of emissions for activities
class EmissionsChecker {
  /// The client that will call the web service
  final http.Client client;

  /// Constructs an Emissions Checker.
  /// 
  /// Parameters:
  ///  - client: used to call the web service
  EmissionsChecker([http.Client? client])
    : client = client ?? http.Client();

  /// Retrieves the emissions data for a given emission type from climatiq
  /// 
  /// Parameters:
  ///  - factor: the type of emissions to parse. 
  Future<http.Response> _fetchEmissions(EmissionFactor factor) {
    return client.get(Uri.parse('https://api.climatiq.io/${factor.id}'));
  }

  /// Converts the emissions data into a double.
  /// 
  /// Parameters: 
  ///  - responseBody: the data to be parsed
  /// Returns the emissions data as a double
  double _parseEmissions(String responseBody) {
    final parsed = (jsonDecode(responseBody) as Map<String, dynamic>);
    return parsed['co2e'] as double;
  }

  /// Get emissions data for a given emission factor.
  /// 
  /// Parameters:
  ///  - factor: the type of emissions to parse. 
  /// Returns the amount of emissions in kg as a double
  Future<double> getEmissions(EmissionFactor factor) async {
    final response = await _fetchEmissions(factor);
    return _parseEmissions(response.body);
  }
}