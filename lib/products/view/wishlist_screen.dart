import 'package:ekart/constants/app_constants.dart';
import 'package:ekart/products/controller/product_controller.dart';
import 'package:ekart/products/view/product_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Provider.of<ProductController>(context, listen: false).fetchProducts();
    return Scaffold(
     
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Wishlist",
              style: TextStyle(fontSize: 15, color: Color(0xff8F959E)),
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 20,
            ),
            Provider.of<ProductController>(context).wishListItems.isEmpty
                ? const Center(child: Text("No items Wishlisted"))
                : Expanded(
                    child: Consumer<ProductController>(
                    builder: (context, value, child) => SizedBox(
                      child: GridView.builder(
                        itemCount: value.wishListItems.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 3 / 5,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ProductScreen(product: value.wishListItems[index]),));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
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
                                                    value.wishListItems[index]
                                                        .image
                                                        .toString(),
                                                  ),
                                                  fit: BoxFit.fill),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              boxShadow: const [
                                                BoxShadow(
                                                    color: Colors.grey,
                                                    blurRadius: 5,
                                                    offset: Offset(0, 3)),
                                              ],
                                            ),
                                          )),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(value.wishListItems[index].title
                                        .toString()),
                                    Text(
                                      "\$${value.wishListItems[index].price}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            showAlert(context, index);
                                            
                                          },
                                          child: Container(
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                      color: Colors.grey)),
                                              child:const Icon(Icons.delete_sharp)),
                                        ),
                                        //  const Spacer(),
                                        const SizedBox(
                                          width: 3,
                                        ),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              value.addToCart(value.wishListItems[index]);
                                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text("Added to cart")));
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: primaryColor),
                                              child: const Center(
                                                  child: Text(
                                                "Add to cart",
                                                style:
                                                    TextStyle(color: Colors.white),
                                              )),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ))
          ],
        ),
      ),
    );
  }
}

showAlert(BuildContext context, int index) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return SizedBox(
        height: 150,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           const Text("Remove Item from wishlist"),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Provider.of<ProductController>(context, listen: false)
                          .wishListItem(Provider.of<ProductController>(context,
                                  listen: false)
                              .wishListItems[index]);
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Remove",
                      style: TextStyle(color: Colors.red),
                    )),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("cancel"))
              ],
            ),
          ],
        ),
      );
    },
  );
}
