class TestInfo {
  int currentStage = 0;
  late Map<dynamic, dynamic> images;

  List<int> resultList = [];

  addToResultList(int score) {
    resultList.add((score));
  }

  clearResultList() {
    resultList.clear();
  }

  int warmClearLow = 0;
  int coolDullHigh = 0;

  increaseWCL(int score) {
    warmClearLow += score;
    //notifyListeners();
  }

  increaseCDH(int score) {
    coolDullHigh += score;
  }

  clearScore() {
    warmClearLow = 0;
    coolDullHigh = 0;
  }
}

TestInfo testInfo = TestInfo();
