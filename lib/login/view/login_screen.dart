import 'package:ekart/constants/app_constants.dart';
import 'package:ekart/login/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginSCreen extends StatefulWidget {
  const LoginSCreen({super.key});

  @override
  State<LoginSCreen> createState() => _LoginSCreenState();
}

class _LoginSCreenState extends State<LoginSCreen> {
  TextEditingController phoneNumberCntrl = TextEditingController();
  final fkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Provider.of<LoginController>(context).isSendingCode
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Form(
                key: fkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Please enter your mobile number",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: TextFormField(
                        controller: phoneNumberCntrl,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value!.isEmpty) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content:
                                  Text("Please eneter a your mobile number"),
                              duration: Duration(seconds: 1),
                              backgroundColor: Colors.blue,
                            ));
                          } else if (value.length < 10) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Please eneter a valid number"),
                              duration: Duration(seconds: 1),
                            ));
                          } 
                          return null;
                        },
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            constraints: const BoxConstraints(
                                maxHeight: 50, maxWidth: 250),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        if (fkey.currentState!.validate()) {
                          Provider.of<LoginController>(context, listen: false)
                              .verifyPhoneNumber(
                                  phoneNumberCntrl.text, context);
                        }
                      },
                      child: Container(
                        height: 45,
                        width: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blueAccent),
                        child: const Center(
                            child: Text(
                          "Send otp",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        )),
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
