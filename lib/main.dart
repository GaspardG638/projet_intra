// lib/main.dart
import 'package:flutter/material.dart';
import 'signup_page.dart';
import 'login_page.dart';
import 'home_page.dart';

// ----- Modèle utilisateur + stockage mémoire -----
class User {
  final String nom;
  final String prenom;
  final String sexe;
  final String adresse;
  final DateTime dateNaissance;
  final String email;
  final String password;

  User({
    required this.nom,
    required this.prenom,
    required this.sexe,
    required this.adresse,
    required this.dateNaissance,
    required this.email,
    required this.password,
  });
}

class UserRepository {
  static final List<User> users = [];
}
// --------------------------------------------------

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Auth App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // On démarre sur la page d'inscription comme demandé
      initialRoute: '/signup',
      routes: {
        '/signup': (context) => const SignupPage(),
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}
