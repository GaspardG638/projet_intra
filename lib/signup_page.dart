// lib/signup_page.dart
import 'package:flutter/material.dart';
import 'main.dart';


class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _adresseController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _sexe = 'Masculin';
  DateTime? _selectedDate;

  @override
  void dispose() {
    // Toujours disposer les controllers
    _nomController.dispose();
    _prenomController.dispose();
    _adresseController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _pickDate(BuildContext context) async {
    final now = DateTime.now();
    final initial = _selectedDate ?? DateTime(now.year - 18);
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(1900),
      lastDate: now,
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  void _submit() {
    // Valide les champs du Form
    if (_formKey.currentState!.validate()) {
      if (_selectedDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Veuillez choisir une date de naissance')),
        );
        return;
      }

      // Créer un utilisateur et l'ajouter à la liste en mémoire
      final user = User(
        nom: _nomController.text.trim(),
        prenom: _prenomController.text.trim(),
        sexe: _sexe,
        adresse: _adresseController.text.trim(),
        dateNaissance: _selectedDate!,
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      UserRepository.users.add(user);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Inscription réussie — veuillez vous connecter')),
      );

      // Redirection vers la page de connexion (remplace la route actuelle)
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  String _formatDate(DateTime d) {
    return '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inscription')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Nom
              TextFormField(
                controller: _nomController,
                decoration: const InputDecoration(labelText: 'Nom'),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Nom requis' : null,
              ),
              const SizedBox(height: 12),

              // Prénom
              TextFormField(
                controller: _prenomController,
                decoration: const InputDecoration(labelText: 'Prénom'),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Prénom requis' : null,
              ),
              const SizedBox(height: 12),

              // Sexe dropdown
              DropdownButtonFormField<String>(
                value: _sexe,
                decoration: const InputDecoration(labelText: 'Sexe'),
                items: const [
                  DropdownMenuItem(value: 'Masculin', child: Text('Masculin')),
                  DropdownMenuItem(value: 'Féminin', child: Text('Féminin')),
                  DropdownMenuItem(value: 'Autre', child: Text('Autre')),
                ],
                onChanged: (v) {
                  if (v != null) setState(() => _sexe = v);
                },
              ),
              const SizedBox(height: 12),

              // Adresse
              TextFormField(
                controller: _adresseController,
                decoration: const InputDecoration(labelText: 'Adresse'),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Adresse requise' : null,
              ),
              const SizedBox(height: 12),

              // Date de naissance (InkWell pour ouvrir le picker)
              InkWell(
                onTap: () => _pickDate(context),
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Date de naissance'),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _selectedDate == null ? 'Choisir une date' : _formatDate(_selectedDate!),
                      ),
                      const Icon(Icons.calendar_today),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),

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
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Mot de passe requis';
                  if (v.length < 6) return 'Le mot de passe doit contenir au moins 6 caractères';
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Bouton inscription
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submit,
                  child: const Text("S'inscrire"),
                ),
              ),

              // Lien vers connexion
              TextButton(
                onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
                child: const Text('Déjà inscrit ? Se connecter'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
