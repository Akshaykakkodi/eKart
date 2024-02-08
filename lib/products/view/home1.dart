import 'package:ekart/constants/app_constants.dart';
import 'package:ekart/products/controller/product_controller.dart';
import 'package:ekart/products/view/cart_screen.dart';
import 'package:ekart/products/view/home_screen.dart';
import 'package:ekart/products/view/product_screen.dart';
import 'package:ekart/products/view/product_search_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

class HomeScreen1 extends StatelessWidget {
  const HomeScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    Provider.of<ProductController>(context, listen: false).fetchProducts();
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              title: const Text("ekart"),
              centerTitle: true,
              actions: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CartScreen(),
                        ));
                  },
                  child: Consumer<ProductController>(
                    builder: (context, value, child) => CircleAvatar(
                      radius: 22.5,
                      backgroundColor: const Color(0xffF5F6FA),
                      child: Center(
                          child: badges.Badge(
                        badgeContent: Text(
                          value.cartCount.toString(),
                          style:
                              const TextStyle(fontSize: 7, color: Colors.white),
                        ),
                        badgeAnimation: const badges.BadgeAnimation.slide(),
                        child: Image.asset(
                          "assets/icons/bag.png",
                          scale: 4,
                        ),
                      )),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                )
              ],
            ),
            SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true,
              centerTitle: true,
              flexibleSpace: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: searchController,
                        onChanged: (value) {
                          Provider.of<ProductController>(context, listen: false)
                              .searchProduct(value);
                        },
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xffF5F6FA),
                            constraints: const BoxConstraints(
                              maxHeight: 50,
                            ),
                            prefixIcon: InkWell(
                              onTap: () {
                                Provider.of<ProductController>(context,
                                        listen: false)
                                    .searchProduct(searchController.text);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ProductSearchScreen(),
                                    ));
                              },
                              child: const Icon(
                                Icons.search,
                                color: Color(0xff8F959E),
                              ),
                            ),
                            hintText: "Search",
                            contentPadding: const EdgeInsets.all(5),
                            hintStyle:
                                const TextStyle(color: Color(0xff8F959E)),
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
              ),
            ),
            Consumer<ProductController>(
              builder: (context, value, child) => SliverGrid.builder(
                itemCount: searchController.text.isEmpty
                    ? value.productList.length
                    : value.searchResult.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 5,
                    crossAxisSpacing: 10),
                itemBuilder: (context, index) {
                  var items = searchController.text.isEmpty
                      ? value.productList
                      : value.searchResult;
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductScreen(
                              product: value.productList[index],
                            ),
                          ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 12.0, left: 12),
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
                                              items[index].image.toString(),
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
                                                  value.wishListItem(
                                                      items[index]);
                                                  showSnacbar(context, index);
                                                },
                                                child: items[index].isWishListed
                                                    ? const Icon(
                                                        Icons.favorite,
                                                        color: Colors.red,
                                                      )
                                                    : Image.asset(
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
                            Text(items[index].title.toString()),
                            Text(
                              "\$${items[index].price}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
