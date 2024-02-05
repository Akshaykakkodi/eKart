import 'package:flutter/material.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 80,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
              image:const DecorationImage(image: NetworkImage("https://indieground.net/wp-content/uploads/2023/03/Freebie-GradientTextures-Preview-02.jpg"),fit: BoxFit.fill)
              ),
              child:const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: Text("Electronics",style: TextStyle(color: Colors.white,fontSize: 30),))
                ],
              ),
            ),
            const SizedBox(height: 15,),
            Container(
              width: double.infinity,
              height: 80,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
              image:const DecorationImage(image: NetworkImage("https://blog.icons8.com/wp-content/uploads/2020/02/how-to-create-gradient-article-1280x720.jpg"),fit: BoxFit.fill)
              ),
              child:const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: Text("Women's clothing",style: TextStyle(color: Colors.white,fontSize: 30),))
                ],
              ),
            ),
            const SizedBox(height: 12,),
            Container(
              width: double.infinity,
              height: 80,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
              image:const DecorationImage(image: NetworkImage("https://indieground.net/wp-content/uploads/2023/03/Freebie-GradientTextures-Preview-04.jpg"),fit: BoxFit.fill)
              ),
              child:const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: Text("Jwellery",style: TextStyle(color: Colors.white,fontSize: 30),))
                ],
              ),
            ),
            const SizedBox(height: 12,),
            Container(
              width: double.infinity,
              height: 80,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
              image:const DecorationImage(image: NetworkImage("https://img.freepik.com/free-vector/gradient-colorful-grainy-dynamic-background_52683-101908.jpg"),fit: BoxFit.fill)
              ),
              child:const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: Text("Mens Clothing",style: TextStyle(color: Colors.white,fontSize: 30),))
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}