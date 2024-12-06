import 'package:flutter/material.dart';

/// Gives more info about clothing emissions
class ClothingInfo extends StatelessWidget {

  const ClothingInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: const TextSpan(
        style: TextStyle(color: Colors.black, fontSize: 16), 
        children: [
          TextSpan(text: 'Clothing emissions are based on how much clothing you purchased or acquired. You may notice that '),
          TextSpan(
            text: 'you are still generating carbon emissions through used clothing. ',
            style: TextStyle(color: Color(0xFF386641), fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: 'You aren\'t directly supporting clothing manufacturing this way, but there are still emissions that come with it, such as collecting and reselling the clothing.\n\n',
          ),
          TextSpan(
            text: 'These emissions are ',
          ),
          TextSpan(
            text: 'much lower ',
            style: TextStyle(color: Color(0xFF386641), fontWeight: FontWeight.bold),
          ),
          TextSpan(text: 'than the emissions from buying new clothes. '),
          TextSpan(text: 'Whenever you can, seek out opportunities to get used clothing, and give away the clothing you no longer need.\n\n'),
          TextSpan(text: 'All emission estimates are calculated by Climatiq.'),
        ],
      ),
    );
  }
}