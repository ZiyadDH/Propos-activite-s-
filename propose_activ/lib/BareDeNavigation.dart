import 'package:flutter/material.dart';
import 'package:projet/ActiviteAjouter.dart';
import 'package:projet/ActivitiesList.dart';
import 'package:projet/MonProfile.dart';

class MyNavBarButtom extends StatefulWidget {
  const MyNavBarButtom({Key? key}) : super(key: key);

  @override
  State<MyNavBarButtom> createState() => _MyNavBarButtomState();
}

class _MyNavBarButtomState extends State<MyNavBarButtom> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const ListeActivite(),
    const AjoutActivity(),
    const ProfileWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          
          BottomNavigationBarItem(
            icon: Icon(
              Icons.explore,
              size: 30,
              color: _currentIndex == 0
                  ? const Color.fromARGB(132, 201, 137, 17)
                  : Colors.grey,
            ),
            label: "Explorer",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_circle,
              color: _currentIndex == 1
                  ? const Color.fromARGB(132, 201, 137, 17)
                  : Colors.grey,
              size: 30,
            ),
            label: "Ajouter des Activites",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
              color: _currentIndex == 2
                  ? const Color.fromARGB(132, 201, 137, 17)
                  : Colors.grey,
              size: 30,
            ),
            label: "Mon Compte",
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: _pages[_currentIndex],
    );
  }
}
