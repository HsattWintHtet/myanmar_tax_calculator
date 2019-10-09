import 'package:event_bus/event_bus.dart';
import 'package:logging/logging.dart';
import 'package:myanmar_tax_calculator/src/presenter/lottery_result_presenter.dart';
import 'package:myanmar_tax_calculator/src/services/lottery_api_provider.dart';
import 'package:myanmar_tax_calculator/src/services/lottery_result_repo.dart';

class LoadResultEvent{}

class SaveResultEvent{
  final key, value;

  SaveResultEvent(this.key, this.value);
}

class SaveResultResponseEvent{
  final value;

  SaveResultResponseEvent(this.value);
}

class LoadResultResponseEvent {
  final resultList;

  LoadResultResponseEvent(this.resultList);
}

class ResultDeleteEvent {
  final sharedItem;

  ResultDeleteEvent(this.sharedItem);
}

class ResultDeleteResponseEvent {
  final sharedItem;

  ResultDeleteResponseEvent(this.sharedItem);
}

class LotteryListPresenter {

  final Logger log = new Logger('lottery_list_presenter');

  final lotteryAPI = LotteryResultAPI();

  final lotteryRepo = LotteryResultRepository();

  final EventBus eventBus = new EventBus();

  LotteryListPresenter() {
    _onLoadLotterySavedData();
  }

  void _onLoadLotterySavedData() {
    eventBus.on<LoadResultEvent>().listen((_) {
      eventBus.fire(ProgressDialogEvent(true));

      lotteryRepo.getSavedResultData().then((list) {
        log.info(list.toString());
        eventBus.fire(LoadResultResponseEvent(list));
        eventBus.fire(ProgressDialogEvent(false));
      });

    });

    eventBus.on<ResultDeleteEvent>().listen((event) {
      eventBus.fire(ProgressDialogEvent(true));

      lotteryRepo.deleteSavedResultData(event.sharedItem.numOfTimes).then((list){
        eventBus.fire(ResultDeleteResponseEvent(event.sharedItem));
        eventBus.fire(ProgressDialogEvent(false));
      });
    });

    eventBus.on<SaveResultEvent>().listen((event) {
      eventBus.fire(ProgressDialogEvent(true));

      lotteryRepo.savedResultData(event.key, event.value).then((value) {
        eventBus.fire(ProgressDialogEvent(false));
        if(value) {
          eventBus.fire(SaveResultResponseEvent('Successfully saved (${event.value})'));
        } else {
          eventBus.fire(SaveResultResponseEvent('Failed to saved (${event.value})'));
        }

      });
    });
  }
}