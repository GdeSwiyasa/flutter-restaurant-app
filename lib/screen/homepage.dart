import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/color.dart';
import 'package:restaurant_app/data/utils/notification_helper.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/screen/detailpage.dart';
import 'package:restaurant_app/screen/favorite_page.dart';
import 'package:restaurant_app/screen/search_page.dart';
import 'package:restaurant_app/screen/settings_page.dart';
import 'package:restaurant_app/widget/custom_card.dart';

import '../data/api/api_provider.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NotificationHelper _notificationHelper = NotificationHelper();

  @override
  void initState() {
    super.initState();
    _notificationHelper
        .configureSelectNotificationSubject(DetailPage.routeName);
    //  _notificationHelper.configureDidReceiveLocalNotificationSubject(
    //      context, DetailPage.routeName);
  }

  @override
  void dispose() {
    checkedNotificationSubject.close();
    // didReceiveLocalNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Your current address",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "Your Location Now",
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, SearchPage.routeName);
                    },
                    icon: Icon(
                      Icons.search,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, SettingPage.routeName);
                    },
                    icon: Icon(
                      Icons.settings,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, FavoritePage.routeName);
                    },
                    icon: Icon(
                      Icons.notifications_none_outlined,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
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
      body: _buildListRestaurant(),
    );
  }

  Widget _buildListRestaurant() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return ChangeNotifierProvider<RestaurantProvider>(
          create: (_) => RestaurantProvider(apiService: ApiService()),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(right: 16, left: 16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Restaurant',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'See all',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: CustomColor().fieryRose,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: _buildRestaurantItem(context),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildRestaurantItem(BuildContext context) {
    return Consumer<RestaurantProvider>(
      builder: (context, state, _) {
        if (state.data == ResultData.loading) {
          return Center(child: CircularProgressIndicator());
        } else if (state.data == ResultData.hasData) {
          return Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: state.restaurantList.restaurants.length,
              itemBuilder: (context, index) {
                var restaurant = state.restaurantList.restaurants[index];
                return CustomCard(
                  restaurant: restaurant,
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                height: 12,
              ),
            ),
          );
        } else if (state.data == ResultData.noData) {
          return Align(
            alignment: Alignment.center,
            child: ListView(
              children: [
                Image.asset("assets/error.png"),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Ups, no data",
                  style: GoogleFonts.poppins(
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          );
        } else if (state.data == ResultData.error) {
          return Align(
            alignment: Alignment.center,
            child: ListView(
              children: [
                Image.asset("assets/error.png"),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Error, Something Wrong",
                  style: GoogleFonts.poppins(
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
