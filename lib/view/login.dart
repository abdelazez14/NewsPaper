import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:newspaper/component/customButton.dart';
import 'package:newspaper/component/customLogoauth.dart';
import 'package:get/get.dart';
import '../component/Textformfield.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();



  Future<void> signInWithGoogle() async {
    try {
      // Trigger the Google Sign In process
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Check if the user canceled the sign-in
      if (googleUser == null) {
        return;
      }

      // Obtain the authentication details from the GoogleSignInAccount
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential using the obtained tokens
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the obtained credential
      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      // Get the user from the UserCredential
      final User? user = userCredential.user;

      // Check if the user was successfully signed in
      if (user != null) {
        // Navigate to the homepage after successful sign-in
        Get.offNamed("homepage");
      } else {
        // Handle the case where the user is null (sign-in failed)
        print("Sign-in failed");
      }
    } catch (e) {
      // Handle any exceptions that occur during the sign-in process
      print("Error during sign-in: $e");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Form(
              key: formstate,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 50,
                  ),
                  const CustomLogoAuth(),
                  Container(
                    height: 15,
                  ),
                  const Text(
                    "Login",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Login to continue using the App",
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                  Container(
                    height: 20,
                  ),
                  const Text(
                    "Email",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  Container(
                    height: 10,
                  ),
                  AuthTextFormField(
                      hinttext: 'Enter your email address',
                      mycontroller: email,
                      validator: (val) {
                        if (val == "") {
                          return "Can't be Empty";
                        }
                      }),
                  Container(
                    height: 15,
                  ),
                  const Text(
                    "Password",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  Container(
                    height: 10,
                  ),
                  AuthTextFormField(
                    hinttext: 'Enter your password',
                    mycontroller: password,
                    validator: (val) {
                      if (val == "") {
                        return "Can't be Empty";
                      }
                    },
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    margin: const EdgeInsets.only(top: 10, bottom: 20),
                    child: const Text(
                      "Forget password ?",
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 15,
            ),
            CustomButtonAuth(
              text: "Login",
              onPressed: () async {
                if (formstate.currentState!.validate()) {
                  try {
                    final credential =
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: email.text,
                      password: password.text,
                    );
                    if(credential.user!.emailVerified){
                      Get.offAllNamed("homepage");
                    }else{
                      FirebaseAuth.instance.currentUser!.sendEmailVerification();
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.rightSlide,
                        title: 'Error',
                        desc: 'الرجاء التوجه الي بريدك الالكتروني و الضغط علي لينك التحقق حتي يتم تسجيل الدخول ',
                      ).show();
                    }

                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      print('-------------------------------------No user found for that email.');
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.rightSlide,
                        title: 'Error',
                        desc: 'No user found for that email.',
                      ).show();
                    } else if (e.code == 'wrong-password') {
                      print('Wrong password provided for that user.');
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.rightSlide,
                        title: 'Error',
                        desc: 'Wrong password provided for that user.',
                      ).show();
                    }
                  }
                } else {
                  print("not valid");
                }
              },
            ),
            Container(
              height: 20,
            ),
            // MaterialButton(
            //   color: Colors.red,
            //   height: 50,
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(20),
            //   ),
            //   onPressed: () {
            //     signInWithGoogle();
            //
            //   },
            //   textColor: Colors.white,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceAround,
            //     children: [
            //       const Text(
            //         "Login with Google",
            //         style: TextStyle(fontSize: 11),
            //       ),
            //       Image.asset(
            //         "assets/image/google.png",
            //         width: 20,
            //       ),
            //     ],
            //   ),
            // ),
            Container(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Get.offNamed("signup");
              },
              child: const Center(
                child: Text.rich(TextSpan(children: [
                  TextSpan(
                      text: "Don't Have An Account ?",
                      style: TextStyle(fontSize: 11)),
                  TextSpan(
                      text: "Register",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.orange)),
                ])),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
