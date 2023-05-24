import 'package:flutter/material.dart';

import '../../screens/create_task_form_screen.dart';
import '../../screens/home_screen.dart';
 

class Routes {
  static Map<String, Widget Function(BuildContext)> list =
      <String, WidgetBuilder>{
    '/home': (context) => const HomeScreen(),
    '/createTask': (context) => const CreateTaskFormScreen(),
  };

  static String home = '/home';
  static String createTask = '/createTask';
  static String done = '/done';

  static GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();
}
