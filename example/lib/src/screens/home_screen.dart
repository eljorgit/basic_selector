import 'package:example/src/screens/screens.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = 'home';

  static Route route() {
    return PageRouteBuilder(
      settings: const RouteSettings(name: routeName),
      pageBuilder: (_, __, ___) => const HomeScreen(),
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

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Selector Examples'),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.pin_rounded),
              title: const Text('Numeric selector'),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () => Navigator.of(context).pushNamed(NumericExampleScreen.routeName),
            ),
            ListTile(
              leading: const Icon(Icons.abc_rounded),
              title: const Text('Text selector'),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () => Navigator.of(context).pushNamed(TextExampleScreen.routeName),
            ),
            ListTile(
              leading: const Icon(Icons.schedule_rounded),
              title: const Text('Time selectors'),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () => Navigator.of(context).pushNamed(TimeExampleScreen.routeName),
            ),
          ],
        ),
      ),
    );
  }
}
