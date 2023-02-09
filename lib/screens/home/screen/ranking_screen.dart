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
    currentUser = FirebaseAuth.instance.currentUser;
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
      //decoration: const BoxDecoration(color: Color(0xffDBF9F8)),
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(children: [
        // const SizedBox(
        //   height: 24,
        // ),
        Stack(
          children: [
            SizedBox(
              height: 350,
              width: MediaQuery.of(context).size.width * 0.7,
            ),
            Positioned(
              top: 150,
              left: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/leaderboard.png',
                  fit: BoxFit.cover,
                  width: 270,
                ),
              ),
            ),
            Positioned(
              top: 10,
              left: 15,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        height: 30,
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
                      const SizedBox(
                        height: 8,
                      ),
                      Material(
                        borderRadius: BorderRadius.circular(15),
                        elevation: 4,
                        color: Colors.transparent,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.lightBlue.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                (list.length >= 2
                                    ? '${list[1].gmail.substring(0, 6)}...'
                                    : '???'),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )),
                        ),
                      ),
                      // Text(
                      //   (list.length >= 2
                      //       ? '${list[1].gmail.substring(0, 6)}...'
                      //       : '???'),
                      //   style: const TextStyle(fontSize: 13),
                      // ),
                    ],
                  ),
                  const SizedBox(
                    width: 13,
                  ),
                  Column(children: [
                    const SizedBox(
                      height: 5,
                    ),
                    CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                          list.isNotEmpty
                              ? (list[0].avatarUrl == ''
                                  ? 'https://i0.wp.com/post.medicalnewstoday.com/wp-content/uploads/sites/3/2020/03/GettyImages-1092658864_hero-1024x575.jpg?w=1155&h=1528'
                                  : list[0].avatarUrl)
                              : 'https://i0.wp.com/post.medicalnewstoday.com/wp-content/uploads/sites/3/2020/03/GettyImages-1092658864_hero-1024x575.jpg?w=1155&h=1528',
                        )),
                    const SizedBox(
                      height: 8,
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(15),
                      elevation: 4,
                      color: Colors.transparent,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.yellow.shade600,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              (list.isNotEmpty
                                  ? '${list[0].gmail.substring(0, 6)}...'
                                  : '???'),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )),
                      ),
                    ),
                    // Text(
                    //   (list.isNotEmpty
                    //       ? '${list[0].gmail.substring(0, 6)}...'
                    //       : '???'),
                    //   style: const TextStyle(fontSize: 13),
                    // ),
                  ]),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(children: [
                    const SizedBox(
                      height: 55,
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
                    const SizedBox(
                      height: 8,
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(15),
                      elevation: 4,
                      color: Colors.transparent,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.purple.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              (list.length >= 3
                                  ? '${list[2].gmail.substring(0, 6)}...'
                                  : '???'),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )),
                      ),
                    ),
                    // Text(
                    //   (list.length >= 3
                    //       ? '${list[2].gmail.substring(0, 6)}...'
                    //       : '???'),
                    //   style: const TextStyle(fontSize: 13),
                    // ),
                  ]),
                ],
              ),
            ),
            Positioned(
              top: 10,
              left: 117,
              child: SizedBox(
                height: 30,
                width: 30,
                child: Image.asset(
                  'assets/gif/crown.gif',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
          child: (list.isEmpty)
              ? const Center(
                  child: Text('Danh sách trống'),
                )
              : Expanded(
                  child: ListView(
                      scrollDirection: Axis.vertical,
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        for (int i = 0; i < list.length; i++) ...{
                          CustomCard(
                            color: (i == 0)
                                ? Colors.red
                                : (i == 1)
                                    ? Colors.yellow
                                    : (i == 2)
                                        ? Colors.blue
                                        : Colors.white,
                            borderRadius: 15,
                            child: ListTile(
                              title: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 15.0),
                                    child: Text(
                                      (i + 1).toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color:  (i == 0)
                                ? Colors.red.shade100
                                : (i == 1)
                                    ? Colors.yellow.shade100
                                    : (i == 2)
                                        ? Colors.blue.shade100
                                        : Colors.black,
                                          ),
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
                                              color: Colors.black,
                                              fontSize: 18,
                                            ),
                                          ))
                                      : Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            '${list[i].gmail.substring(0, 6)}...',
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                            ),
                                          ),
                                        )
                                ],
                              ),
                              trailing: Container(
                                decoration: BoxDecoration(
                                  color:  (i == 0)
                                ? Colors.red.shade100
                                : (i == 1)
                                    ? Colors.yellow.shade100
                                    : (i == 2)
                                        ? Colors.blue.shade100
                                        : const Color(0xffDBF9F8),
                                  
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('${list_point[i]} points')),
                              ),
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            height: 5,
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
