import 'package:flutter/material.dart';

/// Gives more info about waste emissions
class WasteInfo extends StatelessWidget {

  const WasteInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: const TextSpan(
        style: TextStyle(color: Colors.black, fontSize: 16), 
        children: [
          TextSpan(text: 'Waste estimates are based on types of items you dispose of.\n\n'),
          TextSpan(
            text: 'You can reduce your waste emissions by composting or recycling your disposale items. ',
          ),
          TextSpan(
            text: 'Refer to your area\'s guidelines for how to properly dispose of waste.\n\n',
          ),
          TextSpan(text: 'All emission estimates are calculated by Climatiq.'),
        ],
      ),
    );
  }
}