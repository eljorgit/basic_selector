import 'package:basic_selector/basic_selector.dart';
import 'package:flutter/material.dart';

class BasicTimeSelector extends StatefulWidget {
  final TimeOfDay time;
  final TimeOfDay? currentTime;
  final ValueChanged<TimeOfDay> onChanged;
  final String Function(TimeOfDay item)? textFormatter;
  final double height;
  final BasicTimeSelectorStyle styles;
  final BasicTimeSelectorConfig config;
  final bool loop;

  const BasicTimeSelector({
    super.key,
    required this.time,
    this.currentTime,
    required this.onChanged,
    this.textFormatter,
    this.height = 200,
    this.styles = const BasicTimeSelectorStyle(),
    this.config = const BasicTimeSelectorConfig(),
    this.loop = false,
  });

  @override
  State<BasicTimeSelector> createState() => _BasicTimeSelectorState();
}

class _BasicTimeSelectorState extends State<BasicTimeSelector> {
  List<int> _hours = [];
  List<int> _minutes = [];
  TimeOfDay? currentTime;

  @override
  void initState() {
    currentTime = widget.currentTime ?? TimeOfDay.now();
    initTimeLists();
    super.initState();
  }

  void initTimeLists() {
    _hours = BasicSelectorHelpers.generateNumbers(end: 24);
    _minutes = BasicSelectorHelpers.generateNumbers(end: 60, step: _config.minuteStep);
  }

  void _updateTimeLists() {
    if (_config.showOnlyFromCurrentType) {
      _hours = BasicSelectorHelpers.generateNumbers(start: currentTime!.hour, end: 24);

      if (widget.time.hour == currentTime!.hour) {
        _minutes = BasicSelectorHelpers.generateNumbers(
          start: currentTime!.minute,
          end: 60,
          step: _config.minuteStep,
        );
      } else {
        _minutes = BasicSelectorHelpers.generateNumbers(end: 60, step: _config.minuteStep);
      }
    }
  }

  BasicTimeSelectorStyle get _styles => widget.styles;
  BasicTimeSelectorConfig get _config => widget.config;

  bool get _needsUpdate => _config.showOnlyFromCurrentType || _config.showOnlyToCurrentType;

  @override
  Widget build(BuildContext context) {
    if (_needsUpdate) {
      _updateTimeLists();
    }
    return SizedBox(
      height: widget.height,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Expanded(
            child: BasicSelector(
              items: _hours,
              value: widget.time.hour,
              textFormatter: (item) => item.toString().padLeft(2, '0'),
              onChanged: (hour) {
                final time = TimeOfDay(hour: hour, minute: widget.time.minute);

                widget.onChanged(time);
              },
              styles: _styles,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              ':',
              style: _styles.twoDotSeparatorStyle,
            ),
          ),
          Expanded(
            child: BasicSelector(
              items: _minutes,
              value: widget.time.minute,
              textFormatter: (item) => item.toString().padLeft(2, '0'),
              onChanged: (minute) {
                final time = TimeOfDay(hour: widget.time.hour, minute: minute);

                widget.onChanged(time);
              },
              styles: _styles,
            ),
          )
        ],
      ),
    );
  }
}
