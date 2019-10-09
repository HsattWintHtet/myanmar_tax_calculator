import 'package:event_bus/event_bus.dart';
import 'package:logging/logging.dart';
import 'package:myanmar_tax_calculator/src/model/Lottery_result_param.dart';
import 'package:myanmar_tax_calculator/src/model/lottery_result.dart';
import 'package:myanmar_tax_calculator/src/services/lottery_api_provider.dart';
import 'package:myanmar_tax_calculator/src/services/lottery_result_repo.dart';

class LotterySearchEvent {
  final LotteryResultParam param;

  LotterySearchEvent(this.param);
}

class LotteryResponseEvent {
  final LotteryResult result;

  LotteryResponseEvent(this.result);
}

class ProgressDialogEvent {
  final bool isLoading;

  ProgressDialogEvent(this.isLoading);
}

class LotteryResultPresenter {

  final Logger log = new Logger('lottery_result_presenter');

  final lotteryAPI = LotteryResultAPI();

  final lotteryRepo = LotteryResultRepository();

  final EventBus eventBus = new EventBus();

  LotteryResultPresenter() {
    _registerEvent();
  }

  void _registerEvent() {
    eventBus.on<LotterySearchEvent>().listen((event) {
      // All events are of type UserLoggedInEvent (or subtypes of it).
      log.info(event.param);
      eventBus.fire(ProgressDialogEvent(true));
      lotteryAPI.postLotteryResult(event.param).then((result) {
        log.info('result $result');
        eventBus.fire(ProgressDialogEvent(false));
        eventBus.fire(LotteryResponseEvent(result));
      }).catchError((e){
        log.severe(e.toString());
        eventBus.fire(ProgressDialogEvent(false));
        eventBus.fire(LotteryResponseEvent(new LotteryResult()));
      });
    });
  }
}