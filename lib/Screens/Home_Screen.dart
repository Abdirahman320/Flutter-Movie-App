import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:onstream/Screens/Movie_Screen.dart';
import 'package:onstream/Screens/Settings.dart';
import 'package:onstream/Screens/Top_rated.dart';
import 'package:onstream/Screens/Tv_Series_Screen.dart';

import 'package:onstream/Widgets/HomePage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<HomeScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List pages = [
      HomePage(),
      const MovieScreen(),
      const TvSeriesScreen(),
      const Settings()
    ];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Image.asset(
              "assets/logo.png",
              width: 30,
              height: 50,
            ),
            const SizedBox(
              width: 6,
            ),
            const Text(
              "OnStream",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const TopRated(),
              ));
            },
            child: const Icon(
              Icons.search,
              size: 32,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: CircleAvatar(
              radius: 15,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        selectedItemColor: Colors.yellow,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.play_circle_outline), label: "Movies"),
          BottomNavigationBarItem(
              icon: Icon(Icons.folder_outlined), label: "Tv Series"),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: "More "),
        ],
      ),
    );
  }
}
