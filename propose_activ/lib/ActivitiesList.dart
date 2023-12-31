import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projet/model/Activite.dart';
import 'package:projet/Detaille/DetailsActivite.dart';

class ListeActivite extends StatefulWidget {
  const ListeActivite({Key? key});

  @override
  State<ListeActivite> createState() => _ListeActiviteState();
}

class _ListeActiviteState extends State<ListeActivite> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  String selectedCategory = "Toutes";
  Set<String> uniqueCategories = Set();

  @override
  void initState() {
    super.initState();
    // Initialiser la liste des catégories en dehors du FutureBuilder
    loadCategories();
  }

  void loadCategories() async {
    QuerySnapshot querySnapshot = await db.collection("Activites").get();
    uniqueCategories = {"Toutes"};
    uniqueCategories.addAll(
        querySnapshot.docs.map((doc) => doc["categorie"].toString()));
    setState(() {}); // Mettre à jour l'état pour déclencher la reconstruction du widget
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Liste des activités"),
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
      
      body: Row(
        children: [
          Expanded(
            flex: 1, // Flexibilité de 1 pour les catégories
            child: Container(
              color: Color.fromARGB(255, 255, 255, 255),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.category,
                          size: 24,
                          color: Color.fromARGB(132, 201, 137, 17),
                        ),
                        SizedBox(width: 8),
                        Text(
                          "Liste des catégories : ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: uniqueCategories.map((category) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4.0),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  selectedCategory = category;
                                });
                              },
                              child: Chip(
                                label: Text(category),
                                backgroundColor: selectedCategory == category
                                    ? Color.fromARGB(132, 201, 137, 17)
                                    : Colors.white,
                                labelStyle: TextStyle(
                                  color: selectedCategory == category
                                      ? Color.fromARGB(255, 26, 25, 25)
                                      : Colors.black,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                    color: selectedCategory == category
                                        ? const Color.fromARGB(255, 0, 0, 0)
                                        : Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2, // Flexibilité de 2 pour les activités
            child: StreamBuilder<QuerySnapshot>(
              stream: selectedCategory == "Toutes"
                  ? db.collection("Activites").snapshots()
                  : db
                      .collection("Activites")
                      .where("categorie", isEqualTo: selectedCategory)
                      .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text('Aucune activité trouvée.'),
                  );
                }

                List<Activite> activities = snapshot.data!.docs
                    .map((doc) => Activite.FromFirestore(doc))
                    .toList();

                return ListView.builder(
                  itemCount: activities.length,
                  itemBuilder: (context, index) {
                    Activite activity = activities[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailsActivite(activity: activity),
                          ),
                        );
                      },
                      child: Card(
                        margin: const EdgeInsets.all(8),
                        child: ListTile(
                          leading: Icon(
                            Icons.task,
                            size: 50,
                            color: const Color.fromARGB(132, 201, 137, 17),
                          ),
                          title: Text(
                            activity.titre,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.blue,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Location: ${activity.lieu}'),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
