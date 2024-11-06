import 'package:flutter/material.dart';

/// The style configuration for [BasicSelector]
class BasicSelectorStyle {
  /// The [TextStyle] or the selected value
  final TextStyle selectedValueTextStyle;

  /// The [TextStyle] for the rest of the values that are not selected
  final TextStyle notSelectedValueTextStyle;

  /// The [BoxDecoration] for the container around the selected value
  ///
  /// Defaults to:
  /// ```dart
  /// BoxDecoration(
  ///   color: Theme.of(context).colorScheme.surface,
  ///   borderRadius: BorderRadius.circular(10),
  ///   border: Border.all(
  ///     color: Theme.of(context).colorScheme.primary,
  ///   ),
  /// )
  /// ```
  final BoxDecoration? selectedValueContainerDecoration;

  /// The [Color] for gradient on the edges of the selector
  ///
  /// Defaults to:
  /// ```dart
  /// Theme.of(context).scaffoldBackgroundColor,
  /// ```
  ///
  /// This builds a [LinearGradient] with this color with two
  /// stops `stops: const [0.3, 1],` with [edgesGradientBackgroundColor]
  /// and [edgesGradientBackgroundColor]`.withAlpha(0)` to create
  /// a fade like gradient
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
