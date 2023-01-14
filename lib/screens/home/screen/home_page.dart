import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:rive_animation/screens/auth/service/auth_service.dart';
import 'package:rive_animation/screens/home/models/achievement_model.dart';
import 'package:rive_animation/screens/home/models/detail_user_model.dart';
import 'package:rive_animation/screens/home/screen/misson_page.dart';
import 'package:rive_animation/screens/home/screen/profile_page.dart';
import 'package:rive_animation/screens/home/service/achievenment_service.dart';
import 'package:rive_animation/screens/home/service/detail_user_service.dart';
import '../widget/nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  Future<List<DetailUserModel>>? detailUserModels;
  Future<List<AchievementModel>>? achievementModels;
  List<DetailUserModel>? detailUserModels_for_use;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  Future<void> init() async {
    detailUserModels = DetailUserService.Read();
    achievementModels = AchievenmentService.Read();
    detailUserModels_for_use = await DetailUserService.Read();
  }

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
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(),
                  ),
                );
              },
              child: FutureBuilder(
                  future: detailUserModels,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Object>> snapshot) {
                    if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      return CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(
                            (detailUserModels_for_use?[0].avatarUrl == '')
                                ? 'https://i0.wp.com/post.medicalnewstoday.com/wp-content/uploads/sites/3/2020/03/GettyImages-1092658864_hero-1024x575.jpg?w=1155&h=1528'
                                : detailUserModels_for_use?[0].avatarUrl ?? '',
                          ));
                    } else {
                      return SizedBox(
                        height: 400,
                        child: const Center(child: CircularProgressIndicator()),
                      );
                    }
                  }),
              // child: CircleAvatar(
              //     radius: 20,
              //     backgroundImage: NetworkImage(
              //       (detailUserModels_for_use?[0].avatarUrl == '')
              //           ? 'https://i0.wp.com/post.medicalnewstoday.com/wp-content/uploads/sites/3/2020/03/GettyImages-1092658864_hero-1024x575.jpg?w=1155&h=1528'
              //           : detailUserModels_for_use?[0].avatarUrl ?? '',
              //     )),
            ),
          ),
        ]);

    Widget pageBody = (index == 0) ? MissonPage() : Text('text');

    return Scaffold(
      drawer: NavBar(),
      appBar: _appBar,
      backgroundColor: Colors.white,
      bottomNavigationBar: _bottomNavigationBar,
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: Future.wait([
              detailUserModels!,
              achievementModels!,
            ]),
            builder:
                (BuildContext context, AsyncSnapshot<List<Object>> snapshot) {
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return pageBody;
              } else {
                return SizedBox(
                  height: 400,
                  child: const Center(child: CircularProgressIndicator()),
                );
              }
            }),
      ),
    );
  }
}
