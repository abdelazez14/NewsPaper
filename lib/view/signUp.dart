import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newspaper/component/customButton.dart';
import 'package:newspaper/component/customLogoauth.dart';
import 'package:get/get.dart';
import '../component/Textformfield.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

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
                    "Register",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Register to continue using the App",
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                  Container(
                    height: 20,
                  ),
                  const Text(
                    "Username",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  Container(
                    height: 10,
                  ),
                  AuthTextFormField(
                    validator: (val) {
                      if (val == "") {
                        return "Can't be Empty";
                      }
                    },
                    hinttext: 'Enter your username',
                    mycontroller: username,
                  ),
                  Container(
                    height: 15,
                  ),
                  const Text(
                    "Email",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  Container(
                    height: 10,
                  ),
                  AuthTextFormField(
                    validator: (val) {
                      if (val == "") {
                        return "Can't be Empty";
                      }
                    },
                    hinttext: 'Enter your email address',
                    mycontroller: email,
                  ),
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
                    validator: (val) {
                      if (val == "") {
                        return "Can't be Empty";
                      }
                    },
                    hinttext: 'Enter your password',
                    mycontroller: password,
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
              text: "Sign up",
              onPressed: () async {
                if (formstate.currentState!.validate()) {
                  try {
                    final credential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                      email: email.text,
                      password: password.text,
                    );
                    FirebaseAuth.instance.currentUser!.sendEmailVerification();
                    Get.toNamed("login");
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      print('The password provided is too weak.');
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.rightSlide,
                        title: 'Error',
                        desc: 'The password provided is too weak.',
                      ).show();
                    } else if (e.code == 'email-already-in-use') {
                      print('The account already exists for that email.');
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.rightSlide,
                        title: 'Error',
                        desc: 'The account already exists for that email.',
                      ).show();
                    }
                  } catch (e) {
                    print(e);
                  }
                }
              },
            ),
            Container(
              height: 20,
            ),
            Container(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Get.offNamed("login");
              },
              child: const Center(
                child: Text.rich(TextSpan(children: [
                  TextSpan(
                      text: "Have An Account ?",
                      style: TextStyle(fontSize: 11)),
                  TextSpan(
                      text: "Login",
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
