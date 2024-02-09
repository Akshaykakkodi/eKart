import 'package:ekart/login/controller/login_controller.dart';
import 'package:ekart/products/controller/product_controller.dart';
import 'package:ekart/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options:const FirebaseOptions(
        apiKey: "AIzaSyBXf6onhxQll5wqclOq1Juw-ofEpraT9ZE", 
        appId: "1:699980387017:android:4eaea2a42cff9f1f597318", 
        messagingSenderId: "699980387017", 
        projectId: "ekart-65791")

    );
    runApp(MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => ProductController(),
      ),
      ChangeNotifierProvider(
        create: (context) => LoginController(),
      )
    ], child: const MyApp()));
  } catch (e) {
    print("Firebase initialization error: $e");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'eKart',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
