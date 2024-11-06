import 'package:basic_selector/src/models/models.dart';
import 'package:flutter/material.dart';

/// The style configuration for [BasicTimeSelector]
class BasicTimeSelectorStyle extends BasicSelectorStyle {
  /// The [TextStyle] for the two dot (`:`) separator that is in the middle of the two selectors
  ///
  /// Defaults to:
  /// ```dart
  /// const TextStyle(
  ///   fontWeight: FontWeight.bold,
  ///   fontSize: 20,
  /// )
  /// ```
  final TextStyle twoDotSeparatorStyle;

  const BasicTimeSelectorStyle({
    this.twoDotSeparatorStyle = const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
    super.edgesGradientBackgroundColor,
    super.notSelectedValueTextStyle,
    super.selectedValueContainerDecoration,
    super.selectedValueTextStyle,
  });
}
