import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/daily_alarm_provider.dart';
import 'package:restaurant_app/screen/search_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatefulWidget {
  static const routeName = '/setting_page';
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String isSwitch = "switchIsOn";

  bool notification = false;

  void save() async {
    final value = await SharedPreferences.getInstance();
    value.setBool(isSwitch, notification);
  }

  void onChanged(bool isNotification) async {
    setState(() {
      notification = isNotification;
      save();
    });
  }

  void load() async {
    final value = await SharedPreferences.getInstance();
    setState(() {
      notification = value.getBool(isSwitch) ?? false;
    });
  }

  @override
  void initState() {
    super.initState();
    load();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SchedulingProvider>(
      create: (context) => SchedulingProvider(),
      child: Scaffold(
        appBar: AppBar(title: Text("setting")),
        body: Column(
          children: [
            const SizedBox(
              height: 20.0,
            ),
            const SizedBox(
              height: 20.0,
            ),
            Material(
              child: ListTile(
                iconColor: Colors.black,
                title: const Text('Push Notification'),
                subtitle: const Text('Restaurant Recommendation'),
                trailing: Consumer<SchedulingProvider>(
                  builder: (context, scheduled, _) {
                    return Switch(
                      value: notification,
                      onChanged: (bool value) {
                        setState(
                          () {
                            scheduled.scheduledRestaurantRecoment(value);
                            scheduled.scheduledStatus;
                            onChanged(value);
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
