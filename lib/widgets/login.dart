import 'package:chat_app/widgets/forgot.dart';
import 'package:chat_app/widgets/list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/widgets/register.dart';
import 'package:fluttertoast/fluttertoast.dart';
class LoginPage extends StatelessWidget {
  var emailEditingController = TextEditingController();
  var passwordEditingController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login"),
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
                      backgroundColor: Colors.red,
                      primary: Colors.white),
                  onPressed: () {
                    _auth.signInWithEmailAndPassword(email: emailEditingController.text,
                        password: passwordEditingController.text).then((value) =>
                    {
                      if (value != null){

                        Navigator.push(context,
                        MaterialPageRoute(builder: (context)=>ListPage(userId: value.user!.uid,))
                    )
                      }
                      else {
                      Fluttertoast.showToast(
                      msg: "Login unsuccesful. Please try again",
                      toastLength: Toast.LENGTH_SHORT,

                    )
                      }
                    }).catchError((onError){

                    Fluttertoast.showToast(
                    msg: onError.message,
                    toastLength: Toast.LENGTH_SHORT,

                    );
                    });


                  }, child: Text("Login")),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                    MaterialPageRoute(builder: (context)=>RegisterPage())
                  );

                },
                child: Text("No Account? Sign Up!"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=>ForgotPage())
                  );

                },
                child: Text("Forgot Password"),
              ),
            ],
          ),
        ));
  }
}
