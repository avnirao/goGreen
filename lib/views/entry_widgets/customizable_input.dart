import 'package:flutter/material.dart';

/// Abstract class for the customizable input widgets used in this app (dropdowns and text fields)
abstract class CustomizableInput extends StatelessWidget{
  /// The text label for the widget
  final String? description;
  /// The font size for the widget
  final double fontSize;
  /// The font weight for the items in the widget
  final FontWeight fontWeight;
  /// The width of the widget
  final double width;
  /// The text label for the widget
  final String label;
  /// the semantic label for the text on the widget
  final String? semanticsLabel;

  /// Creates a Customizable Input
  /// 
  /// Parameters: 
  ///  - width: The width of the widget
  ///  - description: the helper description of the widget
  ///  - fontSize: The font size for text in the widget
  ///  - fontWeight: The font weight for the text in the widget
  ///  - label: the text label displayed on the widget
  ///  - semanticLabel: the semantic label for the text on the widget
  const CustomizableInput({
    super.key,
    required this.width,
    required this.description, 
    required this.fontSize,
    required this.fontWeight,
    required this.label,
    this.semanticsLabel
  });
}