import 'package:flutter/material.dart';
import 'package:go_green/views/entry_widgets/customizable_input.dart';

/// Widget to create a custom dropdown menu
class EmissionDropdownMenu<T> extends CustomizableInput {
  /// The function called when the input is changed.
  final Function(T?) onSelected;
  /// The initial value to display on the dropdown menu
  final T initialSelection;
  /// The list of options for the dropdown menu
  final List<DropdownMenuEntry<T>> options;

  /// Creates an custom dropdown menu.
  /// 
  /// Parameters: 
  ///  - width: The width of the dropdown menu
  ///  - onSelected(T?) - the function that's called when the selected item is changed
  ///  - fontSize: The font size for text in the dropdown menu
  ///  - value: the value to display on the dropdown menu
  ///  - fontWeight: The font weight for the items in the dropdown menu
  ///  - value: The value to display on the dropdown menu
  ///  - options: The list of options for the dropdown menu
  ///  - label: the text label displayed above the widget
  ///  - semanticsLabel: the semantics label for the label text
  const EmissionDropdownMenu({
    super.key, 
    super.width = 170,
    required this.onSelected, 
    super.fontSize = 16,
    super.fontWeight = FontWeight.w500,
    required this.initialSelection,
    required this.options,
    required super.label,
    super.semanticsLabel
  }): super(description: null);

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
          width: width, // Set uniform width for dropdown and button
          child: DropdownMenu<T>(
            initialSelection: initialSelection,
            dropdownMenuEntries: options,
            onSelected: onSelected,
            textStyle: TextStyle(color: const Color(0xFF386641), fontWeight: fontWeight, fontSize: fontSize),
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: const Color.fromARGB(255, 234, 224, 198), // Background color
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0), // Rounded corners
                borderSide: BorderSide.none, // Remove border
              ),
            ),
            menuStyle: MenuStyle(
              backgroundColor: WidgetStateProperty.all<Color>(const Color(0xFFF2E8CF)), // Menu background color
              elevation: WidgetStateProperty.all<double>(5.0), // Elevation for shadow
              padding: WidgetStateProperty.all<EdgeInsets>(
                const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}