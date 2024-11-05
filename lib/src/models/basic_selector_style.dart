import 'package:flutter/material.dart';

class BasicSelectorStyle {
  final TextStyle selectedValueTextStyle;
  final TextStyle notSelectedValueTextStyle;
  final BoxDecoration? selectedValueContainerDecoration;
  final Color? bordersGradientBackgroundColor;

  const BasicSelectorStyle({
    this.selectedValueTextStyle = const TextStyle(
      fontWeight: FontWeight.bold,
    ),
    this.notSelectedValueTextStyle = const TextStyle(
      fontWeight: FontWeight.normal,
    ),
    this.selectedValueContainerDecoration,
    this.bordersGradientBackgroundColor,
  });

  BasicSelectorStyle copyWith({
    TextStyle? selectedValueTextStyle,
    TextStyle? notSelectedValueTextStyle,
    BoxDecoration? selectedValueContainerDecoration,
    Color? bordersGradientBackgroundColor,
  }) {
    return BasicSelectorStyle(
      selectedValueTextStyle: selectedValueTextStyle ?? this.selectedValueTextStyle,
      notSelectedValueTextStyle: notSelectedValueTextStyle ?? this.notSelectedValueTextStyle,
      selectedValueContainerDecoration:
          selectedValueContainerDecoration ?? this.selectedValueContainerDecoration,
      bordersGradientBackgroundColor:
          bordersGradientBackgroundColor ?? this.bordersGradientBackgroundColor,
    );
  }
}
