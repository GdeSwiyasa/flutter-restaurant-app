import 'dart:async';
import 'package:flutter/material.dart';
import 'package:restaurant_app/common/color.dart';
import 'package:restaurant_app/screen/homepage.dart';

class SplashScreen extends StatelessWidget {
  static const routeName = '/splash_screen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ItemSplash(),
    );
  }
}

class ItemSplash extends StatefulWidget {
  const ItemSplash({Key? key}) : super(key: key);

  @override
  State<ItemSplash> createState() => _ItemSplashState();
}

class _ItemSplashState extends State<ItemSplash> {
  int activeIndex = 0;

  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {
        activeIndex++;

        if (activeIndex == 4) activeIndex = 0;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              SizedBox(
                // margin: EdgeInsets.all(30),
                width: MediaQuery.of(context).size.width * 0.65,
                child: Stack(
                  children: [
                    AnimatedOpacity(
                      opacity: activeIndex == 0 ? 1 : 0,
                      duration: const Duration(seconds: 2),
                      child: Image.asset(
                        "assets/image/splash1.png",
                      ),
                    ),
                    AnimatedOpacity(
                      opacity: activeIndex == 1 ? 1 : 0,
                      duration: const Duration(seconds: 2),
                      child: Image.asset(
                        "assets/image/splash2.png",
                      ),
                    ),
                    AnimatedOpacity(
                      opacity: activeIndex == 2 ? 1 : 0,
                      duration: const Duration(seconds: 1),
                      child: Image.asset(
                        "assets/image/splash3.png",
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Text(
                "Order your Favorite",
                style: Theme.of(context).textTheme.headline5?.copyWith(
                      color: CustomColor().fieryRose,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Order from the best local restaurant with easy. \nEspecially for you!",
                style: Theme.of(context).textTheme.subtitle2?.copyWith(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                textAlign: TextAlign.center,
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),
                              (Route<dynamic> route) => false);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 65,
                          decoration: BoxDecoration(
                            color: CustomColor().fieryRose,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "Continue",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
