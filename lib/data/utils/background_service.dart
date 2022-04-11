import 'dart:ui';
import 'dart:isolate';
import 'dart:math';

import 'package:restaurant_app/data/api/api_provider.dart';
import 'package:restaurant_app/data/utils/notification_helper.dart';
import 'package:restaurant_app/main.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    print('Alarm fired!');
    final NotificationHelper _notificationHelper = NotificationHelper();
    var result = await ApiService().getListRestaurant();

    final random = new Random();
    var randomIndex = random.nextInt(result.restaurants.length);

    await _notificationHelper.showNotification(
      flutterLocalNotificationsPlugin,
      result.restaurants[randomIndex],
    );
    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }

  Future<void> someTask() async {
    print('Updated data from the background isolate');
  }
}
