import 'package:flutter/material.dart';
import 'package:go_green/climatiq_api/emission_estimate.dart';

/// Gives more info about travel emissions
class TravelInfo extends StatelessWidget {
  /// Used to compare the user's emissions to if they had driven the same distance by themselves.
  final EmissionEstimate? comparison;

  const TravelInfo({super.key, required this.comparison});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: const TextSpan(
        style: TextStyle(color: Colors.black, fontSize: 16), 
        children: [
          TextSpan(text: 'Travel emissions are based on how far you travelled.'),
          TextSpan(
            text: 'If you used a shared vehicle other than a car (such as a bus or plane), the emissions from the full vehicle are calculated first.',
            style: TextStyle(color: Color(0xFF386641), fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: 'Then, we use the estimated number of passengers on the vehicle to calculate how much you personally contributed.\n\n',
          ),
          TextSpan(text: 'All emission estimates are calculated by Climatiq.'),
        ],
      ),
    );
  }
}