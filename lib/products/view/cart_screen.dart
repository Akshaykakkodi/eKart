import 'dart:developer';

import 'package:ekart/constants/app_constants.dart';
import 'package:ekart/products/controller/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // log(Provider.of<ProductController>(context).cartItems.first.quantity.toString());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Cart",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: Consumer<ProductController>(
        builder: (context, value, child) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: value.cartItems.isEmpty
              ? Center(child: Text("No items in cart"))
              : ListView(
                  children: [
                    Container(
                      height: 300,
                      child: ListView.builder(
                        itemCount: value.cartItems.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              // height: 125,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: const Color(0xffDEDEDE)),
                              child: Row(
                                children: [
                                  // const SizedBox(width: 10,),
                                  Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Image.network(
                                      value.cartItems[index].product.image
                                          .toString(),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                            child: Text(value
                                                .cartItems[index].product.title
                                                .toString())),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                            "\$${value.cartItems[index].product.price}"),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                value.decrementCount(value
                                                    .cartItems[index].product);
                                              },
                                              child: CircleAvatar(
                                                backgroundColor: Colors.white,
                                                radius: 12.5,
                                                child: Icon(
                                                  Icons.remove,
                                                  color: Color(0xff8F959E),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(value.cartItems[index].product
                                                .cartQuantity
                                                .toString()),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                value.addToCart(value
                                                    .cartItems[index].product);
                                              },
                                              child: CircleAvatar(
                                                backgroundColor: Colors.white,
                                                radius: 12.5,
                                                child: Icon(
                                                  Icons.add,
                                                  color: Color(0xff8F959E),
                                                ),
                                              ),
                                            ),
                                            Spacer(),
                                            InkWell(
                                              onTap: () {
                                                
                                                value.removeFromCart(index);
                                                 
                                              },
                                              child: CircleAvatar(
                                                backgroundColor: Colors.white,
                                                radius: 12.5,
                                                child: Icon(
                                                  Icons.delete_outline,
                                                  color: Color(0xff8F959E),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Text(
                      "Delivery Address",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    Text(
                        "Menalil thazham kakkodi Kozhikode Kerala india pin:673611"),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Order Info",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "Sub total",
                          style: TextStyle(color: Color(0xff8F959E)),
                        ),
                        Spacer(),
                        Text(
                          "\$110",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "Delivery charge",
                          style: TextStyle(color: Color(0xff8F959E)),
                        ),
                        Spacer(),
                        Text(
                          "\$20",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "Total",
                          style: TextStyle(color: Color(0xff8F959E)),
                        ),
                        Spacer(),
                        Text(
                          "\$130",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        )
                      ],
                    ),
                  ],
                ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 60,
        color: primaryColor,
        child: Center(
            child: Text(
          "Checkout",
          style: TextStyle(
              fontWeight: FontWeight.w600, fontSize: 18, color: Colors.white),
        )),
      ),
    );
  }
}
