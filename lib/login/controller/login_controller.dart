import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ekart/login/view/otp_verification_screen.dart';
import 'package:ekart/login/view/registration_screen.dart';
import 'package:ekart/products/view/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginController extends ChangeNotifier{

  bool isSendingCode=false;


String verificationCode='';
List<TextEditingController> cntrls=List.generate(6, (index) => TextEditingController());
List<FocusNode> otpFocusNodes = List.generate(6, (index) => FocusNode());
String otpCode='';
String userId='';


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
      userId=user!.uid;

      bool isNewUser = userCredential.additionalUserInfo?.isNewUser ?? false;
      if (isNewUser) {
        // ignore: use_build_context_synchronously
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const RegistrationScreen()));
      } else {
       // ignore: use_build_context_synchronously
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>const Home(
                      
                    )));
      }
    } catch (e) {
      print(e.toString());
    }
    otpCode="";
    for(int i=0;i<6;i++){
      cntrls[i].clear();
    }
    
    notifyListeners();
  }


  logOut()async{
   var auth= FirebaseAuth.instance;
  await auth.signOut();
  }



   Future<void> addUserDataToFirestore(String name, String email,String address,BuildContext context) async {
    try {
      // Access the Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Collection reference (replace 'users' with your desired collection name)
      CollectionReference users = firestore.collection('users');

      // Add a document to the 'users' collection with the user's UID as the document ID
      await users.doc(userId).set({
        'name': name,
        'email': email,
        'address': address, 
      });

      print('Data added to Firestore successfully');
      Navigator.push(context, MaterialPageRoute(builder: (context) =>const Home(),));
    } catch (e) {
      print('Error adding data to Firestore: $e');
    }
  }
  

}