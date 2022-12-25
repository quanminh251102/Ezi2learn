import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:rive_animation/screens/vocabulary/data/topic_data.dart';
import 'package:rive_animation/screens/vocabulary/model/topic.dart';
import 'package:rive_animation/storage/storage_services.dart';
import '../widget/topic_card.dart';

class VocaMainScreen extends StatefulWidget {
  const VocaMainScreen({super.key});

  @override
  State<VocaMainScreen> createState() => _VocaMainScreenState();
}

class _VocaMainScreenState extends State<VocaMainScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    List<Topic> vocaTopic = allTopic;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Vocabulary',
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05),
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                Center(
                    child: FAProgressBar(
                  backgroundColor: const Color(0xffC4C4C4),
                  changeProgressColor: const Color(0xffFFDA2C),
                  progressColor: const Color(0xffFFDA2C),
                  currentValue: 80,
                  displayText: '%',
                  size: 20,
                )),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Level 3',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      '54% - More 1250 pts to reach Level 4',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: Color(0xff8A8A8A),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                FutureBuilder(
                  future: storage.listFiles(),
                  builder: ((context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
                      return Container();
                    }
                    if(snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData){
                      return const Center(child: CircularProgressIndicator());
                    }
                    return Container();
                  })),
                Expanded(
                  child: SizedBox(
                    child: SingleChildScrollView(
                      child: GridView.builder(
                          physics: const ScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: vocaTopic.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 20,
                                  childAspectRatio: 1.1,
                                  mainAxisSpacing: 20,
                                  crossAxisCount: 2),
                          itemBuilder: ((context, index) {
                            return TopicCard(vocaTopic: vocaTopic[index]);
                          })),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
