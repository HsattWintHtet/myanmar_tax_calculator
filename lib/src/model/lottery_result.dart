import 'dart:convert';

LotteryResult lotteryResultFromJson(String str) {
  final jsonData = json.decode(str);
  return new LotteryResult.fromJson(jsonData);
}

String lotteryResultToJson(LotteryResult data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class LotteryResult {
  String resultMsg;

  LotteryResult({
    this.resultMsg,
  });

  factory LotteryResult.fromJson(Map<String, dynamic> json) => new LotteryResult(
    resultMsg: json["resultMsg"],
  );

  Map<String, dynamic> toJson() => {
    "resultMsg": resultMsg,
  };

  @override
  String toString() {
    return 'LotteryResult{resultMsg: $resultMsg}';
  }
}
