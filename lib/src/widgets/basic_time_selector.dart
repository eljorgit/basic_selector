import 'package:animations/animations.dart';
import 'package:basic_selector/basic_selector.dart';
import 'package:flutter/material.dart';

/// This [BasicTimeSelector] uses two [BasicSelector] with
/// a [TimeOfDay] type.
///
/// Returns a [TimeOfDay] from the hour and minutes
/// selected from each selector.
class BasicTimeSelector extends StatefulWidget {
  /// The selected [time] value
  final TimeOfDay time;

  /// In case is needed a different time from `TimeOfDay.now()`
  ///
  /// Defaults to `TimeOfDay.now()`
  final TimeOfDay? currentTime;

  /// A void callback function that runs when the selector changes
  final ValueChanged<TimeOfDay> onChanged;

  /// A way to format the text shown on the selector
  final String Function(TimeOfDay item)? textFormatter;

  /// The height of the selector
  final double height;

  /// A way to style the [BasicTimeSelector]
  final BasicTimeSelectorStyle styles;

  /// A way to configure the [BasicTimeSelector]
  final BasicTimeSelectorConfig config;

  /// Enables infinite scroll for the generated times
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

  /// Shows a modal dialog with a [BasicTimeSelector]
  static Future<TimeOfDay?> showModalDialog(
    BuildContext context, {
    required TimeOfDay time,
    TimeOfDay? currentTime,
    String Function(TimeOfDay item)? textFormatter,
    double height = 200,
    BasicTimeSelectorStyle styles = const BasicTimeSelectorStyle(),
    BasicTimeSelectorConfig config = const BasicTimeSelectorConfig(),
    BasicTimeSelectorDialogConfig dialogConfig = const BasicTimeSelectorDialogConfig(),
    bool loop = false,
  }) async {
    return await showModal<TimeOfDay>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            final basicTimeSelector = BasicTimeSelector(
              time: time,
              currentTime: currentTime,
              onChanged: (value) {
                setState(() {
                  time = value;
                });
              },
              textFormatter: textFormatter,
              height: height,
              styles: styles,
              config: config,
              loop: loop,
            );

            return AlertDialog(
              elevation: dialogConfig.elevation,
              backgroundColor: dialogConfig.backgroundColor,
              shape: dialogConfig.shape ??
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (dialogConfig.title.isNotEmpty)
                    Text(
                      dialogConfig.title,
                      style: dialogConfig.titleStyle,
                    ),
                  if (dialogConfig.description != null && dialogConfig.description!.isNotEmpty)
                    Text(
                      dialogConfig.description!,
                      style: dialogConfig.descriptionStyle ??
                          TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  if (dialogConfig.builder != null)
                    dialogConfig.builder!(
                      basicTimeSelector,
                      time,
                    )
                  else
                    basicTimeSelector,
                  ...dialogConfig.extraContent
                ],
              ),
              contentPadding: dialogConfig.padding,
              actionsPadding:
                  dialogConfig.padding ?? const EdgeInsets.only(left: 15, right: 15, bottom: 15),
              actions: [
                if (dialogConfig.cancelButtonBuilder != null)
                  dialogConfig.cancelButtonBuilder!()
                else if (dialogConfig.cancelButtonText.isNotEmpty)
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: TextButton.styleFrom(
                      overlayColor: Colors.red,
                      foregroundColor: Colors.red,
                    ),
                    child: Text(
                      dialogConfig.cancelButtonText,
                    ),
                  ),
                if (dialogConfig.confirmButtonBuilder != null)
                  dialogConfig.confirmButtonBuilder!(time)
                else if (dialogConfig.confirmButtonText.isNotEmpty)
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(time),
                    style: TextButton.styleFrom(
                      overlayColor: Colors.blue,
                      foregroundColor: Colors.blue,
                    ),
                    child: Text(
                      dialogConfig.confirmButtonText,
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  State<BasicTimeSelector> createState() => _BasicTimeSelectorState();
}

class _BasicTimeSelectorState extends State<BasicTimeSelector> {
  List<int> _hours = [];
  List<int> _minutes = [];
  TimeOfDay _currentTime = const TimeOfDay(hour: 00, minute: 00);

  bool _reverseMinutes = false;

  @override
  void initState() {
    _currentTime = widget.currentTime ?? TimeOfDay.now();
    initTimeLists();
    super.initState();
  }

  void initTimeLists() {
    _hours = BasicSelectorHelpers.generateNumbers(end: 23);
    _minutes = BasicSelectorHelpers.generateNumbers(end: 59, step: _config.minuteStep);
  }

  void _updateTimeLists() {
    if (_config.showOnlyFromCurrentType) {
      _hours = BasicSelectorHelpers.generateNumbers(start: _currentTime.hour, end: 23);

      if (widget.time.hour == _currentTime.hour) {
        _minutes = BasicSelectorHelpers.generateNumbers(
          start: _currentTime.minute,
          end: 59,
          step: _config.minuteStep,
        ).reversed.toList();
        _reverseMinutes = true;
      } else {
        _minutes = BasicSelectorHelpers.generateNumbers(end: 59, step: _config.minuteStep);
        _reverseMinutes = false;
      }
    }
    if (_config.showOnlyToCurrentType) {
      _hours = BasicSelectorHelpers.generateNumbers(start: 00, end: _currentTime.hour);

      if (widget.time.hour == _currentTime.hour) {
        _minutes = BasicSelectorHelpers.generateNumbers(
          start: 0,
          end: _currentTime.minute,
          step: _config.minuteStep,
        );
      } else {
        _minutes = BasicSelectorHelpers.generateNumbers(end: 59, step: _config.minuteStep);
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
              reversed: _reverseMinutes,
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
