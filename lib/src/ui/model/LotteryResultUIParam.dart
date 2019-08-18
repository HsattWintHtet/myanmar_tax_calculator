class LotteryResultUIParam {

  int lotteryType;
  String checkingType = '1';
  int numOfTimes = 1;
  String character1;
  String character2;
  String number1;
  String number2;

  LotteryResultUIParam(this.lotteryType, this.checkingType);

  LotteryResultUIParam.defaultConstructor();

  @override
  String toString() {
    return 'LotteryResultParam{lotteryType: $lotteryType, '
        'checkingType: $checkingType, character1: $character1, '
        'character2: $character2, number1: $number1, number2: $number2, numOfTimes: $numOfTimes}';
  }


}