import 'package:basic_selector/src/widgets/widgets.dart';
import 'package:flutter/material.dart';

class BasicTimeSelectorDialogConfig {
  /// A title for the dialog
  final String title;

  /// The [TextStyle] for the title of the dialog
  final TextStyle titleStyle;

  ///  A description for the dialog, that goes right below the [title]
  final String? description;

  /// The [TextStyle] for the description of the dialog
  ///
  /// Defaults to:
  /// ```dart
  /// TextStyle(
  ///   fontSize: 12,
  ///   color: Colors.grey[600],
  /// )
  /// ```
  final TextStyle? descriptionStyle;

  /// The background color for the dialog
  final Color? backgroundColor;

  /// The elevation for the dialog
  final double? elevation;

  /// The shape for the dialog
  ///
  /// Defaults to:
  /// ```dart
  /// RoundedRectangleBorder(
  ///   borderRadius: BorderRadius.circular(10),
  /// )
  /// ```
  final ShapeBorder? shape;

  /// A builder for the confirm button, if not provided a
  /// default [TextButton] will be used
  ///
  /// This function returns the [TimeOfDay] selected on the [BasicTimeSelector]
  final Widget Function(TimeOfDay value)? confirmButtonBuilder;

  /// The text used for the confirm button
  /// (ignored if [confirmButtonBuilder] is used)
  ///
  /// If this value is empty (eg.: `''`) the button will be hidden.
  final String confirmButtonText;

  /// A builder for the cancel button, if not provided a
  /// default [TextButton] will be used
  final Widget Function()? cancelButtonBuilder;

  /// The text used for the cancel button
  /// (ignored if [cancelButtonBuilder] is used)
  ///
  /// If this value is empty (eg.: `''`) the button will be hidden.
  final String cancelButtonText;

  /// The padding for for the actions (the confirm and cancel buttons,
  /// or the builders) and for the content
  ///
  /// Defaults to only on actions padding:
  /// ```dart
  /// const EdgeInsets.only(left: 15, right: 15, bottom: 15)
  /// ```
  final EdgeInsets? padding;

  /// This is a [Builder] for the content of the dialog, the parameter `value`
  /// is the [BasicTimeSelector] you should use in the builder.
  final Widget Function(BasicTimeSelector basicTimeSelector, TimeOfDay? selectedTime)? builder;

  /// Extra content that will go right below the [BasicTimeSelector] on the dialog
  final List<Widget> extraContent;

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
    this.padding,
    this.builder,
    this.extraContent = const [],
  });
}
