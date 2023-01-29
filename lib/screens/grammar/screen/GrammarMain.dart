import 'package:flutter/material.dart';
import './GrammarQuiz.dart';
import '../widgets/TopBar.dart';
import 'package:group_button/group_button.dart';
import 'package:flutter_custom_cards/flutter_custom_cards.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:timeline_tile/timeline_tile.dart';

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeline_tile/timeline_tile.dart';
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
        title: 'Thì hiện tại đơn',
        message:
            'dùng để diễn tả một sự thật hiển nhiên hay một hành động diễn ra lặp đi lặp lại theo thói quen, phong tục, khả năng',
      ),
      const Step(
        step: 2,
        title: 'Thì hiện tại tiếp diễn',
        message:
            'dùng để diễn tả những sự việc xảy ra ngay lúc chúng ta nói hay xung quanh thời điểm chúng ta nói, và hành động đó vẫn chưa chấm dứt (còn tiếp tục diễn ra)',
      ),
      const Step(
        step: 3,
        title: 'Thì hiện tại hoàn thành',
        message:
            'dùng để diễn tả một hành động, sự việc đã bắt đầu từ trong quá khứ, kéo dài đến hiện tại và có thể tiếp tục tiếp diễn trong tương lai',
      ),
      const Step(
        step: 4,
        title: 'Thì hiện tại hoàn thành tiếp diễn',
        message:
            'là thì diễn tả sự việc bắt đầu trong quá khứ và tiếp tục ở hiện tại có thể tiếp diễn ở tương lai sự việc đã kết thúc nhưng ảnh hưởng kết quả còn lưu lại hiện tại',
      ),
      const Step(
        step: 5,
        title: 'Thì quá khứ đơn',
        message:
            'dùng để diễn tả một hành động, sự việc diễn ra và kết thúc trong quá khứ',
      ),
      const Step(
        step: 6,
        title: 'Thì quá khứ tiếp diễn',
        message:
            'dùng để diễn tả một hành động, sự việc đang diễn ra xung quanh một thời điểm trong quá khứ',
      ),
      const Step(
        step: 7,
        title: 'Thì quá khứ hoàn thành',
        message:
            'dùng để diễn tả một hành động xảy ra trước một hành động khác trong quá khứ. Hành động nào xảy ra trước thì dùng thì quá khứ hoàn thành. Hành động xảy ra sau thì dùng thì quá khứ đơn',
      ),
      const Step(
        step: 8,
        title: 'Thì quá khứ hoàn thành tiếp diễn',
        message:
            'dùng để diễn tả một hành động, sự việc đã đang xảy ra trong quá khứ và kết thúc trước một hành động cũng xảy ra trong quá khứ',
      ),
      const Step(
        step: 9,
        title: 'Thì tương lai đơn',
        message:
            'được dùng khi không có kế hoạch hay quyết định làm gì nào trước khi chúng ta nói. Chúng ta ra quyết định tự phát tại thời điểm nói',
      ),
      const Step(
        step: 10,
        title: 'Thì tương lai tiếp diễn',
        message:
            'dùng để diễn tả một hành động, sự việc sẽ đang diễn ra tại một thời điểm cụ thể trong tương lai',
      ),
      const Step(
        step: 11,
        title: 'Thì tương lai hoàn thành',
        message:
            'dùng để diễn tả một hành động hay sự việc hoàn thành trước một thời điểm trong tương lai',
      ),
      const Step(
        step: 12,
        title: 'Thì tương lai hoàn thành tiếp diễn',
        message:
            'dùng để diễn tả một hành động, sự việc sẽ xảy ra và xảy ra liên tục trước một thời điểm nào đó trong tương lai',
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
        decoration: BoxDecoration(
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
              icon: Icon(Icons.arrow_back),
              color: Colors.white,
            ),
            IconButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => HomePage()),
                // );
              },
              icon: Icon(Icons.home),
              color: Colors.white,
            ),
            IconButton(
              onPressed: (() => setState(() {
                    // playmusic = !playmusic;
                  })),
              icon: Icon(Icons.settings),
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
      //elevation: 0,
      title: const Text(
        'Ngữ pháp',
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
          accentColor: Colors.white,
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
          if (index.isOdd)
            return const TimelineDivider(
              //color: Color(0xFFCB8421),
              color: const Color(0xffFFDA2C),
              thickness: 5,
              begin: 0.1,
              end: 0.9,
            );

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
              color: const Color(0xffFFDA2C),
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
          color: const Color(0xffFFDA2C),
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
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              '12 Thì Trong Tiếng Anh',
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
