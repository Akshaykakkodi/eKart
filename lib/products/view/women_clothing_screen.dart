import 'package:ekart/products/controller/product_controller.dart';
import 'package:ekart/products/view/home_screen.dart';
import 'package:ekart/products/view/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WomenClothingScreen extends StatefulWidget {
  const WomenClothingScreen({super.key});

  @override
  State<WomenClothingScreen> createState() => _WomenClothingScreenState();
}

class _WomenClothingScreenState extends State<WomenClothingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<ProductController>(context,listen: false).fetchWomensClothingProducts();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
    return  Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
        child: Consumer<ProductController>(
          builder: (context, value, child) => SizedBox(
        child: GridView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: value.womenClothingItems.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 5,
              crossAxisSpacing: 10),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProductScreen(product: value.womenClothingItems[index],),));
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom:12.0),
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: SizedBox(
                            width: 150,
                            child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xffF5EBF1),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                        value.womenClothingItems[index].image
                                            .toString(),
                                      ),
                                      fit: BoxFit.fill),
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 5,
                                        offset: Offset(0, 3)),
                                  ],
                                ),
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, right: 12),
                                        child: InkWell(
                                          onTap: () {
                                            value.wishListItem(value.womenClothingItems[index]);
                                            showSnacbar(context,value.womenClothingItems[index]);
                                          },
                                         
                                          child:value.womenClothingItems[index].isWishListed?const Icon(Icons.favorite,color: Colors.red,): Image.asset(
                                            "assets/icons/wishlist.png",
                                          scale: 4,
                                          // color: value.isWishListed[index]?Colors.red:Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ]))),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(value.womenClothingItems[index].title.toString()),
                      Text(
                        "\$${value.womenClothingItems[index].price}",
                        style:const TextStyle(fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
          ),
        ),
      ),
    );
  }
}