import 'dart:convert';

import 'package:go_green/climatiq_api/emission_estimate.dart';
import 'package:go_green/models/emission_factors/emission_factors.dart';
import 'package:go_green/models/emission_factors/travel_emissions.dart';
import 'package:http/http.dart' as http;

/// Used to check the amount of emissions for activities
class EmissionChecker {
  /// The client that will call the web service
  final http.Client client;
  // TODO(Mason): Encrypt API key
  static const String _apiKey = 'R58VCG52QD6GF27J7DFZR19BQM';

  /// Constructs an Emissions Checker.
  /// 
  /// Parameters:
  ///  - client: used to call the web service
  EmissionChecker([http.Client? client])
    : client = client ?? http.Client();

  /// Retrieves the emissions data for a given emission type from climatiq.
  /// 
  /// Parameters:
  ///  - factor: the type of emissions to parse. 
  Future<http.Response> _fetchEmissions(EmissionFactor factor) async {
    // Reference: https://pub.dev/packages/http
    return await client.post(
      Uri.parse('https://api.climatiq.io/data/v1/estimate',),
      headers: {
        'Authorization': 'Bearer $_apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(_createRequestData(factor)),
    );
  }

  /// Converts the emissions data into an Emissions Estimate.
  /// 
  /// Parameters: 
  ///  - responseBody: the data to be parsed
  /// Returns the emissions data as a double.
  /// Throws an Argument Error if the web service returns an invalid response.
  EmissionEstimate? _parseEmissions(http.Response response) {
    final parsed = (jsonDecode(response.body) as Map<String, dynamic>);

    // throw an error if the response has a code other than 200
    // error codes: https://www.climatiq.io/docs/api-reference/errors
    try {
      switch (response.statusCode) {
        case 200: // OK
          return EmissionEstimate.fromJson(parsed);
        case 400: // Bad Request
          throw ArgumentError('The request was unacceptable, probably due to missing a required parameter.\n$parsed');
        case 401: // Unauthorized
          throw ArgumentError('No valid API key was provided.\n$parsed');
        case 403: // Forbidden
          throw ArgumentError('An API key was provided, but it was not valid for the operation you tried to attempt.\n$parsed');
        case 404: // Not Found
          throw ArgumentError('The requested resource doesn\'t exist.\n$parsed');
        case 429: // Too Many Requests
          throw ArgumentError('You have performed too many requests recently.\n$parsed');
        case 500: // Internal Server Error
          throw ArgumentError('Something went wrong on Climatiq\'s end. Please try again a bit later.\n$parsed');
        case 503: // Service Unavailable
          throw ArgumentError('Service unavailable.\n$parsed');
      }
    } catch (e) {
      // for now, just prints the error message
      // TODO: Find better way to relay error information
      // ignore: avoid_print
      print(e);
    }

    return null;
  }

  /// Get emissions data for a given emission factor.
  /// 
  /// Parameters:
  ///  - factor: the type of emissions to parse. 
  /// Returns the amount of emissions as an Emissions Estimate
  Future<EmissionEstimate?> getEmissions(EmissionFactor factor) async {
    final response = await _fetchEmissions(factor);
    return _parseEmissions(response);
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
                'activity_id': factor.id,
                'data_version': factor.dataVersion
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
          // don't use passengers parameter if it's null
          null => {
                  'distance': travel.distance,
                  'distance_unit': travel.distanceUnit.toString()
                },
          // if passengers has a value, use that value
          _ =>  {
                  'passengers': travel.passengers,
                  'distance': travel.distance,
                  'distance_unit': travel.distanceUnit.toString()
                },
        },
        
      // Case: not a supported Emission Factor
      _ => throw UnsupportedError('Unsupported Emission Factor ${factor.runtimeType}')
    };

    return parameters;
  }
}