import 'dart:convert';

import 'package:go_green/climatiq_api/emission_estimate.dart';
import 'package:go_green/models/emission_factors/emission_factors.dart';
import 'package:go_green/models/emission_factors/travel_emissions.dart';
// possible fix if this fails: try 'as https' instead
import 'package:http/http.dart' as http;

/// Used to check the amount of emissions for activities
class EmissionsChecker {
  /// The client that will call the web service
  final http.Client client;
  static const String _apiKey = 'WSNXKPDRPH4MN2TVSHRHM29DHW';

  /// Constructs an Emissions Checker.
  /// 
  /// Parameters:
  ///  - client: used to call the web service
  EmissionsChecker([http.Client? client])
    : client = client ?? http.Client();

  /// Retrieves the emissions data for a given emission type from climatiq.
  /// 
  /// Parameters:
  ///  - factor: the type of emissions to parse. 
  Future<http.Response> _fetchEmissions(EmissionFactor factor) async {
    // Reference: https://pub.dev/packages/http
    return client.post(
      Uri.parse('https://api.climatiq.io/v1/estimate',),
      headers: {'Authorization': 'Bearer $_apiKey'},
      body: jsonEncode(<String, dynamic>{
        'data': _createRequestData(factor)
      }),
    );
  }

  /// Converts the emissions data into an Emissions Estimate.
  /// 
  /// Parameters: 
  ///  - responseBody: the data to be parsed
  /// Returns the emissions data as a double
  EmissionEstimate _parseEmissions(String responseBody) {
    final parsed = (jsonDecode(responseBody) as Map<String, dynamic>);
    return EmissionEstimate.fromJson(parsed);
  }

  /// Get emissions data for a given emission factor.
  /// 
  /// Parameters:
  ///  - factor: the type of emissions to parse. 
  /// Returns the amount of emissions as an Emissions Estimate
  Future<EmissionEstimate> getEmissions(EmissionFactor factor) async {
    final response = await _fetchEmissions(factor);
    return _parseEmissions(response.body);
  }


  // METHODS FOR SENDING DATA TO THE API BELOW

  /// Creates the request data to send to the API.
  /// 
  /// Parameter:
  ///  - factor: the EmissionFactor to use for the data
  /// Returns a map representation of the data to send to the API.
  Map<String, dynamic> _createRequestData(EmissionFactor factor) {
    return  {
              'emission_factor': {
                'emission_factor': {
                  'activity_id': factor.id,
                  'data_version': factor.dataVersion
                },
              },
              'parameters': _createRequestParameters(factor)
            };
  }

  /// Creates the request parameters to send to the API.
  /// 
  /// Parameter:
  ///  - factor: the EmissionFactor to use for the parameters
  /// Returns a map representation of the parameters to send to the API.
  Map<String, dynamic> _createRequestParameters(EmissionFactor factor) {
    // Sets the parameters based on what type of emission factor this is
    Map<String, dynamic>? parameters = switch(factor) {
      // Case: type TravelEmissions
      TravelEmissions travel => 
        switch (travel.passengers) {
          // if passengers is -1, this call doesn't require that parameter
          -1 => {
                  'distance': travel.distance,
                  'distance_unit': travel.distanceUnit
                },
          // if passengers is anything else, use that value
          _ =>  {
                  'passengers': travel.passengers,
                  'distance': travel.distance,
                  'distance_unit': travel.distanceUnit
                },
        },
        
      // Case: not a supported Emission Factor
      _ => null
    };

    // Throw an error if this emission factor is unsupported
    if (parameters == null) {
      throw UnsupportedError('Unsupported Emission Factor ${factor.runtimeType}');
    }

    return parameters;
  }
}