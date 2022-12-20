import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class VocaMainScreen extends StatefulWidget {
  const VocaMainScreen({super.key});

  @override
  State<VocaMainScreen> createState() => _VocaMainScreenState();
}

class _VocaMainScreenState extends State<VocaMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Vocabulary',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                )
              ],
            )),
      ),
    );
  }
}
