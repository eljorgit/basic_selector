import 'package:flutter/material.dart';

/// Configuration for [BasicTimeSelector]
class BasicTimeSelectorConfig {
  /// Shows only the times from the selected [currentTime]
  final bool showOnlyFromCurrentType;

  /// Shows only the times to the selected [currentTime]
  final bool showOnlyToCurrentType;

  /// Interval for the generated minutes **(must be a divider of 60)**
  final int minuteStep;

  /// The start date when generating times
  final TimeOfDay? startTime;

  /// The end date when generating times
  final TimeOfDay? endTime;

  const BasicTimeSelectorConfig({
    this.showOnlyFromCurrentType = false,
    this.showOnlyToCurrentType = false,
    this.minuteStep = 1,
    this.startTime,
    this.endTime,
  });
}
