import 'package:flutter/material.dart';

import '../../view/create_task_form_screen.dart';
import '../../view/home_screen.dart';
import '../../view/task_done_screen.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> list =
      <String, WidgetBuilder>{
    '/home': (context) => const HomeScreen(),
    '/createTask': (context) => const CreateTaskFormScreen(),
    '/done': (context) => const TaskDoneScreen(),
  };

  static String home = '/home';
  static String createTask = '/createTask';
  static String done = '/done';

  static GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();
}
