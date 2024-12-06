import 'package:flutter/material.dart';
import 'package:go_green/climatiq_api/emission_estimate.dart';

/// Gives more info about travel emissions
class TravelInfo extends StatelessWidget {
  /// Used to compare the user's emissions to if they had driven the same distance by themselves.
  final EmissionEstimate? comparison;
  /// the type of travel emissions
  final String subtype;

  const TravelInfo({super.key, required this.comparison, required this.subtype});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(color: Colors.black, fontSize: 16), 
        children: [
          const TextSpan(text: 'Travel emissions are calculated based on how far you travelled. '),
          const TextSpan(
            text: 'If you used a shared vehicle other than a car (such as a bus or plane), the emissions from the full vehicle are calculated first. ',
          ),
          const TextSpan(
            text: 'Then, we use the estimated number of passengers on the vehicle to calculate how much you personally contributed.\n\n',
          ),
          const TextSpan(
            text: 'Lower your emissions by walking, biking, carpooling, or using public transport whenever possible!\n\n',
          ),
          if (comparison != null && subtype != 'Hybrid Car') ...[
            TextSpan(
              text: 'If you had driven alone the same distance you took the $subtype, you would have emitted ${comparison?.co2} kg instead.\n\n',
            ),
          ],
          const TextSpan(text: 'All emission estimates are calculated by Climatiq.'),
        ],
      ),
    );
  }
}