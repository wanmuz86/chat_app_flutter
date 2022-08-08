import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class ForgotPage extends StatelessWidget {
  var emailEditingController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(appBar: AppBar(title: Text("Register"),),
        body:  Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: emailEditingController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(hintText: "Enter your email")),
              TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      primary: Colors.white),
                  onPressed: () {
                    _auth.sendPasswordResetEmail(email: emailEditingController.text);
                    Fluttertoast.showToast(
                      msg: "A reset password email has been sent. Please check your email.",
                      toastLength: Toast.LENGTH_SHORT,

                    );
                  }, child: Text("Reset Password")),

            ],
          ),
        )
    );
  }
}
