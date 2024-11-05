import 'package:basic_selector/basic_selector.dart';
import 'package:flutter/material.dart';

class TextExampleScreen extends StatefulWidget {
  static const String routeName = 'examples/text';

  static Route route() {
    return PageRouteBuilder(
      settings: const RouteSettings(name: routeName),
      pageBuilder: (_, __, ___) => const TextExampleScreen(),
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

  const TextExampleScreen({super.key});

  @override
  State<TextExampleScreen> createState() => _TextExampleScreenState();
}

class _TextExampleScreenState extends State<TextExampleScreen> {
  static final List<String> _titles = [
    '',
    'Mr',
    'Mrs',
    'Miss',
    'Ms',
    'Mx',
    'Sir',
    'Dame',
    'Dr',
    'Lady',
    'Lord',
  ];
  String _selectedTextTitle = '';

  static final List<String> _alphabet = BasicSelectorHelpers.generateAlphabet();
  String _selectedTextLetter = _alphabet.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text selector'),
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
                Text(
                  'Hello $_selectedTextTitle Jorge',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: BasicSelector(
                    items: _titles,
                    value: _selectedTextTitle,
                    textFormatter: (item) {
                      if (item.isEmpty) {
                        return 'Choose a title';
                      }
                      return '$item.';
                    },
                    onChanged: (item) {
                      setState(() {
                        _selectedTextTitle = item;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  'Selected letter: "$_selectedTextLetter" from the alphabet (loop)',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: BasicSelector.loop(
                    items: _alphabet,
                    value: _selectedTextLetter,
                    onChanged: (item) {
                      setState(() {
                        _selectedTextLetter = item;
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
