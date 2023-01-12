import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:rive_animation/screens/home/misson_page.dart';
import './widget/nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    Widget _bottomNavigationBar = Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 0.8, color: Colors.grey.shade200),
        ),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
        child: GNav(
            backgroundColor: Colors.white,
            color: Colors.black,
            activeColor: Colors.black,
            tabBackgroundColor: Colors.yellow.shade200,
            gap: 8,
            padding: EdgeInsets.all(16),
            onTabChange: ((value) {
              print(value);
              setState(() {
                index = value;
              });
            }),
            tabs: [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.hearing_disabled,
                text: 'Likes',
              ),
              GButton(
                icon: Icons.search,
                text: 'Search',
              ),
              GButton(
                icon: Icons.supervised_user_circle,
                text: 'Profile',
              )
            ]),
      ),
    );

    AppBar _appBar = AppBar(
      iconTheme: const IconThemeData(
        //size: 40, //change size on your need
        color: Colors.black, //change color on your need
      ),
      centerTitle: true,
      title: Text(
        'Home',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w700,
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0.4,
      actions: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
          child: CircleAvatar(
            radius: 20.0,
            backgroundImage: NetworkImage(
                "https://cdn-icons-png.flaticon.com/512/5526/5526465.png"),
            backgroundColor: Colors.yellow,
          ),
        ),
      ],
    );

    return Scaffold(
      drawer: NavBar(),
      appBar: _appBar,
      backgroundColor: Colors.white,
      bottomNavigationBar: _bottomNavigationBar,
      body: (index == 0) ? MissonPage() : Text('text'),
    );
  }
}
