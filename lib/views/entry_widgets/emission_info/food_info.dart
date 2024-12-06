import 'package:flutter/material.dart';

/// Gives more info about food emissions
class FoodInfo extends StatelessWidget {

  const FoodInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: const TextSpan(
        style: TextStyle(color: Colors.black, fontSize: 16), 
        children: [
          TextSpan(text: 'Food estimates are based on how much food you buy.\n\n'),
          TextSpan(
            text: 'Generally, buying fish or pork contributes to fewer carbon emissions than buying beef.\n\n',
          ),
          TextSpan(text: 'All emission estimates are calculated by Climatiq.'),
        ],
      ),
    );
  }
}