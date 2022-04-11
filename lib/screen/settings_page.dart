import 'package:flutter/material.dart';
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
    return Container();
  }
}
