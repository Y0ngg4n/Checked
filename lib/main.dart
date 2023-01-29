import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'navigation.dart';

/// A notification action which triggers a App navigation event
const String navigationActionId = 'id_3';

final StreamController<String?> selectNotificationStream =
    StreamController<String?>.broadcast();

Future<void> main() async {
  // needed if you intend to initialize in the `main` function
  WidgetsFlutterBinding.ensureInitialized();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');
  // final DarwinInitializationSettings initializationSettingsDarwin =
  //     DarwinInitializationSettings(
  //         onDidReceiveLocalNotification: onDidReceiveLocalNotification);
  // final LinuxInitializationSettings initializationSettingsLinux =
  //     LinuxInitializationSettings(defaultActionName: 'Open notification');
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );
  // iOS: initializationSettingsDarwin,
  // macOS: initializationSettingsDarwin,);
  // linux: initializationSettingsLinux);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
    switch (notificationResponse.notificationResponseType) {
      case NotificationResponseType.selectedNotification:
        selectNotificationStream.add(notificationResponse.payload);
        break;
      case NotificationResponseType.selectedNotificationAction:
        if (notificationResponse.actionId == navigationActionId) {
          selectNotificationStream.add(notificationResponse.payload);
        }
        break;
    }
  });
  runApp(const Checked());
}

class Checked extends StatelessWidget {
  const Checked({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();

    return MaterialApp(
      title: 'Checked',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
          primaryColor: Colors.blue),
      home: Navigation(flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin,),
    );
  }
}
