import 'package:classico/view/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:classico/constants/dimensions.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'maps_hospital.dart';
import 'notes/notes_view.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(
          () => _currentIndex = i,
        ),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        selectedColorOpacity: 0.2,
        margin: const EdgeInsets.symmetric(
            horizontal: kMediumPadding, vertical: kDefaultPadding),
        items: [
          SalomonBottomBarItem(
            icon: const Icon(
              FontAwesomeIcons.notesMedical,
              size: kDefaultPadding,
            ),
            title: const Text("Medical Record"),
          ),
          SalomonBottomBarItem(
            icon: const Icon(
              FontAwesomeIcons.map,
              size: kDefaultPadding,
            ),
            title: const Text("Maps"),
          ),
          SalomonBottomBarItem(
            icon: const Icon(
              FontAwesomeIcons.solidUser,
              size: kDefaultPadding,
            ),
            title: const Text("Profile"),
          ),
        ],
      ),
      body: IndexedStack(index: _currentIndex, children: [
        const NotesView(),
        const MapBox_hospital(),
        const ProfileView(),
      ]),
    );
  }
}
