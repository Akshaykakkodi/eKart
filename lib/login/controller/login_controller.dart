import 'package:ekart/login/view/otp_verification_screen.dart';
import 'package:ekart/products/view/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginController extends ChangeNotifier{

  bool isSendingCode=false;


String verificationCode='';
List<TextEditingController> cntrls=List.generate(6, (index) => TextEditingController());
String otpCode='';


  Future<void> verifyPhoneNumber(String phoneNumber,BuildContext context) async {
    try {
      isSendingCode=true;
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91$phoneNumber',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verificationId, int? resendToken) {
          
            verificationCode = verificationId;
          
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                     const OtpVerificationScreen(),
                ));
          
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      print(e.toString());
    }
    finally{
      isSendingCode=false;
    }
      notifyListeners();
  }



  User? user;
  Future<void> signInWithPhoneNumber(BuildContext context) async {
    for(int i=0;i<cntrls.length;i++){
    otpCode=  otpCode+cntrls[i].text;
    }

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationCode,
        smsCode: otpCode,
      );
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      user = FirebaseAuth.instance.currentUser;
      bool isNewUser = userCredential.additionalUserInfo?.isNewUser ?? false;
      if (isNewUser) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home()));
      } else {
        // ignore: use_build_context_synchronously
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => DashboardScreen(
        //               user: user!,
        //             )));
      }
    } catch (e) {
      print(e.toString());
    }

    notifyListeners();
  }
  

}