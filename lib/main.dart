import 'package:flutter/material.dart';
import 'package:restaurant_app/screen/detailpage.dart';
import 'package:restaurant_app/screen/homepage.dart';
import 'package:restaurant_app/screen/search_page.dart';

import 'package:restaurant_app/screen/splashscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => SplashScreen(),
        HomePage.routeName: (context) => HomePage(),
        DetailPage.routeName: (context) => DetailPage(
              restaurant_id:
                  ModalRoute.of(context)?.settings.arguments as String,
            ),
        SearchPage.routeName: (context) => SearchPage(),
      },
    );
  }
}
