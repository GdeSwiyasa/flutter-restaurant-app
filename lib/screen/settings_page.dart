import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/color.dart';
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
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SchedulingProvider>(
      create: (context) => SchedulingProvider(),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          title: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "Search Restaurant",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  CustomColor().fieryRose,
                  CustomColor().princetonOrange,
                  CustomColor().tartOrange,
                ],
              ),
            ),
          ),
          elevation: 0,
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 20.0,
            ),
            ListTile(
              iconColor: Colors.black,
              title: Text(
                'Push Notification',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: Consumer<SchedulingProvider>(
                builder: (context, scheduled, _) {
                  return Switch(
                    activeColor: CustomColor().fieryRose,
                    value: notification,
                    onChanged: (value) {
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
            )
          ],
        ),
      ),
    );
  }
}
