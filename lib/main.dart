import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/database_service.dart';
import 'package:restaurant_app/provider/favorite_provider.dart';
import 'package:restaurant_app/screen/detailpage.dart';
import 'package:restaurant_app/screen/favorite_page.dart';
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
    return ChangeNotifierProvider(
      create: (_) => FavoriteProvider(databaseService: DatabaseService()),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        initialRoute: HomePage.routeName,
        routes: {
          // SplashScreen.routeName: (context) => SplashScreen(),s
          HomePage.routeName: (context) => HomePage(),
          DetailPage.routeName: (context) => DetailPage(
                restaurant_id:
                    ModalRoute.of(context)?.settings.arguments as String,
              ),
          SearchPage.routeName: (context) => SearchPage(),
          FavoritePage.routeName: (context) => FavoritePage(),
        },
      ),
    );
  }
}
