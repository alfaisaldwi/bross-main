// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:bross_main/core.dart';
import 'package:bross_main/pages/favorite.dart';
import 'package:bross_main/pages/histori_booking.dart';
import 'package:bross_main/pages/home.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentIndex = 0;

  final List<Widget> _children = [
    Home(),
    FavoritePage(),
    BookingHistoryPage(),
  ];

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: ColorStyle.dark,
        selectedItemColor: ColorStyle.darkPrimary,
        onTap: onTabTapped,
        currentIndex: currentIndex,
        items: [
          // ignore: prefer_const_constructors
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorit',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.compare_arrows),
            label: 'Histori',
          ),
        ],
      ),
    );
  }
}
