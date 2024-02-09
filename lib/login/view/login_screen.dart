import 'package:ekart/constants/app_constants.dart';
import 'package:ekart/login/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginSCreen extends StatelessWidget {
  const LoginSCreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController phoneNumberCntrl=TextEditingController();
    return  Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child:Provider.of<LoginController>(context).isSendingCode?const Center(child: CircularProgressIndicator(),): 
        Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [

           const Text("Please enter your mobile number",style: TextStyle(color: Colors.white),),
            const SizedBox(height: 20,),
            Center(
              child: TextFormField(
                controller: phoneNumberCntrl,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  constraints:const BoxConstraints(
                    maxHeight: 50,
                    maxWidth: 250
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )
                ),
              ),
            ),
            const SizedBox(height: 20,),

            InkWell(
              onTap: () {
               Provider.of<LoginController>(context,listen: false).verifyPhoneNumber(phoneNumberCntrl.text, context);
              },
              child: Container(
                height: 45,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.blueAccent
                ),
                child:const Center(child: Text("Send otp",style: TextStyle(color: Colors.white,fontSize: 16),)),
              ),
            )
          ],
        ),
      ),
    );
  }
}