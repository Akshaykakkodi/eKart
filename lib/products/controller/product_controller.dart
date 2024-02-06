import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:ekart/products/model/product_model.dart';
import 'package:flutter/material.dart';

class ProductController extends ChangeNotifier {
  final Dio dio = Dio();
  List<ProductModel> productList = [];  // list of products fetched from api
  int selectedIndex = 0; // selected index of home bottom navigation
  bool isLoading = false;
  List<ProductModel> wishListItems = []; // list of wishlisted items
  List<bool> isWishListed = []; 
  List<CartItem> cartItems = []; // list of items added to cart
  List<ProductModel> searchResult = []; // list of products from search result
  // int get cartCount => cartItems.fold(0, (sum, item) => sum + cartItems.length);
  int cartCount = 0;
  List<int> cartItemCount = [];
  num subTotal=0;
  num toatalAmount=0;
  num deliveryCharge=20;

  void oNbottomNavigationSelection(int value) {
    selectedIndex = value;
    notifyListeners();
  }



// fetch products from api
  fetchProducts() async {
    try {
      isLoading = true;
      var response = await dio.get("https://fakestoreapi.com/products");
      if (response.statusCode == 200) {
        productList = List<ProductModel>.from(
            response.data.map((x) => ProductModel.fromJson(x)));
        isWishListed = List.generate(productList.length, (index) => false);
        // cartItemCount = List.generate(productList.length, (index) => 0);
        cartCount = cartItems.length;
      } else {
        log("something went wrong");
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading = false;
    }
    notifyListeners();
  }



// function to wishlist a item
  void wishListItem(ProductModel product) {
    final productId = product.id;

    if (productId != null) {
      if (!wishListItems.any((item) => item.id == productId)) {
        wishListItems.add(product);

        int index = productList.indexOf(product);
        isWishListed[index] = true;

        // product.isWishListed=true;
      } else {
        wishListItems.removeWhere((item) => item.id == productId);

        int index = productList.indexOf(product);
        isWishListed[index] = false;
        // product.isWishListed=false;
      }
      notifyListeners();
    }
  }



// function to add a item to cart
  void addToCart(ProductModel product) {
    final existingItem = cartItems.firstWhere(
        (item) => item.product.id == product.id,
        orElse: () => CartItem(product: product, quantity: 0));
    if (existingItem.quantity == 0) {
      product.isInCart = true;
      cartItems.add(CartItem(product: product, quantity: 1));
      cartCount = cartItems.length;
    } else {
      existingItem.quantity++;
      product.cartQuantity = existingItem.quantity;
      cartCount = cartItems.length;
    }
    notifyListeners();
  }



// function to decrement itemquantity of a product
  decrementCount(ProductModel product) {
    final existingItem = cartItems.firstWhere(
        (item) => item.product.id == product.id,
        orElse: () => CartItem(product: product, quantity: 0));

    if (existingItem.quantity > 0) {
      existingItem.quantity--;
      product.cartQuantity = existingItem.quantity;

      if (existingItem.quantity == 0) {
        cartItems.remove(existingItem);
        product.isInCart = false;
        cartCount = cartItems.length;
      }

      notifyListeners();
    }
  }


// funtion to remove a item from cart
  removeFromCart(int index) {
    cartItems.removeAt(index);
    notifyListeners();
  }


// function to search a product 
  searchProduct(String searchQuery) {
    searchResult = productList
        .where((element) =>
            element.title!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
    notifyListeners();
  }

num calculateSubTotalPrice() {
    subTotal = 0;
    for (var cartItem in cartItems) {
      subTotal += cartItem.product.price! * cartItem.quantity;
    }
    return subTotal;
  }

 num calculateTotalPrice(){
    toatalAmount=0;
    toatalAmount=subTotal+deliveryCharge;
    return toatalAmount;
  }

  void clear(){
cartItems.clear();

  }

  

 
}








class CartItem {
  ProductModel product;
  int quantity;

  CartItem({required this.product, required this.quantity});
}
