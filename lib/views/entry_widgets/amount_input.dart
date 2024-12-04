import 'package:flutter/material.dart';

/// Widget to create an input field that accepts numbers
class AmountInput extends StatelessWidget {
  /// The function called when the input is changed
  final Function(String) onChanged;
  /// The text label for the input field
  final String label;
  /// The font size for text in the input field
  final double fontSize;
  /// The font weight for the items in the input field
  final FontWeight fontWeight;
  /// The width of the input field
  final double width;

  /// Creates an input field that accepts numbers.
  /// 
  /// Parameters: 
  ///  - width: The width of the input field 
  ///  - onChanged(String) - the function that's called when the input is changed
  ///  - label: the text label displayed on the input field
  ///  - fontSize: The font size for text in the input field
  ///  - fontWeight: The font weight for the text in the input field
  const AmountInput({
    super.key, 
    this.width = 140,
    required this.onChanged, 
    required this.label,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w500,
  });

  @override build(BuildContext context) {
    return SizedBox(
      width: width, // Set a uniform width
      child: TextField(
        style: TextStyle(color: const Color(0xFF386641), fontSize: fontSize),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: const Color(0xFF386641), fontWeight: fontWeight, fontSize: fontSize),
          filled: true,
          fillColor: const Color.fromARGB(255, 234, 224, 198),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0), 
            borderSide: BorderSide.none,
          ),
        ),
        keyboardType: TextInputType.number,
        onChanged: onChanged,
        onTapOutside: (event) => FocusScope.of(context).unfocus()
      ),
    );
  }
}