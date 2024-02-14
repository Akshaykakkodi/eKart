import 'package:ekart/constants/app_constants.dart';
import 'package:ekart/login/controller/login_controller.dart';
import 'package:ekart/products/controller/product_controller.dart';
import 'package:ekart/products/view/order_placed_screen.dart';
import 'package:ekart/products/view/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
   
    var amount =
        Provider.of<ProductController>(context).calculateSubTotalPrice();
    var totalAmount =
        Provider.of<ProductController>(context).calculateTotalPrice();

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
              ? const Center(child: Text("No items in cart"))
              : ListView(
                  children: [
                    SizedBox(
                      height: 300,
                      child: ListView.builder(
                        itemCount: value.cartItems.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ProductScreen(product: value.cartItems[index].product),));
                            },
                            child: Padding(
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
                                                child: const CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  radius: 12.5,
                                                  child: Icon(
                                                    Icons.remove,
                                                    color: Color(0xff8F959E),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(value.cartItems[index].product
                                                  .cartQuantity
                                                  .toString()),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  value.addToCart(value
                                                      .cartItems[index].product);
                                                },
                                                child: const CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  radius: 12.5,
                                                  child: Icon(
                                                    Icons.add,
                                                    color: Color(0xff8F959E),
                                                  ),
                                                ),
                                              ),
                                              const Spacer(),
                                              InkWell(
                                                onTap: () {
                                                  value.removeFromCart(index);
                                                },
                                                child: const CircleAvatar(
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
                            ),
                          );
                        },
                      ),
                    ),
                    const Text(
                      "Delivery Address",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                     Text(
                        Provider.of<LoginController>(context).userData?["address"]??""),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Order Info",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Text(
                          "Sub total",
                          style: TextStyle(color: Color(0xff8F959E)),
                        ),
                        const Spacer(),
                        Text(
                          "\$${amount.toStringAsFixed(2)}",
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Row(
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
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Text(
                          "Total",
                          style: TextStyle(color: Color(0xff8F959E)),
                        ),
                        const Spacer(),
                        Text(
                          "\$${totalAmount.toStringAsFixed(2)}",
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        )
                      ],
                    ),
                  ],
                ),
        ),
      ),
      bottomNavigationBar: Consumer<ProductController>(
        builder: (context, value, child) => 
         InkWell(
          onTap: () {
            if(value.cartItems.isNotEmpty){
           value.clear();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>const OrderPlacedScreen(),));
            }
           
          },
          child: Container(
            height: 60,
            color: primaryColor,
            child: const Center(
                child: Text(
              "Checkout",
              style: TextStyle(
                  fontWeight: FontWeight.w600, fontSize: 18, color: Colors.white),
            )),
          ),
        ),
      ),
    );
  }
}
