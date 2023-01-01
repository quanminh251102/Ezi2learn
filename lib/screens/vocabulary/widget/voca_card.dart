import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rive_animation/screens/vocabulary/model/topic.dart';
import 'package:rive_animation/screens/vocabulary/model/vocabulary.dart';
import 'package:rive_animation/screens/vocabulary/widget/progress_status.dart';

class VocaCard extends StatefulWidget {
  final Vocabulary vocabulary;
  const VocaCard({super.key, required this.vocabulary});

  @override
  State<VocaCard> createState() => _VocaCardState();
}

class _VocaCardState extends State<VocaCard> {
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
              child: Image.network(widget.vocabulary.image)),
          const SizedBox(height: 10,),
          Text(
            widget.vocabulary.spelling,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                fontFamily: 'Intel',
                color: Colors.black),
          ),
          Text(
            widget.vocabulary.text,
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: 'Intel',
                color: Colors.black),
          ),
        ]),
      ),
    );
  }
}
