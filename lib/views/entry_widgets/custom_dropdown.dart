import 'package:flutter/material.dart';
import 'package:go_green/views/entry_widgets/customizable_input.dart';

/// Widget to create a custom dropdown list
class CustomDropdown<T> extends CustomizableInput {
  /// The function called when the input is changed.
  final Function(T?) onChanged;
  /// The value to display on the dropdown list
  final T? value;
  /// The list of options for the dropdown list
  final List<T> options;

  /// Creates an custom dropdown list.
  /// 
  /// Parameters: 
  ///  - width: The width of the dropdown list
  ///  - onChanged(T?) - the function that's called when the selected item is changed
  ///  - description: the hint text label displayed on the dropdown list
  ///  - fontSize: The font size for text in the dropdown list
  ///  - value: the value to display on the dropdown list
  ///  - fontWeight: The font weight for the items in the dropdown list
  ///  - value: The value to display on the dropdown list
  ///  - options: The list of options for the dropdown list
  ///  - label: the text label displayed above the widget
  ///  - semanticsLabel: the semantics label for the label text
  const CustomDropdown({
    super.key, 
    super.width = 180,
    required this.onChanged, 
    super.description,
    super.fontSize = 16,
    super.fontWeight = FontWeight.w500,
    required this.value,
    required this.options,
    required super.label,
    super.semanticsLabel,
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
          width: width,
          child: Theme(
            data: Theme.of(context).copyWith(
              canvasColor: const Color.fromARGB(255, 224, 214, 186), // Background color when dropdown is open
            ),
            child: DropdownButtonFormField<T>(
              style: const TextStyle(color: Color(0xFF386641)),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromARGB(255, 234, 224, 198), // Dropdown button fill color
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0), // Rounded corners
                  borderSide: BorderSide.none,
                ),
              ),
              hint: Semantics(
                child: Text(
                  description ?? 'Select...', 
                  style: TextStyle(color: const Color(0xFF386641), fontSize: fontSize, fontWeight: fontWeight),
                  semanticsLabel: 'Select from list.',
                ),
              ),
              value: value,
              onChanged: onChanged,
              items: options
                  .map((unit) => DropdownMenuItem<T>(
                        value: unit,
                        child: Text(
                          unit.toString(),
                          style: TextStyle(
                            color: const Color(0xFF386641), // Set text color for dropdown items
                            fontWeight: fontWeight,
                            fontSize: fontSize,
                            overflow: TextOverflow.fade
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}