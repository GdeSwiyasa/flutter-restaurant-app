import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/database_service.dart';
import 'package:restaurant_app/data/utils/background_service.dart';
import 'package:restaurant_app/data/utils/notification_helper.dart';
import 'package:restaurant_app/provider/favorite_provider.dart';
import 'package:restaurant_app/screen/detailpage.dart';
import 'package:restaurant_app/screen/favorite_page.dart';
import 'package:restaurant_app/screen/homepage.dart';
import 'package:restaurant_app/screen/search_page.dart';
import 'package:restaurant_app/screen/settings_page.dart';

import 'package:restaurant_app/screen/splashscreen.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();
  _service.initializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);
  runApp(
    OverlaySupport.global(
      child: ChangeNotifierProvider(
        create: (_) => FavoriteProvider(databaseService: DatabaseService()),
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          initialRoute: HomePage.routeName,
          routes: {
            // SplashScreen.routeName: (context) => SplashScreen(),
            HomePage.routeName: (context) => HomePage(),
            DetailPage.routeName: (context) => DetailPage(
                  restaurant_id:
                      ModalRoute.of(context)?.settings.arguments as String,
                ),
            SearchPage.routeName: (context) => SearchPage(),
            FavoritePage.routeName: (context) => FavoritePage(),
            SettingPage.routeName: (context) => SettingPage(),
          },
        ),
      ),
    ),
  );
}
