// lib/home_page.dart
import 'package:flutter/material.dart';
import 'main.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  String _formatDate(DateTime d) {
    return '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
  }

  @override
  Widget build(BuildContext context) {
    final users = UserRepository.users;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Accueil'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Déconnexion',
            onPressed: () {
              // Déconnexion -> revenir à la page de connexion
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: users.isEmpty
            ? const Center(child: Text('Aucun utilisateur inscrit'))
            : ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final u = users[index];
                  return Card(
                    child: ListTile(
                      title: Text('${u.prenom} ${u.nom}'),
                      subtitle: Text('Email: ${u.email}\nSexe: ${u.sexe}\nAdresse: ${u.adresse}'),
                      isThreeLine: true,
                      trailing: Text(_formatDate(u.dateNaissance)),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
