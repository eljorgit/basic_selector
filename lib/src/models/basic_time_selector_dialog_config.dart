import 'package:flutter/material.dart';

class BasicTimeSelectorDialogConfig {
  final String title;
  final TextStyle titleStyle;
  final String? description;
  final TextStyle? descriptionStyle;
  final Color? backgroundColor;
  final double? elevation;
  final ShapeBorder? shape;
  final Widget Function(TimeOfDay value)? confirmButtonBuilder;
  final String confirmButtonText;
  final Widget Function()? cancelButtonBuilder;
  final String cancelButtonText;

  const BasicTimeSelectorDialogConfig({
    this.title = 'Select a time',
    this.titleStyle = const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    ),
    this.description,
    this.descriptionStyle,
    this.backgroundColor,
    this.elevation,
    this.shape,
    this.confirmButtonBuilder,
    this.confirmButtonText = 'Confirm',
    this.cancelButtonBuilder,
    this.cancelButtonText = 'Cancel',
  });
}
