import 'package:flutter/material.dart';

import '../../screens/home_screen.dart';
 

class Routes {
  static Map<String, Widget Function(BuildContext)> list =
      <String, WidgetBuilder>{
    '/home': (context) => const HomeScreen(),
  };

  static String home = '/home';

  static GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();
}
