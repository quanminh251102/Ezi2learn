import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:group_button/group_button.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';

class VocaQuiz extends StatefulWidget {
  const VocaQuiz({super.key});

  @override
  State<VocaQuiz> createState() => _VocaQuizState();
}

class _VocaQuizState extends State<VocaQuiz> {
  @override
  Widget build(BuildContext context) {
    var statusBarHeight = MediaQuery.of(context).viewPadding.top;
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    double paddingNum = deviceWidth / 32;

    final double titleWidgetWidth = deviceWidth - paddingNum * 2;
    final double titleWidgetHeight = deviceHeight * 0.1;
    Widget titleWidget = Positioned(
      top: statusBarHeight + deviceHeight * 0.06 / 2,
      left: (deviceWidth - titleWidgetWidth) / 2,
      width: titleWidgetWidth,
      height: titleWidgetHeight,
      child: Column(
        children: [
          const Text(
            'Vocabulary Quiz',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 24,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          Center(
              child: FAProgressBar(
            backgroundColor: const Color(0xffC4C4C4),
            changeProgressColor: const Color(0xffFFDA2C),
            progressColor: const Color(0xffFFDA2C),
            currentValue: 80,
            displayText: '%',
            size: deviceHeight * 0.02,
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const <Widget>[
              Text(
                'Level 3',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
              Text(
                '54% - More 1250 pts to reach Level 4',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: Color(0xff8A8A8A),
                ),
              ),
            ],
          ),
        ],
      ),
    );

    final double backButtonHeight = deviceHeight * 0.05;
    Widget backButton = Positioned(
      top: statusBarHeight,
      left: -10,
      height: backButtonHeight,
      child: CircleAvatar(
        backgroundColor: const Color(0xffFFAD85),
        radius: backButtonHeight,
        child: IconButton(
          padding: const EdgeInsets.all(0),
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            print("Click back button");
          },
        ),
      ),
    );

    double spaceBetweenTilteAndPicture = deviceHeight * 0.04;
    double pictureHeight = deviceHeight * 0.35;
    Widget picture = Positioned(
      top: statusBarHeight + titleWidgetHeight + spaceBetweenTilteAndPicture,
      left: 0,
      width: deviceWidth - paddingNum,
      height: pictureHeight,
      child: Image.asset(
        'assets/voca_quiz/cat.png',
        width: deviceWidth,
        fit: BoxFit.fill,
      ),
    );

    double pictureButtonsWidth = deviceWidth - paddingNum * 10;
    Widget pictureButtons = Positioned(
      top: statusBarHeight + titleWidgetHeight + pictureHeight / 1.5,
      left: (deviceWidth - pictureButtonsWidth) / 2,
      width: pictureButtonsWidth,
      //height: 250,
      child: Column(
        children: <Widget>[
          const Center(
            child: Text('here'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                padding: const EdgeInsets.all(0),
                autofocus: true,
                icon: Image.asset(
                  'assets/voca_quiz/snail.png',
                  width: 200,
                  height: 200,
                  fit: BoxFit.fill,
                ),
                color: Colors.yellow,
                onPressed: () {
                  print("Click back button 1");
                },
              ),
              IconButton(
                padding: const EdgeInsets.all(0),
                icon: Image.asset(
                  'assets/voca_quiz/listen_button.png',
                  width: 200,
                  height: 200,
                  fit: BoxFit.fill,
                ),
                color: Colors.yellow,
                onPressed: () {
                  print("Click back button 2");
                },
              ),
            ],
          ),
        ],
      ),
    );

    double spaceBetweenPictureAndAnswerButtons = deviceHeight * 0.08;
    double answerButtonsWidth = deviceWidth * 0.45;
    Widget answerButtons = Positioned(
        top: statusBarHeight +
            titleWidgetHeight +
            spaceBetweenTilteAndPicture +
            pictureButtonsWidth +
            spaceBetweenPictureAndAnswerButtons,
        left: paddingNum,
        width: deviceWidth - paddingNum * 2,
        height: 250,
        child: GroupButton(
          options: GroupButtonOptions(
            selectedShadow: const [],
            selectedTextStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            selectedColor: const Color(0xff49B0AB),
            unselectedShadow: const [],
            unselectedColor: const Color(0xffFFDA2C),
            unselectedTextStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            selectedBorderColor: Colors.black,
            unselectedBorderColor: Colors.black,
            borderRadius: BorderRadius.circular(10),
            spacing: deviceWidth - answerButtonsWidth * 2 - paddingNum * 2,
            runSpacing: 10,
            groupingType: GroupingType.wrap,
            direction: Axis.horizontal,
            buttonHeight: deviceHeight * 0.1,
            buttonWidth: answerButtonsWidth,
            mainGroupAlignment: MainGroupAlignment.spaceBetween,
            crossGroupAlignment: CrossGroupAlignment.center,
            groupRunAlignment: GroupRunAlignment.start,
            textAlign: TextAlign.center,
            textPadding: EdgeInsets.zero,
            alignment: Alignment.center,
            elevation: 0,
          ),
          isRadio: true,
          onSelected: (i, index, isSelected) =>
              print('$index button is selected'),
          buttons: const ["Cat", "Chickend", "Horse", "Fox"],
        ));

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.black, // navigation bar color
        statusBarIconBrightness: Brightness.dark, // status bar icons' color
        systemNavigationBarIconBrightness:
            Brightness.dark, //navigation bar icons' color
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            titleWidget,
            picture,
            pictureButtons,
            backButton,
            answerButtons,
          ],
        ),
      ),
    );
  }
}
