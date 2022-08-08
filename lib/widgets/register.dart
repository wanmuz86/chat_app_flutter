import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterPage extends StatelessWidget {
  var emailEditingController = TextEditingController();
  var passwordEditingController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Register"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                  controller: emailEditingController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(hintText: "Enter your email")),
              TextField(
                controller: passwordEditingController,
                obscureText: true,
                decoration: InputDecoration(hintText: "Enter your password"),
              ),
              TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.red, primary: Colors.white),
                  onPressed: () async {
                    try {
                      // user = User that has been succesfully registerd
                      var user = await _auth.createUserWithEmailAndPassword(
                          email: emailEditingController.text,
                          password: passwordEditingController.text);

                      if (user != null) {
                        FirebaseFirestore.instance.collection('users').doc(user.user!.uid).set({
                          'email':user.user!.email,
                          'id':user.user!.uid,
                          'createdAt':DateTime.now(),
                          'chattingWith':null

                        });
                        Fluttertoast.showToast(
                          msg: "Successfully registered. You may log in",
                          toastLength: Toast.LENGTH_SHORT,

                        );
                        Navigator.pop(context);
                      } else {
                        Fluttertoast.showToast(
                          msg: "Something is wrong, please try again.",
                          toastLength: Toast.LENGTH_SHORT,

                        );
                      }
                    }
                    on FirebaseAuthException catch (onError){

                      Fluttertoast.showToast(
                          msg:onError.message!,
                          toastLength: Toast.LENGTH_SHORT);
                    }
                  },
                  child: Text("Register")),
            ],
          ),
        ));
  }
}
