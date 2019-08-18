import 'dart:async';
import 'package:ird_myanmar_app/src/model/Lottery_result_param.dart';
import 'package:ird_myanmar_app/src/services/SharedPreferencesHelper.dart';

import 'lottery_api_provider.dart';
import '../model/lottery_result.dart';

class LotteryResultRepository {
  final lotteryAPI = LotteryResultAPI();

  Future<LotteryResult> findLotteryResult(LotteryResultParam param) => lotteryAPI.postLotteryResult(param);

  Future<List<SharedItem>> getSavedResultData() async => SharedPreferencesHelper.getAllParam();

  Future<bool> deleteSavedResultData(String key) async => SharedPreferencesHelper.deleteParam(key);

  Future<bool> savedResultData(String key, String value) async => SharedPreferencesHelper.saveParam(key, value);
}