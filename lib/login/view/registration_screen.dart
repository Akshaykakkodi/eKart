import 'package:ekart/constants/app_constants.dart';
import 'package:ekart/login/controller/login_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController=TextEditingController();
    TextEditingController emailController=TextEditingController();
    TextEditingController addressController=TextEditingController();
    return  Scaffold(
      body: SafeArea(
        child: Column(
          children: [
           const  SizedBox(height: 20,),
         const   Text("Enter your details"),
          const   SizedBox(height: 20,),
            Center(
              child: TextField(
                controller: nameController,
                decoration:const InputDecoration(
                  hintText: "Enter fullname",
                  constraints: BoxConstraints(
                    maxWidth: 300
                  )
                ),
              ),
            ),
           const  SizedBox(height: 20,),
            Center(
              child: TextField(
                controller: emailController,
                decoration:const InputDecoration(
                  hintText: "Email",
                  constraints: BoxConstraints(
                    maxWidth: 300
                  )
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Center(
              child: TextField(
                controller: addressController,
                decoration:const InputDecoration(
                  hintText: "Address",
                  constraints: BoxConstraints(
                    maxWidth: 300
                  )
                ),
              ),
            ),
          const  Spacer(),
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
              Provider.of<LoginController>(context,listen: false).addUserDataToFirestore(nameController.text, emailController.text, addressController.text,context);
              },
              child: Container(
                height: 50,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: primaryColor
                ),
                child:const Center(child: Text("Save",style: TextStyle(color: Colors.white,fontSize: 16),)),
              ),
            ),
            const SizedBox(height: 25,)
          ],
        ),
      ),
    );
  }
}