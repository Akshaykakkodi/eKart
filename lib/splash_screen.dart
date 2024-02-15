import 'package:ekart/constants/app_constants.dart';
import 'package:ekart/login/controller/login_controller.dart';
import 'package:ekart/login/view/login_screen.dart';
import 'package:ekart/products/view/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth=FirebaseAuth.instance;
    Future.delayed(const Duration(seconds: 2))
        .then((value) => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>  StreamBuilder(
                stream:auth.authStateChanges() , 
                builder: (context, snapshot) {
                   if (snapshot.connectionState == ConnectionState.waiting) {
            // Still checking the user's state
            return const CircularProgressIndicator();
          }
           if (snapshot.hasData) {
            // User is logged in
            return const Home();
          } else {
            // User is not logged in
            return const LoginSCreen();
          }
                },),
            )
            )
            );
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
