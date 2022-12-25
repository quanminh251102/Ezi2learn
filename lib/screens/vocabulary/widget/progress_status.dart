import 'package:flutter/material.dart';

class ProgressStatus extends StatefulWidget {
  final int progress;
  const ProgressStatus({super.key, required this.progress});

  @override
  State<ProgressStatus> createState() => _ProgressStatusState();
}

class _ProgressStatusState extends State<ProgressStatus> {
  @override
  Widget build(BuildContext context) {
    return widget.progress == 1
        ? Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Container(
              height: 20,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color(0xff43CC28),
              ),
              child: const Center(
                  child: Text(
                'Complete',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              )),
            ),
          )
        : widget.progress == 2
            ? Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  height: 20,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color(0xffFFDA2C),
                  ),
                  child: const Center(
                      child: Text(
                    'In Progress',
                    style: TextStyle(
                        color: Color(0xffB16E3D),
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  )),
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  height: 20,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: const Center(
                      child: Text(
                    'To do',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  )),
                ),
              );
  }
}
