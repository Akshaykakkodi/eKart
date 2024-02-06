import 'package:ekart/constants/app_constants.dart';
import 'package:ekart/products/controller/product_controller.dart';
import 'package:ekart/products/model/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  final ProductModel product;
  const ProductScreen({super.key,required this.product});

  @override
  Widget build(BuildContext context) {
    
    return  Scaffold(
     
      appBar: AppBar(
        actions: [
           CircleAvatar(
              radius: 22.5,
              backgroundColor:const Color(0xffF5F6FA),
              child:  Center(child: Image.asset("assets/icons/bag.png",scale: 4,) ),
            ),
           const SizedBox(width: 20,)
        ],
      ),
      body: Container(
        padding:const EdgeInsets.all(10),
        child: ListView(
          
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              
              child: Image.network(product.image.toString(),fit: BoxFit.fill,),
            ),
            const SizedBox(height: 15,),
            Text(product.title.toString(),textAlign: TextAlign.center,style:const TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
            Row(
              children: [
               const Text("Price : ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color:Color(0xff8F959E)),),
                Text("\$${product.price.toString()}",style:const TextStyle(fontSize: 16,fontWeight: FontWeight.w600),)
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
              const  Text("Category : ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Color(0xff8F959E)),),
                 Text(product.category.toString(),style:const TextStyle(fontSize: 16,fontWeight: FontWeight.w400)),
              ],
            ),
            const SizedBox(height: 10,),
           
           const Text("Description",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
            const SizedBox(height: 8,),
            Text(product.description.toString(),style:const TextStyle(color: Color(0xff8F959E),fontSize: 16,fontWeight: FontWeight.w400),),
            const SizedBox(height: 10,),
            Row(
              children: [
              const  Text("Rating : ",style: TextStyle(color: Color(0xff8F959E),fontSize: 16,fontWeight: FontWeight.w500),),
                Text("${product.rating!.rate.toString()}/5",style:const TextStyle(fontSize: 16,fontWeight: FontWeight.w400),),
                const SizedBox(width: 8,),
                Text("(${product.rating!.count.toString()})")
              ],
            ),
            const SizedBox(height: 25,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CupertinoButton(
                  onPressed: () {
                    
                  },
                  padding: null,
                  minSize: 0,
                  child: GestureDetector(
                    onTap: () {
                      Provider.of<ProductController>(context,listen: false).addToCart(product);
                      showAlert(context);
                
                    },
                    child: Container(
                      height: 60,
                      width: 200,
                      
                      decoration: BoxDecoration(
                        
                        borderRadius: BorderRadius.circular(20),
                        color: primaryColor
                      ),
                      child:const Center(child: Text("Add to cart",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.white),)),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25,)
      
          ],
        ),
      ),
    );
  }
}

showAlert(BuildContext context){
ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Item Added to cart")));
}