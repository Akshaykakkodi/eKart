import 'package:ekart/constants/app_constants.dart';
import 'package:ekart/products/view/home.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OrderPlacedScreen extends StatelessWidget {
  const OrderPlacedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return  Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Lottie.asset("assets/lottie/done_animation.json",height: 300,repeat: false)),
        const  Text("Order Placed",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.white),),
        TextButton(onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>const Home(),));
        }, child:const Text("Back to home"))
        ],
      ),
    );
  }
}