import 'package:ekart/constants/app_constants.dart';
import 'package:ekart/login/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  @override
  void dispose() {
    // TODO: implement dispose
    for(var node in Provider.of<LoginController>(context).otpFocusNodes){
      node.dispose();
    }
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    
    

    return  Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment:  MainAxisAlignment.center,
          children: [
          const  Center(child: Text("Enter the otp send to your mobile number ",style: TextStyle(color: Colors.white),)),
          const  SizedBox(height: 20,),

            Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: 
               List.generate(6, (index) =>  Padding(
                 padding: const EdgeInsets.all(5.0),
                 child: Consumer<LoginController>(
                  builder: (context, value, child) => 
                    TextFormField(
                 
                     controller: value.cntrls[index],
                     maxLength: 1,
                     focusNode:value.otpFocusNodes[index],
                     
                     textAlign: TextAlign.center,
                       onChanged: (text) {
                      if (text.length == 1) {
                        value.otpFocusNodes[index].unfocus();
                        if (index < 5) {
                          FocusScope.of(context)
                              .requestFocus(value.otpFocusNodes[index + 1]);
                        }
                      }
                    },
                     keyboardType: TextInputType.number,
                     decoration: InputDecoration(
                       contentPadding:const EdgeInsets.all(10),
                     
                       filled: true,
                       
                       fillColor: Colors.white,
                       counterText: "",
                       
                       constraints:const BoxConstraints(
                 
                         maxHeight: 45,
                         maxWidth: 50
                       ),
                       border: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(5)
                       )
                     ),
                     inputFormatters: [
                             FilteringTextInputFormatter.allow(RegExp(r'[0-9]')), // Allow only numeric characters
                           ],
                   ),
                 ),
               ),)
             ,
              ),
            const SizedBox(height: 20,),

             InkWell(
              onTap: () {
                Provider.of<LoginController>(context,listen: false).signInWithPhoneNumber( context);
              },
              child: Container(
                height: 45,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.blueAccent
                ),
                child:const Center(child: Text("Submit",style: TextStyle(color: Colors.white,fontSize: 16),)),
              ),
            )

            
          ],
        ),
      ),
    );
  }
}