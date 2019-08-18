import 'dart:convert';

LotteryResultParam lotteryResultParamFromJson(String str) {
  final jsonData = json.decode(str);
  return LotteryResultParam.fromJson(jsonData);
}

String lotteryResultParamToJson(LotteryResultParam data) {
  return json.encode(data.toJson());
}

class LotteryResultParam {
  String param;
  int numOfTime;

  LotteryResultParam({
    this.param,
    this.numOfTime
  });

  factory LotteryResultParam.fromJson(Map<String, dynamic> json) => new LotteryResultParam(
    param: json["param"],
    numOfTime: json["numOfTimes"],
  );

  Map<String, dynamic> toJson() => {
    "param": param,
    "numOfTimes": numOfTime
  };
}
