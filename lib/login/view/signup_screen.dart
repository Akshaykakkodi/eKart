import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupSCreen extends StatelessWidget {
  const SignupSCreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding:const EdgeInsets.only(right: 32,left: 32,top: 58),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Create \nyour account",style: GoogleFonts.ptSans(fontSize: 24),),
                const SizedBox(height: 19,),
                TextFormField(
                  decoration: InputDecoration(
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffD6D6D6))
                    ),
                    enabledBorder:const  UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffD6D6D6))
                    ),
                    hintText: "Enter your name",
                    hintStyle: hintStyles
                  ),
                ),
          
                const SizedBox(height: 20,),
          
                TextFormField(
                  decoration: InputDecoration(
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffD6D6D6))
                    ),
                    enabledBorder:const  UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffD6D6D6))
                    ),
                    hintText: "Email address",
                    hintStyle: hintStyles
                  ),
                ),
          
                 const SizedBox(height: 20,),
          
                TextFormField(
                  decoration: InputDecoration(
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffD6D6D6))
                    ),
                    enabledBorder:const  UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffD6D6D6))
                    ),
                    hintText: "Password",
                    hintStyle: hintStyles
                  ),
                ),
          
                 const SizedBox(height: 20,),
          
                TextFormField(
                  
                  decoration: InputDecoration(
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffD6D6D6))
                    ),
                    enabledBorder:const  UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffD6D6D6))
                    ),
                    
                    hintText: "Confirm password",
                    hintStyle: hintStyles
                  ),
                ),
                const SizedBox(height: 44,),
          
                CupertinoButton(
                  onPressed: () {
                    
                  },
                  padding: EdgeInsets.zero,
                  child: Center(
                    child: Container(
                      height: 51,
                      width: 147,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(26.5),
                        color:const Color(0xff2D201C)
                      ),
                      child:  Center(child: Text("Sign up",style: GoogleFonts.ptSans(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.white),)),
                    ),
                  ),
                ),
                const SizedBox(height: 18,),
                Center(child: Text("or sign up with",style: GoogleFonts.ptSans(fontSize: 12,color: Color(0xff000000).withOpacity(0.2)),)),
          
                const SizedBox(height: 28,),
          
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CupertinoButton(
                      onPressed: () {
                        
                      },
                      padding: EdgeInsets.zero,
                      child: Image.asset("assets/images/apple.png",scale: 4,)),
                    const SizedBox(width: 20,),
                    CupertinoButton(
                      onPressed: () {
                        
                      },
                      padding: EdgeInsets.zero,
                      child: Image.asset("assets/images/google.png",scale: 4,)),
                    const SizedBox(width: 20,),
                    CupertinoButton(
                      onPressed: () {
                        
                      },
                      padding: EdgeInsets.zero,
                      child: Image.asset("assets/images/facebook.png",scale: 4,)),
          
                  ],
                ),
                const SizedBox(height: 30,),
              TextButton(
                onPressed: () {
                  
                },
                child: Center(child: Text("Already have account? Login",style: GoogleFonts.ptSans(fontSize: 14),)))
              ],
            ),
          ),
        ),
      ),
    );
  }
}



TextStyle hintStyles=GoogleFonts.ptSans(fontSize: 14,fontWeight: FontWeight.w300);