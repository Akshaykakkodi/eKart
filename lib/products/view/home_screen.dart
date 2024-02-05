import 'package:ekart/constants/app_constants.dart';
import 'package:ekart/products/controller/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<ProductController>(context, listen: false).fetchProducts();
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome to eKart",
              style: TextStyle(fontSize: 15, color: Color(0xff8F959E)),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xffF5F6FA),
                        constraints: const BoxConstraints(
                          maxHeight: 50,
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Color(0xff8F959E),
                        ),
                        hintText: "Search",
                        contentPadding: const EdgeInsets.all(5),
                        hintStyle: const TextStyle(color: Color(0xff8F959E)),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: primaryColor),
                  child: const Icon(
                    Icons.mic_outlined,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
                child: Consumer<ProductController>(
              builder: (context, value, child) => SizedBox(
                child: GridView.builder(
                  itemCount: value.productList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3 / 5,
                      crossAxisSpacing: 10),
                  itemBuilder: (context, index) {
                    return SizedBox(
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
                                            value.productList[index].image
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
                                                value.wishListItem(value.productList[index]);
                                              },
                                              child: Image.asset(
                                                "assets/icons/wishlist.png",
                                              scale: 4,
                                              ),
                                            ),
                                          ),
                                        ]))),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(value.productList[index].title.toString()),
                          Text(
                            "\$${value.productList[index].price}",
                            style:const TextStyle(fontWeight: FontWeight.w500),
                          )
                        ],
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
