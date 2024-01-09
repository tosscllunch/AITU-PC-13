import 'dart:io';

import 'package:flutter_application_1/alarm/providers/alarm_provider.dart';
import 'package:flutter_application_1/alarm/providers/clock_type_provider.dart';
import 'package:flutter_application_1/alarm/providers/theme_provider.dart';
import 'package:flutter_application_1/alarm/screens/modify_alarm_screen.dart';
import 'package:flutter_application_1/alarm/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest_all.dart';
import 'package:timezone/timezone.dart';

import 'models/alarm_hive_storage.dart';
import 'screens/home_screen.dart';

class AlarmPage extends StatefulWidget {
  const AlarmPage({Key? key}) : super(key: key);

  @override
  State<AlarmPage> createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    _setUpLocalNotification();
    _requestPermissions();
    super.initState();
  }

  void _requestPermissions() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  void _setUpLocalNotification() async {
    await _configureLocalTimeZone();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    /// Note: permissions aren't requested here just to demonstrate that can be
    /// done later
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestSoundPermission: true,
            onDidReceiveLocalNotification: (
              int id,
              String? title,
              String? body,
              String? payload,
            ) async {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(title ?? ''),
                  content: Text(body ?? ''),
                ),
              );
            });

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        debugPrint('notification payload: $payload');
      }
    });
  }

  Future<void> _configureLocalTimeZone() async {
    if (kIsWeb || Platform.isLinux) {
      return;
    }
    initializeTimeZones();
    final String? timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    setLocalLocation(getLocation(timeZoneName!));
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => ThemeModel()),
            ChangeNotifierProvider(create: (context) => ClockTypeModel()),
            ChangeNotifierProvider(
              create: (context) => AlarmModel(
                const AlarmsHiveLocalStorage(),
              ),
            ),
          ],
          child: Consumer<ThemeModel>(
            builder: (context, theme, child) => MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Analog Clock',
              theme: themeData(context),
              darkTheme: darkThemeData(context),
              themeMode: theme.isLightTheme ? ThemeMode.light : ThemeMode.dark,
              builder: (context, child) {
                return child ?? Container();
              },
              onGenerateRoute: (settings) {
                switch (settings.name) {
                  case '/':
                    return MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    );
                  case ModifyAlarmScreen.routeName:
                    return MaterialPageRoute(
                      builder: (context) => ModifyAlarmScreen(
                        arg: settings.arguments as ModifyAlarmScreenArg?,
                      ),
                    );
                }
                return null;
              },
            ),
          )),
    );
  }
}
