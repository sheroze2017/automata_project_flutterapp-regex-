import 'package:automata_project/screens/home.dart';
import 'package:automata_project/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class signUpScreen extends StatefulWidget {
  const signUpScreen({Key? key}) : super(key: key);

  @override
  State<signUpScreen> createState() => _signUpScreenState();
}

class _signUpScreenState extends State<signUpScreen> {
  bool changebtn = false;

  final TextEditingController emailcontroller = new TextEditingController();
  final TextEditingController passwordcontroller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(15, 110, 0, 0),
                child: Text(
                  "UBIT",
                  style: TextStyle(fontSize: 60.0, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(15, 175, 0, 0),
                child: Text(
                  "PORTAL",
                  style: TextStyle(fontSize: 60.0, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(235, 220, 0, 0),
                child: Text(
                  "Ku",
                  style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(top: 30, right: 20, left: 20, bottom: 0),
            child: Column(
              children: [
                TextFormField(
                  controller: emailcontroller,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                ),
                TextFormField(
                  controller: passwordcontroller,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                  obscureText: true,
                ),
                SizedBox(
                  height: 15.0,
                ),
                InkWell(
                  onTap: () async {
                    // try {
                    validatePassword(
                        passwordcontroller.text, emailcontroller.text);
                    // }
                    // on FirebaseAuthException catch (e) {
                    //   if (e.code == 'user-not-found') {
                    //     print('No user found for that email.');
                    //   } else if (e.code == 'wrong-password') {
                    //     print('Wrong password provided for that user.');
                    //   }
                    // }
                    setState(() {
                      changebtn = true;
                    });
                  },
                  child: AnimatedContainer(
                    duration: Duration(seconds: 1),
                    height: 43.0,
                    width: changebtn ? 50 : 150,
                    child: Material(
                      borderRadius: BorderRadius.circular(changebtn ? 50 : 8),
                      shadowColor: Colors.greenAccent,
                      color: Colors.green,
                      elevation: 7.0,
                      child: Center(
                        child: changebtn
                            ? Icon(Icons.done_all_outlined)
                            : Text(
                                'Create  Account',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat'),
                              ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Get.to(loginScreen());
                    },
                    child: new Text(
                      "Already have an account?",
                      style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  validatePassword(String pass, String email) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    RegExp regexEmail = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (pass.isEmpty || email.isEmpty) {
      return Get.snackbar("Error", "Please enter Fields");
    } else {
      if (!regex.hasMatch(pass) && !regexEmail.hasMatch(email)) {
        return Get.snackbar('Error', 'Enter Valid Email & Password');
      }
      if (!regex.hasMatch(pass)) {
        return Get.snackbar('Error', 'Enter Valid Password');
      }
      if (!regexEmail.hasMatch(email)) {
        return Get.snackbar('Error', 'Enter Valid Email');
      } else {
        return FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: pass)
            .then((value) => Get.to(homeScreen()));
        ;
      }
    }
  }
}
