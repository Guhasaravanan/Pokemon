import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../HomeScreen/landingScreen.dart';
import 'loginScreen.dart'; // Ensure you have a LandingScreen or appropriate widget

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // Check the connection state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            return const LandingScreen();
          }

          return LoginScreen();
        },
      ),
    );
  }
}
