import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myanmar_tax_calculator/src/model/lottery_result.dart';
import 'package:myanmar_tax_calculator/src/model/Lottery_result_param.dart';
import 'package:myanmar_tax_calculator/src/ui/utils/constant_utils.dart';


class LotteryResultAPI {


  Future<LotteryResult> postLotteryResult(LotteryResultParam param) async => await http.post("${ConstantUtils.BASE_URL}",
      body: lotteryResultParamToJson(param),
      headers: {"content-type":"application/json"},
  ).then((response) {
      print('response status: ${response.statusCode}');
      print('response body: ${json.decode(response.body)}');
      if (response.statusCode == 200) {

        // If the call to the server was successful, parse the JSON
        LotteryResult result = LotteryResult.fromJson(json.decode(response.body));
        print('after decode response body: $result');
        return result;
      }
  }).catchError((onError){
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post ${onError.statusCode}');
  });
}
