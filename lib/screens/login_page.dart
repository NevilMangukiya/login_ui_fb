import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../helpers/firebase_auth_helper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> signUpKey = GlobalKey<FormState>();
  GlobalKey<FormState> LoginKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailSignInController = TextEditingController();
  TextEditingController passwordSignInController = TextEditingController();

  String? email;
  String? password;
  String? repassword;
  String? SignInemail;
  String? SignInpassword;

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ClipPath(
                  clipper: DrawClip2(),
                  child: Container(
                    width: _width,
                    height: _height * 0.8,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0xffa58fd2), Color(0xffddc3fc)],
                          begin: Alignment.bottomCenter,
                          end: Alignment.bottomRight),
                    ),
                  ),
                ),
                ClipPath(
                  clipper: DrawClip(),
                  child: Container(
                    width: _width,
                    height: _height * 0.8,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0xffddc3fc), Color(0xff91c5fc)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Column(
                    children: [
                      Text(
                        "Login",
                        style: GoogleFonts.ubuntu(
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Form(
                        key: LoginKey,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 10),
                              child: Container(
                                padding: const EdgeInsets.only(left: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.white),
                                child: TextFormField(
                                  controller: emailController,
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "Enter valid username/email";
                                    }
                                    null;
                                  },
                                  onSaved: (val) {
                                    setState(() {
                                      email = val;
                                    });
                                  },
                                  decoration: InputDecoration(
                                      hintText: "User Name/ Email",
                                      hintStyle: GoogleFonts.ubuntu(
                                          color: Colors.grey),
                                      contentPadding: const EdgeInsets.only(
                                          top: 15, bottom: 15),
                                      border: const UnderlineInputBorder(
                                          borderSide: BorderSide.none)),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 10),
                              child: Container(
                                padding: const EdgeInsets.only(left: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.white),
                                child: TextFormField(
                                  controller: passwordController,
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "Enter valid password";
                                    }
                                    null;
                                  },
                                  onSaved: (val) {
                                    setState(() {
                                      password = val;
                                    });
                                  },
                                  decoration: InputDecoration(
                                      hintText: "Password",
                                      hintStyle: GoogleFonts.ubuntu(
                                          color: Colors.grey),
                                      contentPadding: const EdgeInsets.only(
                                          top: 15, bottom: 15),
                                      border: const UnderlineInputBorder(
                                          borderSide: BorderSide.none)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () async {
                          if (LoginKey.currentState!.validate()) {
                            LoginKey.currentState!.save();

                            User? user = await FirebaseAuthHelper
                                .firebaseAuthHelper
                                .signInUser(email: email!, password: password!);

                            if (user != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Sign In Successful.."),
                                  backgroundColor: Colors.cyanAccent,
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                              Navigator.of(context).pop();

                              Navigator.of(context)
                                  .pushReplacementNamed('/', arguments: user);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Sign In Failed! plz Try Again..",
                                  ),
                                  backgroundColor: Colors.redAccent,
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                              Navigator.of(context).pop();
                            }
                            emailSignInController.clear();
                            passwordSignInController.clear();

                            SignInemail = "";
                            SignInpassword = "";
                          }
                        },
                        child: Container(
                            margin: const EdgeInsets.only(
                                top: 20, left: 50, right: 50),
                            decoration: BoxDecoration(
                                color: const Color(0xff6a74ce),
                                borderRadius: BorderRadius.circular(30)),
                            height: 50,
                            child: Center(
                                child: Text(
                              "Login",
                              style: GoogleFonts.ubuntu(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ))),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Forgot your password?",
                        style: GoogleFonts.ubuntu(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Text(
              "Connect with us",
              style: GoogleFonts.ubuntu(
                  color: Colors.blueGrey, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {
                      User? user = await FirebaseAuthHelper.firebaseAuthHelper
                          .signInAnonymously();

                      if (user != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text("Login Successful.. with UID:${user.uid}"),
                            backgroundColor: Colors.cyanAccent,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                        Navigator.of(context)
                            .pushReplacementNamed('/', arguments: user);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Login Failed! plz Try Again.."),
                            backgroundColor: Colors.redAccent,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                              color: Color(0xff38a4ef),
                              offset: Offset(3.0, 3.0),
                              blurRadius: 15,
                              spreadRadius: 1.0),
                          BoxShadow(
                              color: Colors.white,
                              offset: Offset(-3.0, -3.0),
                              blurRadius: 15,
                              spreadRadius: 1.0),
                        ],
                        borderRadius: BorderRadius.circular(30),
                        color: const Color(0xff38a4ef),
                      ),
                      height: 40,
                      width: 150,
                      child: Center(
                        child: Text(
                          "Guest",
                          style: GoogleFonts.ubuntu(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () async {
                      User? user = await FirebaseAuthHelper.firebaseAuthHelper
                          .signInWithGoogle();

                      if (user != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text("Login Successful.. with UID:${user.uid}"),
                            backgroundColor: Colors.cyanAccent,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                        Navigator.of(context)
                            .pushReplacementNamed('/', arguments: user);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Login Failed! plz Try Again.."),
                            backgroundColor: Colors.redAccent,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                              color: Color(0xff38a4ef),
                              offset: Offset(3.0, 3.0),
                              blurRadius: 15,
                              spreadRadius: 1.0),
                          BoxShadow(
                              color: Colors.white,
                              offset: Offset(-3.0, -3.0),
                              blurRadius: 15,
                              spreadRadius: 1.0),
                        ],
                        borderRadius: BorderRadius.circular(30),
                        color: const Color(0xff5172b4),
                      ),
                      height: 40,
                      width: 150,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/images/gog.png",
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Google",
                              style: GoogleFonts.ubuntu(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account? ",
                  style: GoogleFonts.ubuntu(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed('sign_up');
                  },
                  child: Text(
                    "Sign Up",
                    style: GoogleFonts.ubuntu(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class DrawClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.80);
    path.cubicTo(size.width / 4, size.height, 3 * size.width / 4,
        size.height / 2, size.width, size.height * 0.8);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class DrawClip2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.08);
    path.cubicTo(size.width / 4, size.height, 3 * size.width / 4,
        size.height / 2, size.width, size.height * 0.9);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
