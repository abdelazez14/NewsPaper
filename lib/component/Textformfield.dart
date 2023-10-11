import 'package:flutter/material.dart';
class AuthTextFormField extends StatelessWidget {
  const AuthTextFormField({super.key, required this.hinttext, required this.mycontroller,required this.validator});

  final String hinttext;
  final TextEditingController mycontroller;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator:validator ,
      controller: mycontroller,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[200],
          hintText: hinttext,
          hintStyle: TextStyle(fontSize: 10,color: Colors.grey),
          contentPadding: EdgeInsets.symmetric(horizontal: 25),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(color: Color.fromARGB(255, 184, 184, 184)),

          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(color: Colors.grey),
          )
      ),
    );
  }
}
