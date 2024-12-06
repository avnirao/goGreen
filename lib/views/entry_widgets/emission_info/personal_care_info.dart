import 'package:flutter/material.dart';

/// Gives more info about personal care and accessories emissions
class PersonalCareInfo extends StatelessWidget {

  const PersonalCareInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: const TextSpan(
        style: TextStyle(color: Colors.black, fontSize: 16), 
        children: [
          TextSpan(text: 'Personal Care and Accessories estimates are based on personal care items you buy.\n\n'),
          TextSpan(
            text: 'These estimates come from the process of manufacturing and transporting those items.\n\n',
          ),
          TextSpan(text: 'All emission estimates are calculated by Climatiq.'),
        ],
      ),
    );
  }
}