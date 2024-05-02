import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nikeapp/screens/login_page.dart';
import 'package:nikeapp/screens/shop_page.dart';

class CheckUser extends StatelessWidget {
  const CheckUser({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Placeholder widget while checking user state
        } else {
          if (snapshot.hasData && snapshot.data != null) {
            // User is signed in
            return const ShopPage();
          } else {
            // User is not signed in
            return MyLoginPage();
          }
        }
      },
    );
  }
}
