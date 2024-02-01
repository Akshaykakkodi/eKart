import 'package:ekart/constants/app_constants.dart';
import 'package:ekart/products/view/home.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 4))
        .then((value) => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const Home(),
            )));
    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: RichText(
                text: const TextSpan(children: [
              TextSpan(
                  text: "e",
                  style: TextStyle(color: Colors.yellow, fontSize: 60)),
              TextSpan(
                  text: "Kart",
                  style: TextStyle(color: Colors.white, fontSize: 60)),
            ])),
          ),
          SizedBox(
              height: 100,
              child: Lottie.asset("assets/lottie/cart_animation.json")),
        ],
      ),
    );
  }
}
