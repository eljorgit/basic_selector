import 'package:basic_selector/basic_selector.dart';
import 'package:flutter/material.dart';

class NumericExampleScreen extends StatefulWidget {
  static const String routeName = 'examples/numeric';

  static Route route() {
    return PageRouteBuilder(
      settings: const RouteSettings(name: routeName),
      pageBuilder: (_, __, ___) => const NumericExampleScreen(),
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

  const NumericExampleScreen({super.key});

  @override
  State<NumericExampleScreen> createState() => _NumericExampleScreenState();
}

class _NumericExampleScreenState extends State<NumericExampleScreen> {
  static final List<int> _numbers = BasicSelectorHelpers.generateNumbers(end: 100);
  int _selectedNumberBasic = 0;
  int _selectedNumberStyled1 = 0;
  int _selectedNumberStyled2 = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Numeric selector'),
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
                  'Selectors for numbers from 0 to 100',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Basic Selector. Selected number: $_selectedNumberBasic',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: BasicSelector(
                    items: _numbers,
                    value: _selectedNumberBasic,
                    onChanged: (item) {
                      setState(() {
                        _selectedNumberBasic = item;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  'Selected the number of items: $_selectedNumberStyled1',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'You can customize the selector with custom styles for the selected value or the rest. Also format the text shown on the selector with a text formatter. In this case by adding "X items".',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: BasicSelector(
                    items: _numbers,
                    value: _selectedNumberStyled1,
                    onChanged: (item) {
                      setState(() {
                        _selectedNumberStyled1 = item;
                      });
                    },
                    textFormatter: (item) {
                      if (item == 1) {
                        return '1 item';
                      } else {
                        return '$item items';
                      }
                    },
                    styles: const BasicSelectorStyle(
                      selectedValueTextStyle: TextStyle(
                        fontSize: 24,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                      notSelectedValueTextStyle: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  'Select timer hours',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Also customize the container for the selected item.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: BasicSelector(
                    items: _numbers,
                    value: _selectedNumberStyled2,
                    onChanged: (item) {
                      setState(() {
                        _selectedNumberStyled2 = item;
                      });
                    },
                    textFormatter: (item) => '$item h',
                    styles: const BasicSelectorStyle(
                      selectedValueTextStyle: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      notSelectedValueTextStyle: TextStyle(
                        color: Colors.blue,
                      ),
                      selectedValueContainerDecoration: BoxDecoration(
                        color: Colors.blue,
                      ),
                    ),
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
