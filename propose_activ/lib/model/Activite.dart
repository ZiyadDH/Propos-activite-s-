import 'package:cloud_firestore/cloud_firestore.dart';

class Activite  {
  String id;
  String categorie;
  String image;
  String lieu;
  int nbr_min;
  double prix;
  String titre;

  Activite (
      {required this.id,
      required this.categorie,
      required this.image,
      required this.lieu,
      required this.nbr_min,
      required this.prix,
      required this.titre});

  factory Activite.FromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Activite(
        id: doc.id,
        categorie: data['categorie'] ?? '',
        image: data['image'] ?? '',
        lieu: data['lieu'] ?? '',
        nbr_min: (data?['nbr_min'] ?? 0).toInt(),
        prix: (data?['prix'] ?? 0.0).toDouble(),
        titre: data['titre'] ?? '');
  }
}
