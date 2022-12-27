import 'package:flutter/material.dart';
import 'package:rive_animation/screens/vocabulary/model/topic.dart';
import 'package:rive_animation/screens/vocabulary/widget/progress_status.dart';

class TopicCard extends StatefulWidget {
  final Topic vocaTopic;
  const TopicCard({super.key, required this.vocaTopic});

  @override
  State<TopicCard> createState() => _TopicCardState();
}

class _TopicCardState extends State<TopicCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: Container(
        height: 150,
        width: 150,
        decoration: BoxDecoration(
            color: const Color(0xffDBF9F8),
            border: Border.all(color: const Color(0xffFFDA2C), width: 3),
            borderRadius: BorderRadius.circular(10)),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
              width: 50,
              height: 50,
              child: Image.network(widget.vocaTopic.image)),
          Text(
            widget.vocaTopic.title,
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: 'Intel',
                color: Colors.black),
          ),
          Text(
            '${widget.vocaTopic.point} pts',
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          ),
          widget.vocaTopic.progress == 1
              ? const ProgressStatus(progress: 1)
              : widget.vocaTopic.progress == 2
                  ? const ProgressStatus(progress: 2)
                  : const ProgressStatus(progress: 3)
        ]),
      ),
    );
  }
}
