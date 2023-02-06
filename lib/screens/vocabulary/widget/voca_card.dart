import 'package:flutter/material.dart';
import 'package:rive_animation/screens/vocabulary/model/vocabulary.dart';

class VocaCard extends StatefulWidget {
  final Vocabulary vocabulary;
  final bool isChecked;
  const VocaCard(
      {super.key, required this.vocabulary, required this.isChecked});

  @override
  State<VocaCard> createState() => _VocaCardState();
}

class _VocaCardState extends State<VocaCard> {
  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.white,
      elevation: 8,
      shadowColor: Colors.black,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 150,
        width: 150,
        decoration: BoxDecoration(
            color: const Color(0xffDBF9F8),
            border: Border.all(
                color: const Color.fromARGB(255, 227, 200, 200), width: 1.5),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            widget.isChecked
                ? const Padding(
                    padding: EdgeInsets.only(right: 5, top: 10, bottom: 10),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Icon(
                        Icons.check,
                        color: Colors.green,
                        size: 25,
                      ),
                    ),
                  )
                : const Padding(
                    padding: EdgeInsets.only(right: 5, bottom: 45),
                  ),
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(
                  width: 50,
                  height: 50,
                  child: Image.network(widget.vocabulary.image)),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.vocabulary.text,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Intel',
                    color: Colors.black),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
