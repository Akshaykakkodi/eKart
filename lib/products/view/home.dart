import 'package:ekart/products/controller/product_controller.dart';
import 'package:ekart/products/view/cart_screen.dart';
import 'package:ekart/products/view/categories.dart';
import 'package:ekart/products/view/home_screen.dart';
import 'package:ekart/products/view/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    List pages=[const HomeScreen(),const WishlistScreen(),const Categories()];
  
    
    return  Consumer<ProductController>(
      builder: (context, value, child) => 
       Scaffold(
        appBar: AppBar(
          actions: [
            CircleAvatar(
              radius: 22.5,
              backgroundColor:const Color(0xffF5F6FA),
              child:  Center(child: Image.asset("assets/icons/bag.png",scale: 4,) ),
            ),
           const SizedBox(width: 20,)
           
          ],
        ),
        body: pages.elementAt(value.selectedIndex),
    
        bottomNavigationBar: BottomNavigationBar(
          currentIndex:value.selectedIndex ,
          onTap: (index) {
            value.oNbottomNavigationSelection(index);
          },
          items: [
            BottomNavigationBarItem(icon: Image.asset("assets/icons/home.png",scale: 4,),
            backgroundColor: Colors.white,
            label: "Home"
            ),
            BottomNavigationBarItem(icon: Image.asset("assets/icons/wishlist.png",scale: 4,),
            backgroundColor: Colors.white,
            label: "Wishlist"
            ),
           const BottomNavigationBarItem(icon:Icon(Icons.category_outlined,color: Color(0xff8F959E),),
            backgroundColor: Colors.white,
            label: "Category"
            ),
          ]
          ),
      ),
    );
  }
}