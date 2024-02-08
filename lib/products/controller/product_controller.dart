import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:ekart/constants/app_constants.dart';
import 'package:ekart/products/model/product_model.dart';
import 'package:flutter/material.dart';

class ProductController extends ChangeNotifier {
  final Dio dio = Dio();

  List<ProductModel> productList = []; // list of products fetched from api

  List<ProductModel> jewlleryItems = [];

  List<ProductModel> electronicsItems = [];

  List<ProductModel> menClothingItems = [];

  List<ProductModel> womenClothingItems = [];

  int selectedIndex = 0; // selected index of home bottom navigation

  bool isLoading = false;

  List<ProductModel> wishListItems = []; // list of wishlisted items

  List<bool> isWishListed = [];

  List<CartItem> cartItems = []; // list of items added to cart

  List<ProductModel> searchResult = []; // list of products from search result

 

  int cartCount = 0;

  List<int> cartItemCount = [];

  num subTotal = 0;

  num toatalAmount = 0;

  num deliveryCharge = 20;

  void oNbottomNavigationSelection(int value) {
    selectedIndex = value;
    notifyListeners();
  }

  baseApiServices(String apiEndPoint) async {
    try {
      var response = await dio.get(baseUrl + apiEndPoint);
      if (response.statusCode == 200) {
        return response;
      } else {
        log(response.statusMessage.toString());
        return null;
      }
    } catch (e) {
      throw e.toString();
    }

  }

// fetch products from api
  fetchProducts() async {
    isLoading = true;
    var response = await baseApiServices("products");

    if (response != null) {
      productList = List<ProductModel>.from(
          response.data.map((x) => ProductModel.fromJson(x)));
      cartCount = cartItems.length;
    } else {}
    isLoading = false;
    notifyListeners();
  }

  fetchJwelleryProducts() async {
    isLoading = true;
    var response = await baseApiServices("products/category/jewelery");
    if (response != null) {
      jewlleryItems = List<ProductModel>.from(
          response.data.map((x) => ProductModel.fromJson(x)));
    }
    isLoading = false;
    notifyListeners();
  }

  fetchElectronicsProducts() async {
    isLoading = true;
    var response = await baseApiServices("products/category/electronics");
    if (response != null) {
      electronicsItems = List<ProductModel>.from(
          response.data.map((x) => ProductModel.fromJson(x)));
    }
    isLoading = false;
    notifyListeners();
  }

  fetchMensClothingProducts() async {
    isLoading = true;
    var response = await baseApiServices("products/category/men's clothing");
    if (response != null) {
      menClothingItems = List<ProductModel>.from(
          response.data.map((x) => ProductModel.fromJson(x)));
    }
    isLoading = false;
    notifyListeners();
  }

  fetchWomensClothingProducts() async {
    isLoading = true;
    var response = await baseApiServices("products/category/women's clothing");
    if (response != null) {
      womenClothingItems = List<ProductModel>.from(
          response.data.map((x) => ProductModel.fromJson(x)));
    }
    isLoading = false;
    notifyListeners();
  }

// function to wishlist a item
  void wishListItem(ProductModel product) {
    final productId = product.id;

    if (productId != null) {
      if (!wishListItems.any((item) => item.id == productId)) {
        wishListItems.add(product);
        product.isWishListed = true;
      } else {
        wishListItems.removeWhere((item) => item.id == productId);
        product.isWishListed = false;
      }
      notifyListeners();
    }
  }

  void addToCart(ProductModel product) {
    final existingItemIndex =
        cartItems.indexWhere((item) => item.product.id == product.id);

    if (existingItemIndex != -1) {
      // Product is already in the cart
      cartItems[existingItemIndex].quantity++;
      product.cartQuantity = cartItems[existingItemIndex].quantity;
    } else {
      // Product is not in the cart
      final newItem = CartItem(product: product, quantity: 1);
      cartItems.add(newItem);
      product.isInCart = true;
      product.cartQuantity = 1;
    }
    cartCount = cartItems.length;
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

  num calculateTotalPrice() {
    toatalAmount = 0;
    toatalAmount = subTotal + deliveryCharge;
    return toatalAmount;
  }

  void clear() {
    cartItems.clear();
    cartCount = 0;
  }
}

class CartItem {
  ProductModel product;
  int quantity;

  CartItem({required this.product, required this.quantity});
}
