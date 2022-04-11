import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/color.dart';
import 'package:restaurant_app/data/api/api_provider.dart';
import 'package:restaurant_app/data/model/detail_model.dart';
import 'package:restaurant_app/provider/detail_provider.dart';
import 'package:restaurant_app/provider/favorite_provider.dart';
import 'package:restaurant_app/widget/custom_menu.dart';
import 'package:restaurant_app/widget/custom_snackbar.dart';

class DetailPage extends StatelessWidget {
  static const routeName = '/detail_page';
  final String restaurant_id;

  DetailPage({required this.restaurant_id});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DetailProvider>(
      create: (_) =>
          DetailProvider(apiService: ApiService(), idRestaurant: restaurant_id),
      child: const Body(),
    );
  }
}

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<DetailProvider>(
        builder: (context, state, _) {
          if (state.data == ResultData.loading) {
            return const Center(child: const CircularProgressIndicator());
          } else if (state.data == ResultData.hasData) {
            return DetailBody(
              state: state,
            );
          } else if (state.data == ResultData.error) {
            return Align(
              alignment: Alignment.center,
              child: ListView(
                children: [
                  Image.asset("assets/error.png"),
                  const SizedBox(
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
          } else {
            return Center(child: Container());
          }
        },
      ),
    );
  }
}

class DetailBody extends StatelessWidget {
  DetailProvider state;

  DetailBody({
    Key? key,
    required this.state,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Hero(
                    tag: state.detailRestaurant.restaurant.pictureId,
                    child: Image.network(
                      "https://restaurant-api.dicoding.dev/images/large/${state.detailRestaurant.restaurant.pictureId}",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              state.detailRestaurant.restaurant.name,
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            _favoriteList(context, state.detailRestaurant),
                          ],
                        ),
                        Text(
                          state.detailRestaurant.restaurant.categories
                              .map((e) => e.name)
                              .toString(),
                          style: GoogleFonts.poppins(
                            color: Colors.grey,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          state.detailRestaurant.restaurant.address +
                              ", " +
                              state.detailRestaurant.restaurant.city,
                          style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.black54),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          width: MediaQuery.of(context).size.width,
                          color: Color(0xffE9E9E9),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Open 24 hours",
                                    style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),
                                  Text(
                                    "Est. delivery fee 12rb - Delivery in 15 min ",
                                    style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              InkWell(
                                onTap: () {},
                                child: Text(
                                  "Change",
                                  style: GoogleFonts.poppins(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: CustomColor().fieryRose),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Summary',
                          style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          state.detailRestaurant.restaurant.description,
                          style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.black54),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          "Menu",
                          style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                        Text(
                          "Food",
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: CustomColor().fieryRose),
                        ),
                        CustomGridFood(
                            menu: state.detailRestaurant.restaurant.menus),
                        Text(
                          "Drinks",
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: CustomColor().fieryRose),
                        ),
                        CustomGridDrink(
                            menu: state.detailRestaurant.restaurant.menus),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _favoriteList(BuildContext context, DetailRestaurant restaurantList) {
    return Consumer(
      builder: (context, FavoriteProvider value, _) {
        return FutureBuilder<bool>(
          future: value.isFavorite(restaurantList.restaurant),
          builder: (context, snapshot) {
            var favorite = snapshot.data ?? false;
            return favorite
                ? IconButton(
                    onPressed: () {
                      value.removeFav(restaurantList.restaurant);
                      CustomSnackBar().error("Success to remove");
                    },
                    icon: Icon(
                      Icons.favorite,
                      color: CustomColor().fieryRose,
                    ))
                : IconButton(
                    onPressed: () {
                      value.addFavorite(restaurantList.restaurant);
                      CustomSnackBar().success("Success to add favorite");
                    },
                    icon: Icon(
                      Icons.favorite_border,
                      color: CustomColor().fieryRose,
                    ),
                  );
          },
        );
      },
    );
  }
}
