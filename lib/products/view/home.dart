import 'package:ekart/constants/app_constants.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    
    return  Scaffold(
      appBar: AppBar(
        actions:const [
          CircleAvatar(
            radius: 22.5,
            backgroundColor: Color(0xffF5F6FA),
            child:  Center(child: Icon(Icons.shopping_bag_outlined)),
          ),
          SizedBox(width: 20,)
         
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding:const EdgeInsets.only(top: 20,right: 20,left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Welcome to eKart",style: TextStyle(
              fontSize: 15,
              color: Color(0xff8F959E)
            ),
            ),
           const SizedBox(height: 20,),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    
                    decoration: InputDecoration(
                      filled: true,
                      fillColor:const Color(0xffF5F6FA),
                      constraints:const BoxConstraints(
                        maxHeight: 50,
                      ),
                      prefixIcon:const Icon(Icons.search,color: Color(0xff8F959E),),
                      hintText: "Search",
                      contentPadding:const EdgeInsets.all(5),
                      hintStyle:const TextStyle(color: Color(0xff8F959E)),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      )
                    ),
                  ),
                ),
                const SizedBox(width: 10,),

                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(10),
                     color: primaryColor
                  ),
                  child:const Icon(Icons.mic_outlined,color: Colors.white,),
                )
              ],
            )
          ],
        ),
      )
    );
  }
}