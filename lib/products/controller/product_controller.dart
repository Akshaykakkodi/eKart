import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:ekart/products/model/product_model.dart';
import 'package:flutter/material.dart';

class ProductController extends ChangeNotifier{
final Dio dio=Dio();
List<ProductModel> productList=[];
int selectedIndex=0;
bool isLoading=false;
List<ProductModel> wishListItems=[];


void oNbottomNavigationSelection(int value){
selectedIndex=value;
notifyListeners();
}

fetchProducts()async{
  try{
    isLoading=true;
var response=await dio.get("https://fakestoreapi.com/products");
if(response.statusCode==200){
  productList= List<ProductModel>.from(response.data.map((x) => ProductModel.fromJson(x)));
  print(productList.length);
}
else{
  log("something went wrong");
}

  }
  catch(e){
    log(e.toString());
  }
  finally{
    isLoading=false;
  }
  notifyListeners();
}

void wishListItem(ProductModel product) {
  final productId = product.id;

  if (productId != null) {
    if (!wishListItems.any((item) => item.id == productId)) {
      wishListItems.add(product);
     
    } else {
      wishListItems.removeWhere((item) => item.id == productId);
      
    }
    notifyListeners();
  }
}


}