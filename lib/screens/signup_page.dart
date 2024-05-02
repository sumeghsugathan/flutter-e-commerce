import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nikeapp/components/my_button.dart';
import 'package:nikeapp/components/my_text_field.dart';
import 'package:nikeapp/models/signup_model.dart';
import 'package:nikeapp/screens/login_page.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final signUpModel = Provider.of<SignUpModel>(context);

    Future<void> signup(BuildContext context) async {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      if (email.isEmpty ||
          password.isEmpty ||
          signUpModel.pickedImage == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              textAlign: TextAlign.center,
              "Please fill required fields",
            ),
          ),
        );
        return;
      }

      try {
        // Perform sign up with email and password
        final userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Upload image to Firebase Storage
        final storageRef =
            FirebaseStorage.instance.ref("Profile Pics").child(email);
        final uploadTask = storageRef.putFile(signUpModel.pickedImage!);
        await uploadTask.whenComplete(() => null);

        // Get download URL of the uploaded image
        final String imageUrl = await storageRef.getDownloadURL();

        // Save user data to Firestore
        await FirebaseFirestore.instance.collection("Users").doc(email).set({
          "Email": email,
          "Image": imageUrl,
        });

        // Navigate to login page
        if (context.mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => MyLoginPage(),
            ),
          );
          signUpModel.resetPickedImage();
        }

        // Show success message
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                textAlign: TextAlign.center,
                "User created successfully.",
              ),
            ),
          );
        }
      } on FirebaseAuthException catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                textAlign: TextAlign.center,
                e.message ?? "An error occurred. Please try again later.",
              ),
            ),
          );
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0,
        foregroundColor: Colors.black,
        title: const Text("Sign Up"),
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                            barrierColor: Colors.transparent,
                            context: context,
                            builder: (context) => AlertDialog(
                              backgroundColor: Colors.black.withOpacity(.7),
                              title: Text(
                                'Pick image from',
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 20,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    onTap: () {
                                      Navigator.pop(context);
                                      signUpModel.pickImage(ImageSource.camera);
                                    },
                                    leading: Icon(
                                      Icons.camera_alt,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                    title: Text(
                                      'Camera',
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                    ),
                                  ),
                                  ListTile(
                                    onTap: () {
                                      Navigator.pop(context);
                                      signUpModel
                                          .pickImage(ImageSource.gallery);
                                    },
                                    leading: Icon(
                                      Icons.image,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                    title: Text(
                                      'Gallery',
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        child: CircleAvatar(
                          radius: 80,
                          backgroundImage: signUpModel.pickedImage != null
                              ? FileImage(signUpModel.pickedImage!)
                              : null,
                          backgroundColor:
                              Theme.of(context).colorScheme.inversePrimary,
                          child: signUpModel.pickedImage == null
                              ? const Icon(
                                  Icons.person,
                                  size: 70,
                                )
                              : null,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    MyTextField(
                      controller: emailController,
                      labelText: "Email",
                      hintText: 'johndoe@examplemail.com',
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 10),
                    MyTextField(
                      controller: passwordController,
                      labelText: "Password",
                      hintText: 'shgay#@jdj123',
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    MyButton(
                      onTap: () => signup(context),
                      color: Theme.of(context).colorScheme.inversePrimary,
                      width: 150,
                      height: 70,
                      child: Text(
                        'Sign Up',
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
                          "Already have an account ?",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            signUpModel.resetPickedImage();
                            Navigator.pushNamed(context, '/login_page');
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 21,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 100),
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
