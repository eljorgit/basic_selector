import 'package:basic_selector/basic_selector.dart';
import 'package:flutter/material.dart';

class TimeExampleScreen extends StatefulWidget {
  static const String routeName = 'examples/time';

  static Route route() {
    return PageRouteBuilder(
      settings: const RouteSettings(name: routeName),
      pageBuilder: (_, __, ___) => const TimeExampleScreen(),
      transitionsBuilder: (_, animation, __, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  const TimeExampleScreen({super.key});

  @override
  State<TimeExampleScreen> createState() => _TimeExampleScreenState();
}

class _TimeExampleScreenState extends State<TimeExampleScreen> {
  static final List<TimeOfDay> _times = BasicSelectorHelpers.generateTimes(minuteStep: 5);
  TimeOfDay _selectedTimeBasic = _times.first;
  TimeOfDay _selectedTime = _times.first;
  TimeOfDay _selectedTimeFrom = const TimeOfDay(hour: 13, minute: 30);
  TimeOfDay _selectedTimeTo = const TimeOfDay(hour: 0, minute: 0);
  TimeOfDay _selectedTimeDialog = const TimeOfDay(hour: 0, minute: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Time selector'),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        elevation: 0,
        backgroundColor: Colors.grey[800],
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Scrollbar(
        radius: const Radius.circular(10),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'With basic selector',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'You can build a basic time selector using TimeOfDay and formatting the time. Also, for selecting times you can use BasicSelectorHelpers.generateTimes() with a "from" date and "to" date',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: BasicSelector(
                    items: _times,
                    value: _selectedTimeBasic,
                    textFormatter: (item) {
                      return item.formatted();
                    },
                    onChanged: (item) {
                      setState(() {
                        _selectedTimeBasic = item;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  'With basic time selector: ${_selectedTime.formatted()}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: BasicTimeSelector(
                    time: _selectedTime,
                    textFormatter: (item) {
                      return item.formatted();
                    },
                    onChanged: (item) {
                      setState(() {
                        _selectedTime = item;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  'With basic time selector from 13:30 : ${_selectedTimeFrom.formatted()}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: BasicTimeSelector(
                    time: _selectedTimeFrom,
                    currentTime: const TimeOfDay(hour: 13, minute: 30),
                    config: const BasicTimeSelectorConfig(showOnlyFromCurrentType: true),
                    textFormatter: (item) {
                      return item.formatted();
                    },
                    onChanged: (item) {
                      setState(() {
                        _selectedTimeFrom = item;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  'With basic time selector to 13:30 : ${_selectedTimeTo.formatted()}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: BasicTimeSelector(
                    time: _selectedTimeTo,
                    currentTime: const TimeOfDay(hour: 13, minute: 30),
                    config: const BasicTimeSelectorConfig(showOnlyToCurrentType: true),
                    textFormatter: (item) {
                      return item.formatted();
                    },
                    onChanged: (item) {
                      setState(() {
                        _selectedTimeTo = item;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  'With basic time selector from dialog: ${_selectedTimeDialog.formatted()}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Center(
                  child: FilledButton(
                    onPressed: () => BasicTimeSelector.showModalDialog(
                      context,
                      time: _selectedTimeDialog,
                    ).then((value) {
                      if (value != null) {
                        setState(() {
                          _selectedTimeDialog = value;
                        });

                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(SnackBar(
                            content: Text(
                              'Date selected: ${_selectedTimeDialog.formatted()}',
                            ),
                            behavior: SnackBarBehavior.floating,
                          ));
                      }
                    }),
                    child: const Text('Open dialog'),
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  'With basic time selector from styled dialog: ${_selectedTimeDialog.formatted()}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Center(
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    onPressed: () => BasicTimeSelector.showModalDialog(
                      context,
                      time: _selectedTimeDialog,
                      styles: BasicTimeSelectorStyle(
                        edgesGradientBackgroundColor: Colors.green,
                        selectedValueContainerDecoration: BoxDecoration(
                          color: Colors.green[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      dialogConfig: const BasicTimeSelectorDialogConfig(
                          backgroundColor: Colors.green,
                          description:
                              'This is a description, you can specify here maybe for what will this time used.\n\n'
                              'PD.: I know this style is ugly, but it is just an example XD'),
                    ).then((value) {
                      if (value != null) {
                        setState(() {
                          _selectedTimeDialog = value;
                        });

                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(SnackBar(
                            content: Text(
                              'Date selected: ${_selectedTimeDialog.formatted()}',
                            ),
                            behavior: SnackBarBehavior.floating,
                          ));
                      }
                    }),
                    child: const Text('Open dialog'),
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  'With basic time selector from dialog with a custom builder: ${_selectedTimeDialog.formatted()}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Center(
                  child: FilledButton(
                    onPressed: () => BasicTimeSelector.showModalDialog(
                      context,
                      time: _selectedTimeDialog,
                      dialogConfig: BasicTimeSelectorDialogConfig(
                        cancelButtonText: '',
                        confirmButtonText: '',
                        builder: (basicTimeSelector, selectedTime) {
                          return Column(
                            children: [
                              const Text('Press this button to select now time'),
                              FilledButton.icon(
                                onPressed: () => Navigator.of(context).pop(TimeOfDay.now()),
                                label: const Text('Now'),
                                icon: const Icon(Icons.schedule),
                              ),
                              const SizedBox(height: 10),
                              basicTimeSelector,
                              const SizedBox(height: 10),
                              const Text(
                                  'And now the confirm and cancel button will be hidden, because the text on each one is empty, and some custom confirm and cancel buttons used instead.'),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: FilledButton.icon(
                                      style: FilledButton.styleFrom(
                                        backgroundColor: Colors.red,
                                        foregroundColor: Colors.white,
                                      ),
                                      onPressed: () => Navigator.of(context).pop(null),
                                      label: const Text('Cancel'),
                                      icon: const Icon(Icons.close),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: FilledButton.icon(
                                      style: FilledButton.styleFrom(
                                        backgroundColor: Colors.blue,
                                      ),
                                      onPressed: () => Navigator.of(context).pop(selectedTime),
                                      label: const Text('Save'),
                                      icon: const Icon(Icons.save),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    ).then((value) {
                      if (value != null) {
                        setState(() {
                          _selectedTimeDialog = value;
                        });

                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(SnackBar(
                            content: Text(
                              'Date selected: ${_selectedTimeDialog.formatted()}',
                            ),
                            behavior: SnackBarBehavior.floating,
                          ));
                      }
                    }),
                    child: const Text('Open dialog'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
