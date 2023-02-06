import 'package:firebase_auth/firebase_auth.dart';
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
  bool iscurrentUser = false;
  User? currentUser;
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
    currentUser = FirebaseAuth.instance.currentUser!;
    List<DetailUserModel> tempList = [];
    List<int> tempListPoint = [];

    await DetailUserService.ReadAll().then((value) {
      tempList = value;
    });

    for (var item in tempList) {
      print(item.toJson());
      await AchievenmentService.ReadWithUserId(item.userId).then((value) {
        AchievementModel achievementModel = value[0];
        int totalPoint = achievementModel.toltalSpeakingPoint +
            achievementModel.toltalVocabularyPoint;
        tempListPoint.add(totalPoint);
      });
    }

    // sort
    for (int i = 0; i < tempListPoint.length - 1; i++) {
      for (int j = i + 1; j <= tempListPoint.length - 1; j++) {
        if (tempListPoint[i] < tempListPoint[j]) {
          var temp = tempListPoint[i];
          tempListPoint[i] = tempListPoint[j];
          tempListPoint[j] = temp;

          var temp2 = tempList[i];
          tempList[i] = tempList[j];
          tempList[j] = temp2;
        }
      }
    }
    print(tempListPoint);

    setState(() {
      list = tempList;
      list_point = tempListPoint;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget pageBody = Container(
      decoration: const BoxDecoration(color: Color(0xffDBF9F8)),
      child: Column(children: [
        const SizedBox(
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
                  const SizedBox(
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
                    style: const TextStyle(fontSize: 13),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 60,
                    height: 65,
                    color: Colors.yellow,
                    child: const Center(
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

            const SizedBox(
              width: 24,
            ),
            Visibility(
              visible: (list.isNotEmpty) ? true : false,
              child: Column(
                children: [
                  CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                        list.isNotEmpty
                            ? (list[0].avatarUrl == ''
                                ? 'https://i0.wp.com/post.medicalnewstoday.com/wp-content/uploads/sites/3/2020/03/GettyImages-1092658864_hero-1024x575.jpg?w=1155&h=1528'
                                : list[0].avatarUrl)
                            : 'https://i0.wp.com/post.medicalnewstoday.com/wp-content/uploads/sites/3/2020/03/GettyImages-1092658864_hero-1024x575.jpg?w=1155&h=1528',
                      )),
                  Text(
                    (list.isNotEmpty
                        ? '${list[0].gmail.substring(0, 6)}...'
                        : '???'),
                    style: const TextStyle(fontSize: 13),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: 64,
                    height: 90,
                    color: Colors.yellow,
                    child: const Center(
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
            const SizedBox(
              width: 24,
            ),
            Visibility(
              visible: (list.length >= 3) ? true : false,
              child: Column(
                children: [
                  const SizedBox(
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
                    style: const TextStyle(fontSize: 13),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 60,
                    height: 36,
                    color: Colors.yellow,
                    child: const Center(
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
        const SizedBox(
          height: 24,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: CustomCard(
            elevation: 15,
            height: 440,
            borderRadius: 15,
            color: Colors.white,
            child: (list.isEmpty)
                ? const Center(
                    child: Text('Danh sách trống'),
                  )
                : ListView(children: [
                    for (int i = 0; i < list.length; i++) ...{
                      ListTile(
                        title: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 15.0),
                              child: Text(
                                (i + 1).toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 15.0),
                              child: CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage((list[i]
                                            .avatarUrl ==
                                        "")
                                    ? 'https://i0.wp.com/post.medicalnewstoday.com/wp-content/uploads/sites/3/2020/03/GettyImages-1092658864_hero-1024x575.jpg?w=1155&h=1528'
                                    : list[i].avatarUrl),
                              ),
                            ),
                            currentUser?.uid.toString() == list[i].userId
                                ? Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '${list[i].gmail.substring(0, 6)}... (You)',
                                      style: const TextStyle(
                                          color: Colors.blue,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ))
                                : Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '${list[i].gmail.substring(0, 6)}...',
                                    ),
                                  )
                          ],
                        ),
                        trailing: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xffDBF9F8),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('${list_point[i]} points')),
                        ),
                      ),
                      Container(
                        color: Colors.grey.shade300,
                        height: 1,
                      ),
                    }
                  ]),
          ),
        ),
      ]),
    );
    return (isLoading)
        ? const Center(child: CircularProgressIndicator())
        // : FutureBuilder(
        //     future: init(),
        //     builder: (snap, context) {
        //       return pageBody;
        //     },
        //   );
        : SingleChildScrollView(child: pageBody);
  }
}
