import 'package:flutter/material.dart';

/// Gives more info about energy emissions
class EnergyInfo extends StatelessWidget {

  const EnergyInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: const TextSpan(
        style: TextStyle(color: Colors.black, fontSize: 16), 
        children: [
          TextSpan(text: 'Energy estimates are based on the amount of electricity or natural gas you used in a day.\n\n'),
          TextSpan(
            text: 'Carbon emissions from natural gas are generally lower than emissions from electricity.',
            style: TextStyle(color: Color(0xFF386641), fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: 'However, natural gas is not a renewable resource.\n\n',
          ),
          TextSpan(
            text: 'There are pros and cons to each type of energy, so we recommend doing your own research and listening to climate scientists.\n\n',
          ),
          TextSpan(text: 'All emission estimates are calculated by Climatiq.'),
        ],
      ),
    );
  }
}