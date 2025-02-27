import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:onstream/Screens/Home_Screen.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    double widthSize = MediaQuery.of(context).size.width;
    double heightSize = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            width: widthSize,
            height: heightSize,
            "assets/background.jpg",
            fit: BoxFit.cover,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.5), Colors.black],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
            ),
          ),
          Positioned(
            top: widthSize / 0.85,
            child: const Padding(
              padding: EdgeInsets.only(left: 25),
              child: Row(
                children: [
                  Icon(
                    Icons.energy_savings_leaf,
                    color: Colors.green,
                    size: 45,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "OnStream",
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 25),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: widthSize / 0.75,
            child: const Padding(
              padding: EdgeInsets.only(left: 30),
              child: Text(
                "Watch free movies and Tv shows online in HD on \nany device",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
              ),
            ),
          ),
          Positioned(
            top: widthSize / 0.66,
            child: Padding(
              padding: const EdgeInsets.only(left: 30),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 203, 245, 53),
                  foregroundColor: Colors.black,
                  fixedSize: Size(widthSize / 1.1, heightSize / 17),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {},
                child: const Row(
                  children: [
                    Icon(Icons.mail_outlined),
                    SizedBox(
                      width: 40,
                    ),
                    Text(
                      "Continue with email ",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: widthSize / 0.60,
            child: Padding(
              padding: const EdgeInsets.only(left: 30),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade700,
                  foregroundColor: Colors.black,
                  fixedSize: Size(widthSize / 1.1, heightSize / 17),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {},
                child: Row(
                  children: [
                    Image.asset(
                      "assets/google.png",
                      width: 25,
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    const Text(
                      "Continue with Google ",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: widthSize / 0.55,
            child: Padding(
              padding: const EdgeInsets.only(left: 30),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  side: BorderSide(color: Colors.white38),
                  backgroundColor: Colors.black,
                  fixedSize: Size(widthSize / 1.1, heightSize / 17),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return const HomeScreen();
                    },
                  ));
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        "Skip >",
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.w400),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
