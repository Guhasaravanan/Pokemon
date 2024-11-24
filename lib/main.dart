import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pokemon/Screen/LoginScreen/authPage.dart';
import 'package:pokemon/Services/pokemon_Provider.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PokemonProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const AuthPage(),
      ),
    );
  }
}
