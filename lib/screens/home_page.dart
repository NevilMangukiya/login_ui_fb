import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../helpers/firebase_auth_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.power_settings_new),
            onPressed: () async {
              await FirebaseAuthHelper.firebaseAuthHelper.signOut();

              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Log Out Successful")));

              Navigator.of(context)
                  .pushNamedAndRemoveUntil('login_page', (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
