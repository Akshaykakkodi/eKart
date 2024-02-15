import 'package:ekart/onboarding/view/intro_screen_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroScreen1 extends StatelessWidget {
  const IntroScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration:const BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/firstPageImage.jpg"),fit: BoxFit.fill)
        ),
        child: Column(children: [
         const Spacer(),
          Text("Welcome to GemStore!",style: GoogleFonts.ptSans(fontSize: 25,fontWeight: FontWeight.w700,color: Colors.white),),
          const SizedBox(height: 13,),
          Text("The Home For a Fashionista!",style: GoogleFonts.ptSans(fontSize: 16,color: Colors.white),),
          const SizedBox(height: 60,),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) =>const IntroScreen2(),));
            },
            child: Container(
              height: 53,
              width: 193,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(29.5),
                color: const Color(0xffFFFFFF).withOpacity(.25),
                border: Border.all(width: 1.18,color: Colors.white)
              ),
              child: Center(child: Text("Get Started",style: GoogleFonts.ptSans(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.white),)),
          
            ),
          ),
          const SizedBox(height: 100,)
        ]),
      )
    );
  }
}