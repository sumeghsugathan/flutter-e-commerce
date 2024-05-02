import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nikeapp/components/my_button.dart';
import 'package:nikeapp/components/my_text_field.dart';
import 'package:nikeapp/screens/shop_page.dart';

class MyLoginPage extends StatelessWidget {
  MyLoginPage({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  login(String email, String password, BuildContext context) async {
    if (email == "" && password == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            textAlign: TextAlign.center,
            "Enter required fields",
            style: TextStyle(fontSize: 18),
          ),
        ),
      );
    } else {
      UserCredential? usercredential;
      try {
        usercredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password)
            .then((value) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const ShopPage(),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                textAlign: TextAlign.center,
                "User logged in successfully",
              ),
            ),
          );
          return null;
        });
      } on FirebaseAuthException catch (ex) {
        if (context.mounted) {
          return ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                ex.code.toString(),
              ),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0,
        foregroundColor: Colors.black,
        title: const Text("Login"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    MyTextField(
                      controller: emailController,
                      labelText: "Email",
                      hintText: 'johndoe@examplemail.com',
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    MyTextField(
                      controller: passwordController,
                      labelText: "Password",
                      hintText: 'shgay#@jdj123',
                      obscureText: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/forgot_password');
                            },
                            child: const Text(
                              "Forgot password",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    MyButton(
                      onTap: () {
                        login(emailController.text.toString(),
                            passwordController.text.toString(), context);
                      },
                      color: Theme.of(context).colorScheme.inversePrimary,
                      width: 150,
                      height: 70,
                      child: Text(
                        "Login",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "New user ?",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/signup_page');
                          },
                          child: const Text(
                            "SignUp",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 21,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
