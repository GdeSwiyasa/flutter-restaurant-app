import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/utils/background_service.dart';
import 'package:restaurant_app/data/utils/dateTime_helper.dart';

class SchedulingProvider extends ChangeNotifier {
  bool _scheduledStatus = false;

  bool get scheduledStatus => _scheduledStatus;

  Future<bool> scheduledRestaurantRecoment(bool value) async {
    _scheduledStatus = value;
    if (_scheduledStatus) {
      // ignore: avoid_print
      print('Scheduling Restaurant Recommendation Active');
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      // ignore: avoid_print
      print('Scheduling Restaurant Recommendation Deactivate');
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}
