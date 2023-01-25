import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../../constants.dart';
import '../model/question.dart';

class OptionCard extends StatefulWidget {
  const OptionCard({
    super.key,
    required this.text,
    required this.questionList,
    required this.questionIndex,
  });
  final String text;
  final List<Question> questionList;
  final int questionIndex;

  @override
  State<OptionCard> createState() => _OptionCardState();
}

class _OptionCardState extends State<OptionCard> {
  Color backgroundColor = const Color(0xffFFDA2C);
  Color textColor = Colors.black;
  bool isLocked = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.questionList[widget.questionIndex].options[widget.text] ==
            true) {
          setState(() {
            backgroundColor = const Color(0xff49B0AB);
          });
        } else {
          setState(() {
            backgroundColor = Colors.red;
          });
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            widget.text,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.normal,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
