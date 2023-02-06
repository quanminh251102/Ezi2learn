import 'package:flutter/material.dart';

import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:rive_animation/screens/home/models/achievement_model.dart';
import 'package:rive_animation/screens/home/models/detail_user_model.dart';
import 'package:rive_animation/screens/home/screen/misson_page.dart';
import 'package:rive_animation/screens/home/screen/profile_page.dart';
import 'package:rive_animation/screens/home/screen/ranking_screen.dart';
import 'package:rive_animation/screens/home/service/achievenment_service.dart';
import 'package:rive_animation/screens/home/service/detail_user_service.dart';
import 'package:rive_animation/screens/saved_words/screen/saved_words_screen.dart';
import '../widget/nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  List<DetailUserModel> detailUserModels = [];
  List<AchievementModel> achievementModels = [];
  //List<DetailUserModel> detailUserModels_for_use = [];
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  Future<void> init() async {
    setState(() {
      isLoading = true;
    });
    await DetailUserService.Read().then((value) {
      setState(() {
        detailUserModels = value;
      });
    });
    await AchievenmentService.Read().then((value) {
      setState(() {
        achievementModels = value;
      });
    });
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget bottomNavigationBar = Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(30), topLeft: Radius.circular(30)),
        boxShadow: [
          BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: SafeArea(
          child: GNav(
              tabMargin: const EdgeInsetsDirectional.all(8),
              backgroundColor: Colors.white,
              color: Colors.black,
              activeColor: Colors.black,
              tabBackgroundColor: Colors.yellow.shade200,
              gap: 8,
              padding: const EdgeInsets.all(15),
              onTabChange: ((value) {
                print(value);
                setState(() {
                  index = value;
                });
              }),
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.save_alt_outlined,
                  text: 'Saved Words',
                ),
                GButton(
                  icon: Icons.list_alt_rounded,
                  text: 'Ranking',
                ),
                GButton(
                  icon: Icons.supervised_user_circle,
                  text: 'Profile',
                )
              ]),
        ),
      ),
    );

    AppBar appBar = AppBar(
        toolbarHeight: MediaQuery.of(context).size.height / 12,
        iconTheme: const IconThemeData(
          //size: 40, //change size on your need
          color: Colors.black, //change color on your need
        ),
        centerTitle: true,
        title: const Text(
          'Home',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Colors.yellow.shade200,
        elevation: 3,
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: InkWell(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const ProfileScreen(),
                //   ),
                // );
              },
              // child: FutureBuilder(
              //     future: detailUserModels,
              //     builder: (BuildContext context,
              //         AsyncSnapshot<List<Object>> snapshot) {
              //       if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              //         return CircleAvatar(
              //             radius: 20,
              //             backgroundImage: NetworkImage(
              //               (detailUserModels_for_use?[0].avatarUrl == '')
              //                   ? 'https://i0.wp.com/post.medicalnewstoday.com/wp-content/uploads/sites/3/2020/03/GettyImages-1092658864_hero-1024x575.jpg?w=1155&h=1528'
              //                   : detailUserModels_for_use?[0].avatarUrl ?? '',
              //             ));
              //       } else {
              //         return SizedBox(
              //           height: 400,
              //           child: const Center(child: CircularProgressIndicator()),
              //         );
              //       }
              //     }),
              child: detailUserModels.isNotEmpty
                  ? CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                        (detailUserModels[0].avatarUrl == '')
                            ? 'https://i0.wp.com/post.medicalnewstoday.com/wp-content/uploads/sites/3/2020/03/GettyImages-1092658864_hero-1024x575.jpg?w=1155&h=1528'
                            : detailUserModels[0].avatarUrl ?? '',
                      ))
                  : const CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                          'https://i0.wp.com/post.medicalnewstoday.com/wp-content/uploads/sites/3/2020/03/GettyImages-1092658864_hero-1024x575.jpg?w=1155&h=1528')),
            ),
          ),
        ]);

    Widget pageBody = (index == 0)
        ? const SingleChildScrollView(child: MissonPage())
        : (index == 1)
            ? const SavedWordsScreen()
            : (index == 2)
                ? const RankingScreen()
                : const ProfileScreen();

    bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom != 0.0;

    return Scaffold(
      //resizeToAvoidBottomInset: false,
      drawer: const NavBar(),
      appBar: appBar,
      backgroundColor: Colors.white,
      bottomNavigationBar: isKeyboardOpen ? null : bottomNavigationBar,
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(child: pageBody),
    );
  }
}
