import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ekart/products/model/product_model.dart';
import 'package:flutter/material.dart';

class ProductController extends ChangeNotifier{
final Dio dio=Dio();
List<ProductModel> productList=[];

fetchProducts()async{
  try{
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
  notifyListeners();
}


}