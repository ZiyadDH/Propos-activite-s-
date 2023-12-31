import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:projet/BareDeNavigation.dart';

class LoginEcran extends StatelessWidget {
  const LoginEcran({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            // Ajoutez votre icône ici
            Icon(
              Icons.favorite_border_sharp,  // Remplacez par l'icône de votre choix
              color: Color.fromARGB(255, 0, 0, 0),  // Couleur de l'icône
            ),
             Icon(
              Icons.favorite_border_sharp,  // Remplacez par l'icône de votre choix
              color: Color.fromARGB(255, 0, 0, 0),  // Couleur de l'icône
            ),
            SizedBox(width: 8), // Ajoutez de l'espace entre l'icône et le texte
            Text(
              "Fun-Activities",
              style: TextStyle(fontSize: 20),
            ),
             Icon(
              Icons.favorite_border_sharp,  // Remplacez par l'icône de votre choix
              color: Color.fromARGB(255, 0, 0, 0),  // Couleur de l'icône
            ),
             Icon(
              Icons.favorite_border_sharp,  // Remplacez par l'icône de votre choix
              color: Color.fromARGB(255, 0, 0, 0),  // Couleur de l'icône
            )
          ],
        ),
        backgroundColor: Color.fromARGB(132, 201, 137, 17),
      ),
      backgroundColor: Color.fromARGB(132, 201, 137, 17),
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return SignInScreen();
          }
          return MyNavBarButtom();
        },
      ),
    );
  }
}
