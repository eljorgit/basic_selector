import 'package:basic_selector/src/models/models.dart';
import 'package:flutter/material.dart';

class BasicTimeSelectorStyle extends BasicSelectorStyle {
  final TextStyle twoDotSeparatorStyle;

  const BasicTimeSelectorStyle({
    this.twoDotSeparatorStyle = const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
  });
}
