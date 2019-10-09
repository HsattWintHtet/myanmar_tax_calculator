import 'package:bloc/bloc.dart';
import 'package:logging/logging.dart';
import 'package:myanmar_tax_calculator/src/bloc/corporate/bloc.dart';
import 'package:myanmar_tax_calculator/src/bloc/corporate/corporate_service.dart';
import 'package:myanmar_tax_calculator/src/ui/utils/constant_utils.dart';

class CorporateBloc extends Bloc<CorporateEvent, CorporateState> {
  @override
  CorporateState get initialState => CorporateState.initial();

  final Logger log = new Logger('corporate_bloc');

  final CorporateService corporateService = CorporateService();

  final Map<int, String> yearList = {
    0: '၂၀၁၅-၂၀၁၆',
    1: '၂၀၁၆-၂၀၁၇',
    2: '၂၀၁၇-၂၀၁၈',
    3: '၂၀၁၈-၂၀၁၉',
  };

  final Map<int, String> corporateTypes = {
    0: 'ကုမ္ပဏီ',
    1: 'ပြည်ပနေနိုင်ငံခြားသား',
    2: 'နိုင်ငံပိုင်စီးပွားရေးအဖွဲ့အစည်းများ',
  };

  final Map<int, String> serviceTaxTypes = {
    0: 'ကုန်သွယ်လုပ်ငန်းခွန် မကျသင့်ပါ။',
    1: 'ပကုန်သွယ်လုပ်ငန်းခွန် ၅% ကျသင့်ပါသည်။',
  };



  final Map<int, String> _goodTypesMap = {
    0: '၂၀၁၄ ခုနှစ် ပြည်ထောင်စု၏ အခွန်အကောက်ဥပဒေပုဒ်မ ၁၁(ဂ) ပါ ကုန်စည်များနှင့် ပုဒ်မ ၁၁(စ) ပါ ဝန်ဆောင်မှုများ',
    1: '၂၀၁၅ ခုနှစ် ပြည်ထောင်စု၏ အခွန်အကောင်ဥပဒေ ပုဒ်မ ၁၁(ဂ) ပါ ကုန်စည်များနှင့် ပုဒ်မ ၁၁(စ) ပါ ဝန်ဆောင်မှုများ',
    2: '၂၀၁၆ ခုနှစ် ပြည်ထောင်စု၏ အခွန်အကောက်ဥပဒေပုဒ်မ ၁၄(က)ပါ ကုန်ပစ္စည်းများနှင့် ပုဒ်မ ၁၄(ဃ)ပါ ဝန်ဆောင်မှုများ',
    3: '၂၀၁၆ ခုနှစ် ပြည်ထောင်စု၏ အခွန်အကောက်ဥပဒေပုဒ်မ ၁၄(က)ပါ ကုန်ပစ္စည်းများနှင့် ပုဒ်မ ၁၄(ဃ)ပါ ဝန်ဆောင်မှုများ',
  };

  CorporateBloc();

  @override
  Stream<CorporateState> mapEventToState(CorporateEvent event) async* {
    if (event is YearOptionChangeEvent) {
      final arr = yearList[event.selectOptionIndex].split("-");
      final sYear = arr[0];
      final eYear = arr[1];

      yield currentState.copyWith(
          yearOptionIndex: event.selectOptionIndex,
          startYear: sYear,
          endYear: eYear,
          serviceTypeDesc: _goodTypesMap[event.selectOptionIndex],
          yearDesc: TaxConstantUtil.yearInfoMap[currentState.serviceTypeOptionIndex].type,
      );

    }

    if (event is ServiceTypeOptionChangeEvent) {

      yield currentState.copyWith(
        serviceTypeOptionIndex: event.serviceTypeOptionIndex,
      );

    }

    if (event is BizOptionChangeEvent) {
      yield currentState.copyWith(bizTypeOptionIndex: event.bizTypeOptionIndex);

    }

    if (event is IncomeTextChangeEvent) {
      yield currentState.copyWith(income: event.income);

    }

    if (event is ProductionCostTextChangeEvent) {
      yield currentState.copyWith(productionCost: event.productionCost);

    }

    if (event is ManagementCostTextChangeEvent) {
      yield currentState.copyWith(managementCost: event.managementCost);

    }

    if (event is DepreciationTextChangeEvent) {
      yield currentState.copyWith(depreciation: event.depreciation);


    }

    if (event is ClearEvent) {
      yield CorporateState.initial();
    } else {
      yield corporateService.calculateAll(currentState);
    }
  }

  @override
  void onError(Object error, StackTrace stacktrace) {
    log.severe(error);
    log.severe(stacktrace);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void onTransition(Transition<CorporateEvent, CorporateState> transition) {
    log.info(transition.currentState);
    log.info(transition.event);
  }
}



