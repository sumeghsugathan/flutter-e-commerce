import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nikeapp/components/my_button.dart';
import 'package:nikeapp/components/my_text_field.dart';

class PhoneAuth extends StatelessWidget {
  PhoneAuth({super.key});
  final mobileController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Forgot Password"),
        centerTitle: true,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 45),
                    MyTextField(
                      controller: mobileController,
                      labelText: "Phone number",
                      hintText: '705846xxxx',
                      textInputAction: TextInputAction.done,
                    ),
                    const SizedBox(height: 45),
                    MyButton(
                      onTap: () async {
                        await FirebaseAuth.instance.verifyPhoneNumber(
                          verificationCompleted:
                              (PhoneAuthCredential credential) {},
                          verificationFailed: (FirebaseAuthException ex) {},
                          codeSent:
                              (String verificationid, int? resendtoken) {},
                          codeAutoRetrievalTimeout: (String verificationid) {},
                          phoneNumber: mobileController.text.toString(),
                        );
                      },
                      height: 70,
                      child: Text(
                        textAlign: TextAlign.center,
                        "Send OTP",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 45),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
