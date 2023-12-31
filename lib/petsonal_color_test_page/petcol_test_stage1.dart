import 'package:flutter/material.dart';
import 'package:mungshinsa/petsonal_color_test_page/petcol_test_stage2.dart';
import 'package:mungshinsa/petsonal_color_test_page/petcol_test_widgets.dart';
import 'package:mungshinsa/petsonal_color_test_page/test_info.dart';

import '../providers/petsnal_color_api.dart';

List<String> warmChoices = ['활기차 보인다.', '어느 정도 활기차 보인다.', '힘이 없어 보인다.'];
List<String> coolChoices = ['맑고 깨끗해 보인다.', '어느 정도 맑고 깨끗해 보인다.', '흐릿해 보인다.'];

class Question1 extends StatelessWidget {
  const Question1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QuestionPage(
        imageNum: 0, choices: warmChoices, nextPage: const Question2());
  }
}

class Question2 extends StatelessWidget {
  const Question2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QuestionPage(
        imageNum: 1, choices: coolChoices, nextPage: Question3());
  }
}

class Question3 extends StatelessWidget {
  const Question3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QuestionPage(
        imageNum: 2, choices: warmChoices, nextPage: Question4());
  }
}

class Question4 extends StatelessWidget {
  const Question4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QuestionPage(
        imageNum: 3, choices: coolChoices, nextPage: Question5());
  }
}

class Question5 extends StatelessWidget {
  const Question5({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QuestionPage(
        imageNum: 4, choices: warmChoices, nextPage: Question6());
  }
}

class Question6 extends StatelessWidget {
  const Question6({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QuestionPage(
        imageNum: 5,
        choices: coolChoices,
        nextPage: const AdditinalQuestionOrNextStage());
  }
}

class AdditinalQuestionOrNextStage extends StatelessWidget {
  const AdditinalQuestionOrNextStage({super.key});
  @override
  Widget build(BuildContext context) {
    if (testInfo.warmClearLow == testInfo.coolDullHigh) {
      return AdditionalQuestion(imageNum: 6, nextPage: Stage2Question1());
    } else {
      print('warm: ${testInfo.warmClearLow} cool: ${testInfo.coolDullHigh}');
      print(testInfo.currentStage);
      print(testInfo.resultList);
      return FutureBuilder<Map<dynamic, dynamic>>(
        future: petsnalColorProvider.PetsnalColorStage(
            testInfo.currentStage, testInfo.preferId!, testInfo.resultList),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // 비동기 작업이 완료될 때까지 로딩 인디케이터나 다른 로딩 UI를 표시합니다.
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            // 에러를 처리합니다.
            print('Error: ${snapshot.error}');
            return SizedBox(); // 기본 위젯을 반환하거나 에러 케이스를 처리합니다.
          } else {
            //testInfo.clearImageMap();
            testInfo.images = snapshot.data!;
            print(testInfo.images);
            testInfo.currentStage = snapshot.data!['nextStage'];
            testInfo.clearScore();
            testInfo.clearResultList();

            return Stage2Question1();
          }
        },
      );
    }
  }
}
