import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../helpers/firebase_auth_helper.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  GlobalKey<FormState> signUpKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String? email;
  String? password;

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
                        "Sign Up",
                        style: GoogleFonts.ubuntu(
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Form(
                        key: signUpKey,
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
                                      hintText: "Enter UserName/ Email",
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
                                      hintText: "Enter Password",
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
                          if (signUpKey.currentState!.validate()) {
                            signUpKey.currentState!.save();

                            User? user = await FirebaseAuthHelper
                                .firebaseAuthHelper
                                .signUpUser(email: email!, password: password!);

                            if (user != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: const Text("Sign Up Successful.."),
                                  backgroundColor: Colors.cyanAccent,
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                              Navigator.of(context).pushNamed('login_page');
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text("Sign UP Failed! plz Try Again.."),
                                  backgroundColor: Colors.redAccent,
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                              Navigator.of(context).pop();
                            }
                          }

                          emailController.clear();
                          passwordController.clear();
                          email = "";
                          password = "";
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
                              "Sign Up",
                              style: GoogleFonts.ubuntu(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ))),
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 92),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account? ",
                  style: GoogleFonts.ubuntu(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed('login_page');
                  },
                  child: Text(
                    "Sign In",
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

  // validatorandSignUp() {
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: const Center(
  //         child: Text("Sign Up"),
  //       ),
  //       content: Form(
  //         key: signUpKey,
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             TextFormField(
  //               validator: (val) {
  //                 (val!.isEmpty) ? "Enter Email" : null;
  //               },
  //               controller: emailController,
  //               onSaved: (val) {
  //                 email = val;
  //               },
  //               decoration: const InputDecoration(
  //                 border: const OutlineInputBorder(),
  //                 labelText: "Email",
  //                 hintText: "Enter Email Here...",
  //               ),
  //             ),
  //             const SizedBox(height: 10),
  //             TextFormField(
  //               validator: (val) {
  //                 (val!.isEmpty) ? "Enter Password" : null;
  //               },
  //               controller: passwordController,
  //               onSaved: (val) {
  //                 password = val;
  //               },
  //               decoration: const InputDecoration(
  //                 border: OutlineInputBorder(),
  //                 labelText: "Password",
  //                 hintText: "Enter Password Here...",
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //       actions: [
  //         ElevatedButton(
  //           child: const Text("Sign Up"),
  //           onPressed: () async {
  //             if (signUpKey.currentState!.validate()) {
  //               signUpKey.currentState!.save();
  //
  //               User? user = await FirebaseAuthHelper.firebaseAuthHelper
  //                   .signUpUser(email: email!, password: password!);
  //
  //               if (user != null) {
  //                 ScaffoldMessenger.of(context).showSnackBar(
  //                   const SnackBar(
  //                     content: const Text("Sign Up Successful.."),
  //                     backgroundColor: Colors.cyanAccent,
  //                     behavior: SnackBarBehavior.floating,
  //                   ),
  //                 );
  //                 Navigator.of(context).pop();
  //                 // Navigator.of(context).pushReplacementNamed('/');
  //               } else {
  //                 ScaffoldMessenger.of(context).showSnackBar(
  //                   const SnackBar(
  //                     content: Text("Sign UP Failed! plz Try Again.."),
  //                     backgroundColor: Colors.redAccent,
  //                     behavior: SnackBarBehavior.floating,
  //                   ),
  //                 );
  //                 Navigator.of(context).pop();
  //               }
  //             }
  //
  //             emailController.clear();
  //             passwordController.clear();
  //             email = "";
  //             password = "";
  //           },
  //         ),
  //         ElevatedButton(
  //             onPressed: () {
  //               emailController.clear();
  //               passwordController.clear();
  //               email = "";
  //               password = "";
  //               Navigator.of(context).pop();
  //             },
  //             child: const Text("Cancel")),
  //       ],
  //     ),
  //   );
  // }
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
