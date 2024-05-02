import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nikeapp/components/check_user.dart';
import 'package:nikeapp/models/shop.dart';
import 'package:nikeapp/models/signup_model.dart';
import 'package:nikeapp/screens/cart_page.dart';
import 'package:nikeapp/screens/forgot_password_page.dart';
import 'package:nikeapp/screens/login_page.dart';
import 'package:nikeapp/screens/payment_page.dart';
import 'package:nikeapp/screens/phone_auth.dart';
import 'package:nikeapp/screens/shop_page.dart';
import 'package:nikeapp/screens/signup_page.dart';
import 'package:nikeapp/screens/splashscreen.dart';
import 'package:provider/provider.dart';
import 'themes/light_mode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => Shop()),
      ChangeNotifierProvider(
        create: (context) => SignUpModel(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: const SplashScreen(),
      theme: lightMode,
      routes: {
        '/login_page': (context) => MyLoginPage(),
        '/signup_page': (context) => SignUpPage(),
        '/shop_page': (context) => const ShopPage(),
        '/cart_page': (context) => const CartPage(),
        '/payment_page': (context) => const PaymentPage(
              totalPrice: 0.0,
            ),
        '/forgot_password': (context) => ForgotPassword(),
        '/phone_auth': (context) => PhoneAuth(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
