import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_project/custom_widgets.dart';
import 'package:firebase_project/home_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignupPg extends StatefulWidget {
  const SignupPg({Key? key}) : super(key: key);

  @override
  State<SignupPg> createState() => _SignupPgState();
}

class _SignupPgState extends State<SignupPg> {
  TextEditingController _usernamecontrollerup = TextEditingController();
  TextEditingController _passwordcontrollerup = TextEditingController();
  TextEditingController _emailcontrollerup = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: w,
        height: h,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.grey, Colors.black],
        )),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                mytextfield("Enter Username", Icons.person_outline, false,
                    _usernamecontrollerup),
                SizedBox(
                  height: 20,
                ),
                mytextfield("Enter e-mail address", Icons.mail_outline, false,
                    _emailcontrollerup),
                SizedBox(
                  height: 20,
                ),
                mytextfield("Enter Password", Icons.lock_outline, true,
                    _passwordcontrollerup),
                SizedBox(
                  height: 20,
                ),
                mybutton(context, "SIGN UP", () {
                  FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: _emailcontrollerup.text,
                          password: _passwordcontrollerup.text)
                      .then((value) {
                    print("Created New Account");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Home()));
                  }).onError((error, stackTrace) {
                    Fluttertoast.showToast(
                        msg: error.toString(), gravity: ToastGravity.TOP);
                    print("Error ${error.toString()}");
                  });
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
