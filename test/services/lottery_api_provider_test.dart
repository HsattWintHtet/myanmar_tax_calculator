import 'package:flutter_test/flutter_test.dart';
import 'package:ird_myanmar_app/src/services/lottery_api_provider.dart';
import 'package:ird_myanmar_app/src/model/Lottery_result_param.dart';

void main() {
  test('lottery result api call integration testing', () {
    final api = LotteryResultAPI();

    api.postLotteryResult(LotteryResultParam.fromJson({"param":"က ၁၂၃၄၅၆"})).then((result){
      print('print result ${result.resultMsg}');
    });
  });
}