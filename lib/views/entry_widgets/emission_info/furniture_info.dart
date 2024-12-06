import 'package:flutter/material.dart';

/// Gives more info about furniture emissions
class FurnitureInfo extends StatelessWidget {

  const FurnitureInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: const TextSpan(
        style: TextStyle(color: Colors.black, fontSize: 16), 
        children: [
          TextSpan(text: 'Furniture estimates are based on types of furniture you buy.\n\n'),
          TextSpan(
            text: 'These estimates come from the process of manufacturing and transporting the furniture.\n\n',
          ),
          TextSpan(text: 'All emission estimates are calculated by Climatiq.'),
        ],
      ),
    );
  }
}