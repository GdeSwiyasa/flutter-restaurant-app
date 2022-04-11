import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/color.dart';
import 'package:restaurant_app/provider/search_provider.dart';
import 'package:restaurant_app/widget/custom_card.dart';

import '../data/api/api_provider.dart';

class SearchPage extends StatelessWidget {
  static const routeName = '/search_screen';
  const SearchPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchProvider>(
      create: (_) => SearchProvider(apiService: ApiService()),
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
        body: Body(),
      ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchRestaurant =
        Provider.of<SearchProvider>(context, listen: false);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onSubmitted: (value) {
                searchRestaurant.addSearchKey(value);
              },
              decoration: InputDecoration(
                hintText: "What would you like to eat?",
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.black38,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(32),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
            ),
            Consumer<SearchProvider>(
              builder: (context, result, _) {
                if (result.data == ResultData.noKey) {
                  return Expanded(
                    child: ListView(
                      children: [
                        Image.asset(
                          "assets/empty.png",
                          height: 250,
                        ),
                        SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  );
                } else if (result.data == ResultData.loading) {
                  return Center(child: CircularProgressIndicator());
                } else if (result.data == ResultData.hasData) {
                  return Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: result.searchRestaurant.restaurants.length,
                      itemBuilder: (context, index) {
                        var restaurant =
                            result.searchRestaurant.restaurants[index];
                        return CustomCard(
                          restaurant: restaurant,
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 12,
                      ),
                    ),
                  );
                } else if (result.data == ResultData.noData) {
                  return Expanded(
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
                } else if (result.data == ResultData.error) {
                  return Expanded(
                    child: ListView(
                      children: [
                        Image.asset("assets/error.png"),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Unable Connect Server",
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
                  return Center(child: Container());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
