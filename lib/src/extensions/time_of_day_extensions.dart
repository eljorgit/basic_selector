import 'package:flutter/material.dart';

extension TimeOfDayExtensions on TimeOfDay {
  TimeOfDay add(int minutes) {
    if (minutes == 0) {
      return this;
    } else {
      int time = hour * 60 + minute;
      int newTime = ((minutes % 1440) + time + 1440) % 1440;
      if (time == newTime) {
        return this;
      } else {
        int newHour = newTime ~/ 60;
        int newMinute = newTime % 60;
        return TimeOfDay(hour: newHour, minute: newMinute);
      }
    }
  }

  double toDouble() => hour + minute / 60.0;

  bool isAfter(TimeOfDay other) {
    return toDouble() > other.toDouble();
  }

  bool isBefore(TimeOfDay other) {
    return toDouble() < other.toDouble();
  }
}
