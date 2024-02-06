import 'package:ekart/constants/app_constants.dart';
import 'package:ekart/products/controller/product_controller.dart';
import 'package:ekart/products/view/home_screen.dart';
import 'package:ekart/products/view/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductSearchScreen extends StatelessWidget {
  const ProductSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController=TextEditingController();
    return Scaffold(
      appBar: AppBar(),
      body:Provider.of<ProductController>(context).searchResult.isEmpty? Center(child: Text("No Results found!")) :Container(
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
                    controller: searchController,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xffF5F6FA),
                        constraints: const BoxConstraints(
                          maxHeight: 50,
                        ),
                        prefixIcon: InkWell(
                          onTap: () {
                            Provider.of<ProductController>(context,listen: false).searchProduct(searchController.text);
                            
                          },
                          child: const Icon(
                            Icons.search,
                            color: Color(0xff8F959E),
                          ),
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
                  itemCount: value.searchResult.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3 / 5,
                      crossAxisSpacing: 10),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductScreen(product: value.searchResult[index],),));
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
                                                value.searchResult[index].image
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
                                                    showSnacbar(context,index);
                                                  },
                                                 
                                                  child:value.isWishListed[index]?Icon(Icons.favorite,color: Colors.red,): Image.asset(
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
                              Text(value.searchResult[index].title.toString()),
                              Text(
                                "\$${value.searchResult[index].price}",
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
            ))
          ],
        ),
      ),
    );
  }
}