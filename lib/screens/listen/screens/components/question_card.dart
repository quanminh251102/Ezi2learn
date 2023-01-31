import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_cards/flutter_custom_cards.dart';
import 'package:get/get.dart';
import '../../controllers/question_controller.dart';
import '../../models/Questions.dart';

import '../../constaints/constants.dart';
import 'option.dart';

class QuestionCard extends StatefulWidget {
  const QuestionCard({
    Key? key,
    // it means we have to pass this
    required this.question,
  }) : super(key: key);

  final Question question;

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  final player = AudioPlayer();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    player.play(AssetSource("audio/${widget.question.id}.mp3"));
  }

  void listenAgain() {
    player.play(AssetSource("audio/${widget.question.id}.mp3"));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    player.dispose();
  }

  @override
  Widget build(BuildContext context) {
    QuestionController controller = Get.put(QuestionController());
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      padding: const EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          Text(
            widget.question.question,
            // style: Theme.of(context)
            //     .textTheme
            //     .headline6
            //     .copyWith(color: kBlackColor),
            style: const TextStyle(color: kBlackColor),
          ),
          Row(
            children: [
              CustomCard(
                borderRadius: 130,
                child: const Icon(
                  Icons.volume_up,
                  color: Colors.black,
                ),
                onTap: () {
                  listenAgain();
                },
              ),
              const Text('Listen again'),
            ],
          ),
          const SizedBox(height: kDefaultPadding / 2),
          ...List.generate(
            widget.question.options.length,
            (index) => Option(
              index: index,
              text: widget.question.options[index],
              press: () => controller.checkAns(widget.question, index),
            ),
          ),
        ],
      ),
    );
  }
}
