import 'package:basic_selector/src/extensions/time_of_day_extensions.dart';
import 'package:flutter/material.dart';

class BasicSelectorHelpers {
  static List<T> generateNumbers<T extends num>({
    T? start,
    required T end,
    T? step,
  }) {
    List<T> range = [];
    T current = start ?? (T == int ? 0 as T : 0.0 as T);
    T interval = step ?? (T == int ? 1 as T : 1.0 as T);

    while (
        (interval > 0 && current <= end) || (interval < 0 && current >= end)) {
      range.add(current);
      current =
          (T == int) ? (current + interval) as T : (current + interval) as T;
    }

    return range;
  }

  static List<String> generateAlphabet() {
    var aCode = 'A'.codeUnitAt(0);
    var zCode = 'Z'.codeUnitAt(0);
    List<String> alphabet = List<String>.generate(
      zCode - aCode + 1,
      (index) => String.fromCharCode(aCode + index),
    );

    return alphabet;
  }

  static List<TimeOfDay> generateTimes({
    TimeOfDay? from,
    TimeOfDay? to,
    int minuteStep = 1,
  }) {
    if (60 % minuteStep != 0)
      throw Exception('MinuteStep must be a divider of 60');

    const totalHours = TimeOfDay.hoursPerDay;
    const totalMinutes = TimeOfDay.minutesPerHour;

    final countMinutes = totalMinutes ~/ minuteStep;
    final totalTimes = countMinutes * totalHours;

    var currentTime = const TimeOfDay(hour: 00, minute: 00);

    List<TimeOfDay> results = [currentTime];

    for (var i = 0; i < totalTimes; i++) {
      currentTime = currentTime.add(minuteStep);

      if (from != null && currentTime.isBefore(from)) {
        continue;
      }

      if (to != null && currentTime.isAfter(to)) {
        continue;
      }

      results.add(currentTime);
    }

    return results;
  }
}
