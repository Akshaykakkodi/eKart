import 'package:flutter/material.dart';

class OnboardingController extends  ChangeNotifier {

  
int carouselIndex=0;

  toggleCarouselIndex(int index){
carouselIndex=index;
notifyListeners();
  }


}