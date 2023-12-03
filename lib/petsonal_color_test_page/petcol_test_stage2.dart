import 'package:flutter/material.dart';
import 'package:mungshinsa/petsonal_color_test_page/petcol_test_result.dart';
import 'package:mungshinsa/petsonal_color_test_page/petcol_test_stage3.dart';
import 'package:mungshinsa/petsonal_color_test_page/petcol_test_widgets.dart';
import 'package:mungshinsa/petsonal_color_test_page/test_info.dart';

import '../providers/petsnal_color_provider.dart';

List<String> clearChoices = [
  'Glossy하고 라인이 깔끔해보인다.',
  '조금 gloss하고 라인 깔끔해보인다.',
  'Oily하고 주름이 두드러진다.'
];
List<String> dullChoices = [
  '톤이 고르고 윤곽이 매끈해보인다',
  '조금 고르고 매끈.',
  '매트하고 탄력이 부족해보인다'
];

class Stage2Question1 extends StatelessWidget {
  const Stage2Question1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Question(
        imageNum: 0, choices: clearChoices, nextPage: const Stage2Question2());
  }
}

class Stage2Question2 extends StatelessWidget {
  const Stage2Question2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Question(
        imageNum: 1, choices: dullChoices, nextPage: Stage2Question3());
  }
}

class Stage2Question3 extends StatelessWidget {
  const Stage2Question3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Question(
        imageNum: 2, choices: clearChoices, nextPage: Stage2Question4());
  }
}

class Stage2Question4 extends StatelessWidget {
  const Stage2Question4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Question(
        imageNum: 3, choices: dullChoices, nextPage: Stage2Question5());
  }
}

class Stage2Question5 extends StatelessWidget {
  const Stage2Question5({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Question(
        imageNum: 4, choices: clearChoices, nextPage: Stage2Question6());
  }
}

class Stage2Question6 extends StatelessWidget {
  const Stage2Question6({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Question(
        imageNum: 5,
        choices: dullChoices,
        nextPage: AdditinalQuestionOrNextStageOrResult());
  }
}

class AdditinalQuestionOrNextStageOrResult extends StatefulWidget {
  const AdditinalQuestionOrNextStageOrResult({Key? key}) : super(key: key);

  @override
  _AdditinalQuestionOrNextStageOrResultState createState() =>
      _AdditinalQuestionOrNextStageOrResultState();
}

class _AdditinalQuestionOrNextStageOrResultState
    extends State<AdditinalQuestionOrNextStageOrResult> {
  Widget? _currentPage;

  @override
  void initState() {
    super.initState();
    _loadPage();
  }

  Future<void> _loadPage() async {
    if (testInfo.currentStage == 2) {
      if (testInfo.warmClearLow == testInfo.coolDullHigh) {
        _currentPage = AdditionalQuestion(imageNum: 6, nextPage: Stage3Q1());
      } else {
        try {
          Map<dynamic, dynamic> result =
              await petsnalColorProvider.PetsnalColorStage(
            testInfo.currentStage,
            1,
            testInfo.resultList,
          );
          setState(() {
            testInfo.images = result;
            testInfo.currentStage = result['nextStage'];
            testInfo.clearScore();
            testInfo.clearResultList();
            _currentPage = Stage3Q1();
          });
        } catch (error) {
          // 에러 처리 로직
          print('Error: $error');
          _currentPage = PetColResult(); // 에러 발생 시 기본 페이지 설정
        }
      }
    } else {
      if (testInfo.warmClearLow == testInfo.coolDullHigh) {
        _currentPage =
            AdditionalQuestion(imageNum: 6, nextPage: PetColResult());
      } else {
        try {
          Map<dynamic, dynamic> result =
              await petsnalColorProvider.PetsnalColorStage(
            testInfo.currentStage,
            1,
            testInfo.resultList,
          );
          setState(() {
            testInfo.images = result;
            // 이후에 원하는 다른 로직을 수행
            _currentPage = PetColResult();
          });
        } catch (error) {
          // 에러 처리 로직
          print('Error: $error');
          _currentPage = PetColResult(); // 에러 발생 시 기본 페이지 설정
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return _currentPage ?? CircularProgressIndicator();
  }
}

class NextStage extends StatelessWidget {
  const NextStage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Question(
        imageNum: 7, choices: dullChoices, nextPage: PetColResult());
  }
}
