import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/custom_widgets.dart';

import 'package:flutter/material.dart';

class resetpg extends StatefulWidget {
  const resetpg({Key? key}) : super(key: key);

  @override
  State<resetpg> createState() => _resetpgState();
}

class _resetpgState extends State<resetpg> {
  final TextEditingController _emailcontrollerrs = TextEditingController();

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
          "Reset Password",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: w,
        height: h,
        decoration: const BoxDecoration(
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
                const SizedBox(
                  height: 20,
                ),
                mytextfield("Enter e-mail address", Icons.mail_outline, false,
                    _emailcontrollerrs),
                const SizedBox(
                  height: 20,
                ),
                mybutton(context, "RESET PASSWORD", () {
                  FirebaseAuth.instance
                      .sendPasswordResetEmail(email: _emailcontrollerrs.text)
                      .then((value) => Navigator.of(context).pop());
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
