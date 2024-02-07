import 'package:ekart/constants/app_constants.dart';
import 'package:ekart/products/view/electronics_screen.dart';
import 'package:ekart/products/view/jwellery_screen.dart';
import 'package:ekart/products/view/men_clothing_screen.dart';
import 'package:ekart/products/view/women_clothing_screen.dart';
import 'package:flutter/material.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: Column(
          children: [
            TabBar(
              isScrollable: true,
              tabs: [
                Tab( text: "Jwellery",),
                 Tab( text: "Electronics",),
                  Tab( text: "Women's clothing",),
                   Tab( text: "Men's clothing",)
              ]),

              Expanded(
                child: TabBarView(
                  children: [
                    JwelleryScreen(),
                    ElectronicsScreen(),
                    WomenClothingScreen(),
                    MenClothingScreen()
                  ]),
              )
          ],
        ),
    
        
      ),
    );
  }
}