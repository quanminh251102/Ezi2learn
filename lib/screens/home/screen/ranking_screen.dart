import 'dart:math';

import 'package:firebase_admin/firebase_admin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_cards/flutter_custom_cards.dart';
import 'package:rive_animation/screens/home/models/achievement_model.dart';
import 'package:rive_animation/screens/home/models/detail_user_model.dart';
import 'package:rive_animation/screens/home/service/achievenment_service.dart';
import 'package:rive_animation/screens/home/service/detail_user_service.dart';

class RankingScreen extends StatefulWidget {
  const RankingScreen({super.key});

  @override
  State<RankingScreen> createState() => _RankingScreenState();
}

class _RankingScreenState extends State<RankingScreen> {
  bool isLoading = false;
  List<DetailUserModel> list = [];
  List<int> list_point = [];
  List<DetailUserModel> top_three = [];
  List<int> top_three_point = [];

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
    List<DetailUserModel> temp_list = [];
    List<int> temp_list_point = [];

    await DetailUserService.ReadAll().then((value) {
      temp_list = value;
    });

    for (var item in temp_list) {
      print(item.toJson());
      await AchievenmentService.ReadWithUserId(item.userId).then((value) {
        AchievementModel achievementModel = value[0];
        int totalPoint = achievementModel.toltalSpeakingPoint +
            achievementModel.toltalVocabularyPoint;
        temp_list_point.add(totalPoint);
      });
    }

    // sort
    for (int i = 0; i < temp_list_point.length - 1; i++) {
      for (int j = i + 1; j <= temp_list_point.length - 1; j++) {
        if (temp_list_point[i] < temp_list_point[j]) {
          var temp = temp_list_point[i];
          temp_list_point[i] = temp_list_point[j];
          temp_list_point[j] = temp;

          var temp2 = temp_list[i];
          temp_list[i] = temp_list[j];
          temp_list[j] = temp2;
        }
      }
    }
    print(temp_list_point);

    setState(() {
      list = temp_list;
      list_point = temp_list_point;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget pageBody = Container(
      //color: Color.fromARGB(255, 245, 231, 111),
      //padding: EdgeInsets.all(24),
      child: Column(children: [
        SizedBox(
          height: 24,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // CircleAvatar(
            //               radius: 140,
            //               backgroundImage: NetworkImage(
            //                 (detailUserModels_normal?[0].avatarUrl == '')
            //                     ? 'https://i0.wp.com/post.medicalnewstoday.com/wp-content/uploads/sites/3/2020/03/GettyImages-1092658864_hero-1024x575.jpg?w=1155&h=1528'
            //                     : detailUserModels_normal?[0].avatarUrl ?? '',
            //               )),
            Visibility(
              visible: (list.length >= 2) ? true : false,
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                        list.length >= 2
                            ? (list[1].avatarUrl == ''
                                ? 'https://i0.wp.com/post.medicalnewstoday.com/wp-content/uploads/sites/3/2020/03/GettyImages-1092658864_hero-1024x575.jpg?w=1155&h=1528'
                                : list[1].avatarUrl)
                            : 'https://i0.wp.com/post.medicalnewstoday.com/wp-content/uploads/sites/3/2020/03/GettyImages-1092658864_hero-1024x575.jpg?w=1155&h=1528',
                      )),
                  Text(
                    (list.length >= 2
                        ? '${list[1].gmail.substring(0, 6)}...'
                        : '???'),
                    style: TextStyle(fontSize: 13),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 60,
                    height: 65,
                    color: Colors.yellow,
                    child: Center(
                        child: Text(
                      '2',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    )),
                  ),
                ],
              ),
            ),

            SizedBox(
              width: 24,
            ),
            Visibility(
              visible: (list.length >= 1) ? true : false,
              child: Column(
                children: [
                  CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                        list.length >= 1
                            ? (list[0].avatarUrl == ''
                                ? 'https://i0.wp.com/post.medicalnewstoday.com/wp-content/uploads/sites/3/2020/03/GettyImages-1092658864_hero-1024x575.jpg?w=1155&h=1528'
                                : list[0].avatarUrl)
                            : 'https://i0.wp.com/post.medicalnewstoday.com/wp-content/uploads/sites/3/2020/03/GettyImages-1092658864_hero-1024x575.jpg?w=1155&h=1528',
                      )),
                  Text(
                    (list.length >= 1
                        ? '${list[0].gmail.substring(0, 6)}...'
                        : '???'),
                    style: TextStyle(fontSize: 13),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: 64,
                    height: 90,
                    color: Colors.yellow,
                    child: Center(
                        child: Text(
                      '1',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w900),
                    )),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 24,
            ),
            Visibility(
              visible: (list.length >= 3) ? true : false,
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                        list.length >= 3
                            ? (list[2].avatarUrl == ''
                                ? 'https://i0.wp.com/post.medicalnewstoday.com/wp-content/uploads/sites/3/2020/03/GettyImages-1092658864_hero-1024x575.jpg?w=1155&h=1528'
                                : list[2].avatarUrl)
                            : 'https://i0.wp.com/post.medicalnewstoday.com/wp-content/uploads/sites/3/2020/03/GettyImages-1092658864_hero-1024x575.jpg?w=1155&h=1528',
                      )),
                  Text(
                    (list.length >= 3
                        ? '${list[2].gmail.substring(0, 6)}...'
                        : '???'),
                    style: TextStyle(fontSize: 13),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 60,
                    height: 36,
                    color: Colors.yellow,
                    child: Center(
                        child: Text(
                      '3',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    )),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 24,
        ),
        CustomCard(
          height: 440,
          borderRadius: 12,
          color: Colors.white,
          childPadding: 4,
          child: (list.length == 0)
              ? Center(
                  child: Text('Danh sách trống'),
                )
              : ListView(children: [
                  for (int i = 0; i < list.length; i++) ...{
                    ListTile(
                      leading: Text((i + 1).toString()),
                      title: Align(
                        alignment: Alignment.centerLeft,
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage((list[i].avatarUrl ==
                                  "")
                              ? 'https://i0.wp.com/post.medicalnewstoday.com/wp-content/uploads/sites/3/2020/03/GettyImages-1092658864_hero-1024x575.jpg?w=1155&h=1528'
                              : list[i].avatarUrl),
                        ),
                      ),
                      subtitle: Text(list[i].gmail),
                      trailing: Text('${list_point[i]} points'),
                    ),
                    Container(
                      color: Colors.grey.shade300,
                      height: 1,
                    ),
                  }
                ]),
        ),
      ]),
    );
    return (isLoading)
        ? Center(child: CircularProgressIndicator())
        // : FutureBuilder(
        //     future: init(),
        //     builder: (snap, context) {
        //       return pageBody;
        //     },
        //   );
        : pageBody;
  }
}
