import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:ekart/products/model/product_model.dart';
import 'package:flutter/material.dart';

class ProductController extends ChangeNotifier {
  final Dio dio = Dio();
  List<ProductModel> productList = [];
  int selectedIndex = 0;
  bool isLoading = false;
  List<ProductModel> wishListItems = [];
  List<bool> isWishListed = [];
  List<CartItem> cartItems = [];
    int get cartCount => cartItems.fold(0, (sum, item) => sum + item.quantity);
  List<int> cartItemCount = [];

  void oNbottomNavigationSelection(int value) {
    selectedIndex = value;
    notifyListeners();
  }

  fetchProducts() async {
    try {
      isLoading = true;
      var response = await dio.get("https://fakestoreapi.com/products");
      if (response.statusCode == 200) {
        productList = List<ProductModel>.from(
            response.data.map((x) => ProductModel.fromJson(x)));
        isWishListed = List.generate(productList.length, (index) => false);
        cartItemCount = List.generate(productList.length, (index) => 0);
        
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

   void addToCart(ProductModel product) {
    final existingItem = cartItems.firstWhere((item) => item.product.id == product.id, orElse: () => CartItem(product: product, quantity: 0));
    if (existingItem.quantity == 0) {
      product.isInCart = true;
      cartItems.add(CartItem(product: product, quantity: 1));
    } else {
      existingItem.quantity++;
         product.cartQuantity = existingItem.quantity;
    }
    notifyListeners();
  }



  decrementCount(ProductModel product) {
      final existingItem = cartItems.firstWhere((item) => item.product.id == product.id, orElse: () => CartItem(product: product, quantity: 0));

    if (existingItem.quantity > 0) {
      existingItem.quantity--;
      product.cartQuantity = existingItem.quantity;

      if (existingItem.quantity == 0) {
       
        cartItems.remove(existingItem);
         product.isInCart = false;
      }

      notifyListeners();
    }
  
  }

  removeFromCart(ProductModel product) {
    cartItems.remove(product);
    notifyListeners();
  }



  getCount(ProductModel product){

  }


  
}


class CartItem {
  ProductModel product;
  int quantity;

  CartItem({required this.product, required this.quantity});
}
