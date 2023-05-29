import 'package:client/app/config/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../routers/routers.dart';

class AppConfig extends StatefulWidget {
  const AppConfig({Key? key}) : super(key: key);

  @override
  State<AppConfig> createState() => _AppConfigState();
}

class _AppConfigState extends State<AppConfig> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return MaterialApp(
      title: 'Go Flutter',
      debugShowCheckedModeBanner: false,
      theme: themeDataMethod(),
      initialRoute: Routes.home,
      routes: Routes.list,
      navigatorKey: Routes.navigatorKey,
    );
  }
}
