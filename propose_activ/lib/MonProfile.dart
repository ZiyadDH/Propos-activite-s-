import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({Key? key}) : super(key: key);

  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  late User? _user;
  TextEditingController nomController = TextEditingController();
  TextEditingController prenomController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController adressController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController anniversaireController = TextEditingController();

  bool isEditMode = false;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      setState(() {
        _user = user;
      });
      if (user != null) {
        loadUserInfo();
        emailController.text = user.email ?? '';
      }
    });
  }

  void loadUserInfo() async {
    if (_user != null) {
      String userId = _user!.uid;

      DocumentSnapshot profileSnapshot =
          await firestore.collection("Profil").doc(userId).get();

      if (profileSnapshot.exists) {
        Map<String, dynamic> data =
            profileSnapshot.data() as Map<String, dynamic>;

        setState(() {
          nomController.text = data['nom'] ?? '';
          prenomController.text = data['prenom'] ?? '';
          adressController.text = data['adresse'] ?? '';
          postalCodeController.text = data['codePostal'].toString() ?? '';
          cityController.text = data['ville'] ?? '';
          anniversaireController.text = data['anniversaire'] ?? '';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        centerTitle: true,
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  enabled: false,
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: nomController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Nom',
                          prefixIcon: Icon(Icons.person),
                        ),
                        enabled: isEditMode,
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: prenomController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Prénom',
                          prefixIcon: Icon(Icons.person),
                        ),
                        enabled: isEditMode,
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: adressController,
                          decoration: InputDecoration(
                            labelText: 'Adresse',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.location_on),
                          ),
                          enabled: isEditMode,
                          style: TextStyle(color: Colors.blue),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: postalCodeController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Code Postal',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.location_city),
                          ),
                          enabled: isEditMode,
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: cityController,
                          decoration: InputDecoration(
                            labelText: 'Ville',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.location_city),
                          ),
                          enabled: isEditMode,
                          style: TextStyle(color: Colors.blue),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: anniversaireController,
                          decoration: InputDecoration(
                            labelText: 'Anniversaire',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.calendar_today),
                          ),
                          enabled: isEditMode,
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  if (isEditMode) {
                    enregistrerProfilEtAuthentifier();
                  } else {
                    setState(() {
                      isEditMode = true;
                    });
                  }
                },
                child: Text(isEditMode ? 'Valider' : 'Modifier'),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(132, 201, 137, 17),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  void enregistrerProfilEtAuthentifier() async {
    try {
      if (_user == null) {
        return;
      }

      DocumentReference userDocRef =
          firestore.collection("Profil").doc(_user!.uid);

      DocumentSnapshot userDocSnapshot = await userDocRef.get();

      if (!userDocSnapshot.exists) {
        await userDocRef.set({
          'userId': _user!.uid,
          'email': _user!.email ?? '',
        });
      }

      await userDocRef.update({
        'nom': nomController.text,
        'prenom': prenomController.text,
        'adresse': adressController.text,
        'codePostal': int.tryParse(postalCodeController.text) ?? 0,
        'anniversaire': anniversaireController.text,
        'ville': cityController.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Profil enregistré avec succès'),
        duration: Duration(seconds: 2),
      ));
    } catch (e) {
      print('Erreur lors de la mise à jour du profil : $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Erreur lors de la mise à jour du profil'),
        duration: Duration(seconds: 2),
      ));
    }

    setState(() {
      isEditMode = false;
    });
  }
}
