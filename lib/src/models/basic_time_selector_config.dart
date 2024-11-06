import 'package:flutter/material.dart';

class BasicTimeSelectorConfig {
  final bool showOnlyFromCurrentType;
  final bool showOnlyToCurrentType;
  final int minuteStep;
  final TimeOfDay? startTime;
  final TimeOfDay? endTime;

  const BasicTimeSelectorConfig({
    this.showOnlyFromCurrentType = false,
    this.showOnlyToCurrentType = false,
    this.minuteStep = 1,
    this.startTime,
    this.endTime,
  });
}
