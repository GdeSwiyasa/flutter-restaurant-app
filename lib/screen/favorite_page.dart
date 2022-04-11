import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/favorite_provider.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("favorite"),
      ),
      body: Column(
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
                      return;
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 24.0,
                        ),
                    itemCount: value.listFavorite.length);
              }
            }),
          ))
        ],
      ),
    );
  }
}
