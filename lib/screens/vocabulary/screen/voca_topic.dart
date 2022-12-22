import 'package:flutter/material.dart';
import 'package:rive_animation/screens/vocabulary/data/topic_data.dart';
import 'package:rive_animation/screens/vocabulary/model/topic.dart';
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
    List<VocaTopic> voca_topic = allTopic;
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Center(
                child: Text('Thang điểm'),
              ),
              GridView.builder(
                  physics: ScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: voca_topic.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: ((context, index) {
                    return TopicCard(vocaTopic: voca_topic[index]);
                  }))
            ],
          ),
        ),
      ),
    );
  }
}
