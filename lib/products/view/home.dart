import 'package:ekart/login/controller/login_controller.dart';
import 'package:ekart/login/view/login_screen.dart';
import 'package:ekart/products/controller/product_controller.dart';
import 'package:ekart/products/view/cart_screen.dart';
import 'package:ekart/products/view/categories.dart';
import 'package:ekart/products/view/home1.dart';
import 'package:ekart/products/view/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

class Home extends StatefulWidget {

  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
   List pages = [
      const HomeScreen1(),
      const WishlistScreen(),
      const Categories()
    ];
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<LoginController>(context,listen: false).fetchUserData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
 

    
  

    return Consumer<ProductController>(
      builder: (context, value, child) => Scaffold(
      
        appBar: value.selectedIndex==0?null: AppBar(
          actions: [
            InkWell(
              onTap: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context) =>const CartScreen(),));
              },
              child: CircleAvatar(
                radius: 22.5,
                backgroundColor: const Color(0xffF5F6FA),
                child: Center(
                  
                    child: badges.Badge(
                      badgeContent: Text(value.cartCount.toString(),style:const TextStyle(fontSize: 7,color: Colors.white),),
                      badgeAnimation:const  badges.BadgeAnimation.slide(),
                      
                      child: Image.asset(
                                    "assets/icons/bag.png",
                                    scale: 4,
                                  ),
                    )
                    ),
              ),
            ),
            const SizedBox(
              width: 20,
            )
          ],
        ),
        body: pages.elementAt(value.selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: value.selectedIndex,
            onTap: (index) {
              value.oNbottomNavigationSelection(index);
            },
            items: [
              BottomNavigationBarItem(
                  icon: Image.asset(
                    "assets/icons/home.png",
                    scale: 4,
                  ),
                  backgroundColor: Colors.white,
                  label: "Home"),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    "assets/icons/wishlist.png",
                    scale: 4,
                  ),
                  backgroundColor: Colors.white,
                  label: "Wishlist"),
              const BottomNavigationBarItem(
                  icon: Icon(
                    Icons.category_outlined,
                    color: Color(0xff8F959E),
                  ),
                  backgroundColor: Colors.white,
                  label: "Category"),
            ]),
        drawer: Drawer(
          backgroundColor: Colors.white,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Consumer<LoginController>(
              builder: (context, value, child) => 
               Column(
                children: [
                   DrawerHeader(
                      child: Column(
                    children: [
                      // CircleAvatar(
                      //   radius: 35,
                      // ),
                     const SizedBox(height: 30,),
                      Text(value.userData!["name"],style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                    ],
                  )),
                  const ListTile(
                      leading: Icon(
                        Icons.info_outline,
                        color: Colors.grey,
                      ),
                      title: Text(
                        "Account Information",
                        style:
                            TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      )),
                  const Divider(),
                  ListTile(
                      leading: Image.asset(
                        "assets/icons/bag.png",
                        scale: 4,
                      ),
                      title: const Text(
                        "Orders",
                        style:
                            TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      )),
                  const Divider(),
                  ListTile(
                      leading: Image.asset(
                        "assets/icons/wishlist.png",
                        scale: 4,
                      ),
                      title: const Text(
                        "Wishlist",
                        style:
                            TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      )),
                  const Divider(),
                  const ListTile(
                      leading: Icon(
                        Icons.emoji_people,
                        color: Colors.grey,
                      ),
                      title: Text(
                        "Refer",
                        style:
                            TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      )),
                  const Divider(),
                  const ListTile(
                      leading: Icon(
                        Icons.settings,
                        color: Colors.grey,
                      ),
                      title: Text(
                        "Settings",
                        style:
                            TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      )),
                  const Divider(),
                  GestureDetector(
                    onTap: ()async {
                     await Provider.of<LoginController>(context,listen: false).logOut();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginSCreen(),));
                    },
                    child: const ListTile(
                        leading: Icon(
                          Icons.logout,
                          color: Colors.grey,
                        ),
                        title: Text(
                          "Logout",
                          style:
                              TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        )),
                  ),
                  const Divider(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
