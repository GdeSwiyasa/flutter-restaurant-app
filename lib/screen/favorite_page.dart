import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/color.dart';
import 'package:restaurant_app/provider/favorite_provider.dart';
import 'package:restaurant_app/widget/custom_fav_card.dart';

class FavoritePage extends StatelessWidget {
  static const routeName = '/favorit_page';
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            "Favorite Restaurant",
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(child: Consumer<FavoriteProvider>(
              builder: ((context, value, child) {
                if (value.data == ResultState.loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (value.data == ResultState.hasData) {
                  return ListView.separated(
                      itemBuilder: (context, index) {
                        var restaurant = value.listFavorite[index];
                        return CustomFavCard(restaurant: restaurant);
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 24.0,
                          ),
                      itemCount: value.listFavorite.length);
                } else {
                  return Center(
                    child: Text(
                      "No Data Here",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }
              }),
            ))
          ],
        ),
      ),
    );
  }
}
