import 'package:flutter/material.dart';

class BasicTimeSelectorConfig {
  final bool showOnlyFromCurrentType;
  final bool showOnlyToCurrentType;
  final int minuteStep;
  final TimeOfDay? startTime;
  final TimeOfDay? endTime;
  final bool liveChange;

  const BasicTimeSelectorConfig({
    this.showOnlyFromCurrentType = false,
    this.showOnlyToCurrentType = false,
    this.minuteStep = 1,
    this.startTime,
    this.endTime,
    this.liveChange = false,
  });

  BasicTimeSelectorConfig copyWith({
    bool? showOnlyFromCurrentType,
    bool? showOnlyToCurrentType,
    int? minuteStep,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    bool? liveChange,
  }) {
    return BasicTimeSelectorConfig(
      showOnlyFromCurrentType: showOnlyFromCurrentType ?? this.showOnlyFromCurrentType,
      showOnlyToCurrentType: showOnlyToCurrentType ?? this.showOnlyToCurrentType,
      minuteStep: minuteStep ?? this.minuteStep,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      liveChange: liveChange ?? this.liveChange,
    );
  }
}
