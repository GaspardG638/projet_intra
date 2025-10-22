// lib/login_page.dart
import 'package:flutter/material.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Identifiants autorisés selon la consigne (compte admin fixe)
  final String _allowedEmail = 'admin@gmail.com';
  final String _allowedPassword = 'admin1234#';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      final pass = _passwordController.text;

      if (email == _allowedEmail && pass == _allowedPassword) {
        // Connexion réussie -> page d'accueil
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        // Identifiants incorrects
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Identifiants incorrects')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Connexion')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // Email
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return 'Email requis';
                      final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
                      if (!emailRegex.hasMatch(v)) return 'Email invalide';
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),

                  // Mot de passe
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: 'Mot de passe'),
                    obscureText: true,
                    validator: (v) => (v == null || v.isEmpty) ? 'Mot de passe requis' : null,
                  ),
                  const SizedBox(height: 20),

                  // Bouton connexion
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _login,
                      child: const Text('Se connecter'),
                    ),
                  ),

                  // Lien vers inscription
                  TextButton(
                    onPressed: () => Navigator.pushReplacementNamed(context, '/signup'),
                    child: const Text('Créer un compte'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
