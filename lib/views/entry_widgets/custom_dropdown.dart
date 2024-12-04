import 'package:flutter/material.dart';

/// Widget to create a custom dropdown list
class CustomDropdown<T> extends StatelessWidget {
  /// The function called when the input is changed.
  final Function(T?) onChanged;
  /// The hint text for the dropdown list
  final String hintText;
  /// The font size for text in the dropdown list
  final double fontSize;
  /// The value to display on the dropdown list
  final T? value;
  /// The width of the dropdown list
  final double width;
  /// The list of options for the dropdown list
  final List<T> options;
  /// The font weight for the items in the dropdown list
  final FontWeight fontWeight;

  /// Creates an custom dropdown list.
  /// 
  /// Parameters: 
  ///  - width: The width of the dropdown list
  ///  - onChanged(T?) - the function that's called when the selected item is changed
  ///  - hintText: the hint text displayed on the dropdown list
  ///  - fontSize: The font size for text in the dropdown list
  ///  - value: the value to display on the dropdown list
  ///  - fontWeight: The font weight for the items in the dropdown list
  ///  - value: The value to display on the dropdown list
  ///  - options: The list of options for the dropdown list
  const CustomDropdown({
    super.key, 
    this.width = 180,
    required this.onChanged, 
    this.hintText = 'Select...',
    this.fontSize = 16,
    this.fontWeight = FontWeight.w500,
    required this.value,
    required this.options,
  });

  @override build(BuildContext context) {
    return SizedBox(
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
          hint: Text(
            hintText, 
            style: TextStyle(color: const Color(0xFF386641), fontSize: fontSize, fontWeight: fontWeight)
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
    );
  }
}