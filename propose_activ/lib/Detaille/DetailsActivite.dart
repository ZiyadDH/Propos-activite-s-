import 'package:flutter/material.dart';
import 'package:projet/model/Activite.dart';

class DetailsActivite extends StatelessWidget {
  final Activite activity;

  const DetailsActivite({Key? key, required this.activity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(activity.titre)),
        backgroundColor: Color.fromARGB(132, 201, 137, 17),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  activity.image,
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 16),
              Text(
                "Titre: ${activity.titre}",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_on, size: 24),
                  SizedBox(width: 8),
                  Text('Lieu: ${activity.lieu}', style: TextStyle(fontSize: 18)),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.attach_money, size: 24),
                  SizedBox(width: 8),
                  Text('Prix: ${activity.prix}', style: TextStyle(fontSize: 18)),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.category, size: 24),
                  SizedBox(width: 8),
                  Text('Catégorie: ${activity.categorie}', style: TextStyle(fontSize: 18)),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.people, size: 24),
                  SizedBox(width: 8),
                  Text(
                    'Nombre de participants minimum: ${activity.nbr_min}',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
