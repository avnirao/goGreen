import 'package:flutter/material.dart';
import 'package:go_green/views/entry_widgets/customizable_input.dart';

/// Widget to create an input field that accepts numbers
class AmountInput extends CustomizableInput {
  /// The function called when the input is changed
  final Function(String) onChanged;
  final double initialAmount;

  /// Creates an input field that accepts numbers.
  /// 
  /// Parameters: 
  ///  - width: The width of the input field 
  ///  - onChanged(String) - the function that's called when the input is changed
  ///  - description: the helper text label displayed on the input field
  ///  - fontSize: The font size for text in the input field
  ///  - fontWeight: The font weight for the text in the input field
  ///  - label: the text label displayed above the widget
  ///  - semanticsLabel: the semantics label for the label text
  const AmountInput({
    super.key, 
    super.width = 140,
    required this.onChanged, 
    required super.description,
    super.fontSize = 16,
    super.fontWeight = FontWeight.w500,
    required super.label,
    super.semanticsLabel,
    required this.initialAmount,
  });

  @override build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Semantics(
          child: Text(
            label, 
            style: TextStyle(color: const Color(0xFF386641), fontSize: fontSize),
            semanticsLabel: semanticsLabel ?? label,
          )
        ),
        SizedBox(
          width: width, // Set a uniform width
          child: TextFormField(
            initialValue: '$initialAmount',
            style: TextStyle(color: const Color(0xFF386641), fontSize: fontSize),
            decoration: InputDecoration(
              labelText: description,
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
        ),
      ],
    );
  }
}