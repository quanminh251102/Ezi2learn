import 'package:flutter/material.dart';
import 'package:rive_animation/screens/vocabulary/data/option_data.dart';
import 'package:rive_animation/screens/vocabulary/data/question_data.dart';
import 'package:rive_animation/screens/vocabulary/data/topic_data.dart';
import 'package:rive_animation/screens/vocabulary/data/voca_data.dart';
import 'package:rive_animation/screens/vocabulary/model/question.dart';
import 'package:rive_animation/screens/vocabulary/model/topic.dart';
import 'package:rive_animation/screens/vocabulary/model/vocabulary.dart';
import 'package:rive_animation/storage/api_services.dart';

import '../model/option.dart';

class AddData extends StatefulWidget {
  const AddData({super.key});

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  @override
  Widget build(BuildContext context) {
    List<Topic> listTopic = allTopic;
    List<Vocabulary> listVoca = allVoca;
    List<Question> listQuestion = allQuestion;
    List<Option> listOption = allOption;
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Center(
            child: GestureDetector(
              onTap: () {
                for (int i = 0; i < listTopic.length; i++) {
                  ApiServices.addTopic(tempTopic: listTopic[i]);
                }
                for (int i = 0; i < listVoca.length; i++) {
                  double newIndex = i / 10;
                  ApiServices.addvocabinTopic(
                      id: listTopic[newIndex.toInt()].title,
                      tempVoca: listVoca[i]);
                }
                for (int i = 0; i < listQuestion.length; i++) {
                  ApiServices.addQuestion(tempQuestion: listQuestion[i]);
                }
                for (int i = 0; i < listOption.length; i++) {
                  double newIndex = i / 4;
                  ApiServices.addoptioninQuestion(
                      id: listQuestion[newIndex.toInt()].text,
                      tempOption: listOption[i]);
                }
              },
              child: Container(
                  color: Colors.blue,
                  height: 50,
                  width: 200,
                  child: const Center(child: Text('Load data'))),
            ),
          )
        ],
      )),
    );
  }
}
