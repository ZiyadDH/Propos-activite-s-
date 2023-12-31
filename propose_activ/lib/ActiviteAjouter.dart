import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AjoutActivity extends StatefulWidget {
  const AjoutActivity({Key? key}) : super(key: key);

  @override
  State<AjoutActivity> createState() => _AjoutActivityState();
}

class _AjoutActivityState extends State<AjoutActivity> {
  TextEditingController urlimage = TextEditingController();
  TextEditingController titre = TextEditingController();
  TextEditingController lieu = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController nbr_minimal = TextEditingController();
  TextEditingController categorie = TextEditingController();

  void clearFields() {
    urlimage.clear();
    titre.clear();
    lieu.clear();
    price.clear();
    nbr_minimal.clear();
    categorie.clear();
  }

  Future<void> _uploadFile() async {
    try {
      Map<String, dynamic> data = {
        "lieu": lieu.text,
        "prix": int.parse(price.text),
        "nbr_min": int.parse(nbr_minimal.text),
        "titre": titre.text,
        "image": urlimage.text,
        "categorie": categorie.text,
      };

      await FirebaseFirestore.instance.collection("Activites").add(data);

      clearFields();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Activité enregistrée avec succès'),
        duration: Duration(seconds: 2),
      ));
    } catch (e) {
      print("Erreur lors du téléchargement du fichier : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Ajouter une Activité",
            style: TextStyle(fontSize: 20),
          ),
        ),
        backgroundColor: Color.fromARGB(132, 201, 137, 17),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              const SizedBox(height: 16),
              // URL de l'image
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: urlimage,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "URL de l'image",
                    prefixIcon: Icon(Icons.image),
                  ),
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              const SizedBox(height: 16),
              // Catégorie
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: categorie,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Catégorie",
                    prefixIcon: Icon(Icons.category),
                  ),
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              const SizedBox(height: 16),
              // Titre et lieu
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: titre,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Titre de l'activité",
                          prefixIcon: Icon(Icons.title),
                        ),
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: lieu,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Lieu",
                          prefixIcon: Icon(Icons.location_on),
                        ),
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Prix et nombre minimal de participants
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: price,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Prix",
                          prefixIcon: Icon(Icons.attach_money),
                        ),
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: nbr_minimal,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Nombre minimal de participants",
                          prefixIcon: Icon(Icons.people),
                        ),
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () async {
                  try {
                    await _uploadFile();
                  } catch (e) {
                    print("Erreur lors de l'ajout de l'activité : $e");
                  }
                },
                child: const Text("Ajouter une Activité"),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(132, 201, 137, 17),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
