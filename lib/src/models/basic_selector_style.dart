import 'package:flutter/material.dart';

class BasicSelectorStyle {
  final TextStyle selectedValueTextStyle;
  final TextStyle notSelectedValueTextStyle;
  final BoxDecoration? selectedValueContainerDecoration;
  final Color? edgesGradientBackgroundColor;

  const BasicSelectorStyle({
    this.selectedValueTextStyle = const TextStyle(
      fontWeight: FontWeight.bold,
    ),
    this.notSelectedValueTextStyle = const TextStyle(
      fontWeight: FontWeight.normal,
    ),
    this.selectedValueContainerDecoration,
    this.edgesGradientBackgroundColor,
  });
}
