class Profil {
  final String login;
  final String nom;
  final String prenom;
  final String adresse;
  final int codePostal;
  final String anniversaire;
  final String ville;

  Profil({
    required this.login,
    required this.nom,
    required this.prenom,
    required this.adresse,
    required this.codePostal,
    required this.anniversaire,
    required this.ville,
    required String userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': login,
      'nom': nom,
      'prenom': prenom,
      'adresse': adresse,
      'codePostal': codePostal,
      'anniversaire': anniversaire,
      'ville': ville,
    };
  }

  factory Profil.fromMap(Map<String, dynamic> map) {
    return Profil(
      userId: map['userId'] ?? '',
      login: map['email'] ?? '',
      nom: map['nom'] ?? '',
      prenom: map['prenom'] ?? '',
      adresse: map['adresse'] ?? '',
      codePostal: map['code_postal'] ?? 0,
      anniversaire: map['anniversaire'] ?? '',
      ville: map['ville'] ?? '',
    );
  }
}
