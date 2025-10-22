// lib/user_repository.dart
// Modèle utilisateur + repository en mémoire
class User {
  final String nom;
  final String prenom;
  final String sexe;
  final String adresse;
  final DateTime dateNaissance;
  final String email;
  final String password; // stocké en clair ici pour l'exemple pédagogique

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
  // Liste en mémoire des utilisateurs enregistrés
  static final List<User> users = [];
}
