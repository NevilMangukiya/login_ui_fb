import 'package:flutter/material.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  initTime() async {
    await Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, "login_page");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFF3E56),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/fb.png",
              height: 150,
              width: 150,
            ),
            Text(
              "Firebase Login App",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
