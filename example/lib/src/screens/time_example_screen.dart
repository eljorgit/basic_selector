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
  TimeOfDay _selectedTimeFrom = _times.first;

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
                      return '${item.hour.toString().padLeft(2, '0')}:${item.minute.toString().padLeft(2, '0')}';
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
                  'With basic time selector: ${_selectedTime.format(context)}',
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
                      return '${item.hour.toString().padLeft(2, '0')}:${item.minute.toString().padLeft(2, '0')}';
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
                  'With basic time selector from 13:30 : ${_selectedTimeFrom.format(context)}',
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
                      return '${item.hour.toString().padLeft(2, '0')}:${item.minute.toString().padLeft(2, '0')}';
                    },
                    onChanged: (item) {
                      setState(() {
                        _selectedTimeFrom = item;
                      });
                    },
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
