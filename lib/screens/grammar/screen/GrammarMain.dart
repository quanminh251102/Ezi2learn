import 'package:flutter/material.dart';
import './GrammarQuiz.dart';
import 'package:timeline_tile/timeline_tile.dart';

import 'dart:math';

import 'package:google_fonts/google_fonts.dart';
import '../../home/screen/home_page.dart' as NewHomePage;

class GrammarMainPage extends StatefulWidget {
  const GrammarMainPage({super.key});

  @override
  State<GrammarMainPage> createState() => _GrammarMainPageState();
}

class _GrammarMainPageState extends State<GrammarMainPage> {
  late List<Step> _steps;

  List<Step> _generateData() {
    return <Step>[
      const Step(
        step: 1,
        title: 'Present simple tense',
        message:
            'used to express an obvious fact or an action that takes place repeatedly according to habits, customs, abilities',
      ),
      const Step(
        step: 2,
        title: 'The present continuous tense',
        message:
            'used to describe things that happen at the moment we speak or around the time we speak, and the action has not ended (continues to happen)',
      ),
      const Step(
        step: 3,
        title: 'Present perfect',
        message:
            'Used to express an action or event that started in the past, continues to the present, and can continue into the future.',
      ),
      const Step(
        step: 4,
        title: 'Present perfect continuous tense',
        message:
            'is a tense to describe an event that started in the past and continues in the present. It can continue in the future. The event has ended but the effect remains in the present.',
      ),
      const Step(
        step: 5,
        title: 'The past simple',
        message:
            'Used to describe an action or event that started and ended in the past',
      ),
      const Step(
        step: 6,
        title: 'Past continuous tense',
        message:
            'Used to describe an action or event that was happening around a time in the past',
      ),
      const Step(
        step: 7,
        title: 'Past Perfect Tense',
        message:
            'Used to describe an action that happened before another action in the past. For the action that happened first, use the past perfect. When the action happens after, use the past simple',
      ),
      const Step(
        step: 8,
        title: 'Past perfect continuous',
        message:
            'Used to describe an action that was happening in the past and ended before an action that also happened in the past.',
      ),
      const Step(
        step: 9,
        title: 'Simple future tense',
        message:
            'used when there is no plan or decision to do anything before we speak. We make spontaneous decisions at the moment of speaking',
      ),
      const Step(
        step: 10,
        title: 'The future continues',
        message:
            'Used to express an action that will be happening at a specific time in the future',
      ),
      const Step(
        step: 11,
        title: 'Future perfect tense',
        message:
            'Used to express an action or event completed before a certain time in the future',
      ),
      const Step(
        step: 12,
        title: 'Future perfect continuous',
        message:
            'Used to express an action, the event will happen and will happen continuously before a certain time in the future',
      ),
    ];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _steps = _generateData();
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildBottomCard() {
      return Container(
        decoration: const BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.only(
              topRight: Radius.elliptical(32.0, 10.0),
              topLeft: Radius.elliptical(32.0, 10.0)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
              color: Colors.white,
            ),
            IconButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => HomePage()),
                // );
              },
              icon: const Icon(Icons.home),
              color: Colors.white,
            ),
            IconButton(
              onPressed: (() => setState(() {
                    // playmusic = !playmusic;
                  })),
              icon: const Icon(Icons.settings),
              color: Colors.white,
            ),
          ],
        ),
      );
    }

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final appBar = AppBar(
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
      title: const Text(
        'Grammar',
        style: TextStyle(
            color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
      ),
      leading: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NewHomePage.HomePage(),
            ),
          );
        },
        child: const Icon(
          Icons.arrow_back_ios_rounded,
          color: Colors.black,
        ),
      ),
    );
    return Container(
      //color: const Color(0xffDBF9F8),
      color: Colors.white,
      child: Theme(
        data: Theme.of(context).copyWith(
          // accentColor: const Color(0xFFFCB69F).withOpacity(0.2),
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
        ),
        child: SafeArea(
          child: Scaffold(
            //bottomNavigationBar: _buildBottomCard(),
            appBar: appBar,
            backgroundColor: Colors.transparent,
            body: Center(
              child: Column(
                children: <Widget>[
                  //TopBar("HỌC NGỮ PHÁP QUA QUIZ"),
                  _Header(),
                  Expanded(
                    child: CustomScrollView(
                      slivers: <Widget>[_TimelineSteps(steps: _steps)],
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TimelineSteps extends StatelessWidget {
  const _TimelineSteps({Key? key, required this.steps}) : super(key: key);

  final List<Step> steps;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          if (index.isOdd) {
            return const TimelineDivider(
              //color: Color(0xFFCB8421),
              color: Color(0xffFFDA2C),
              thickness: 5,
              begin: 0.1,
              end: 0.9,
            );
          }

          final int itemIndex = index ~/ 2;
          final Step step = steps[itemIndex];

          final bool isLeftAlign = itemIndex.isEven;

          final child = _TimelineStepsChild(
            title: step.title,
            subtitle: step.message,
            isLeftAlign: isLeftAlign,
          );

          final isFirst = itemIndex == 0;
          final isLast = itemIndex == steps.length - 1;
          double indicatorY;
          if (isFirst) {
            indicatorY = 0.2;
          } else if (isLast) {
            indicatorY = 0.8;
          } else {
            indicatorY = 0.5;
          }

          return TimelineTile(
            alignment: TimelineAlign.manual,
            endChild: isLeftAlign ? child : null,
            startChild: isLeftAlign ? null : child,
            lineXY: isLeftAlign ? 0.1 : 0.9,
            isFirst: isFirst,
            isLast: isLast,
            indicatorStyle: IndicatorStyle(
              width: 40,
              height: 40,
              indicatorXY: indicatorY,
              indicator: _TimelineStepIndicator(step: '${step.step}'),
            ),
            beforeLineStyle: const LineStyle(
              // color: Color(0xFFCB8421),
              color: Color(0xffFFDA2C),
              thickness: 5,
            ),
          );
        },
        childCount: max(0, steps.length * 2 - 1),
      ),
    );
  }
}

class _TimelineStepIndicator extends StatelessWidget {
  const _TimelineStepIndicator({Key? key, required this.step})
      : super(key: key);

  final String step;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => GrammarQuiz(
                  step: step,
                )));
      },
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xffFFDA2C),
        ),
        child: Center(
          child: Text(
            step,
            style: GoogleFonts.architectsDaughter(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class _TimelineStepsChild extends StatelessWidget {
  const _TimelineStepsChild({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.isLeftAlign,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final bool isLeftAlign;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isLeftAlign
          ? const EdgeInsets.only(right: 32, top: 16, bottom: 16, left: 10)
          : const EdgeInsets.only(left: 32, top: 16, bottom: 16, right: 10),
      child: Column(
        crossAxisAlignment:
            isLeftAlign ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            title,
            textAlign: isLeftAlign ? TextAlign.right : TextAlign.left,
            style: GoogleFonts.acme(
              fontSize: 22,
              color: const Color(0xffFFDA2C),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            subtitle,
            textAlign: isLeftAlign ? TextAlign.right : TextAlign.left,
            style: GoogleFonts.architectsDaughter(
              fontSize: 16,
              color: const Color(0xffFFDA2C),
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              '12 Tenses In English',
              textAlign: TextAlign.center,
              style: GoogleFonts.architectsDaughter(
                fontSize: 26,
                color: const Color(0xffFFDA2C),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Step {
  const Step({
    required this.step,
    required this.title,
    required this.message,
  });

  final int step;
  final String title;
  final String message;
}
