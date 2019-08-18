import 'package:bloc/bloc.dart';
import 'package:ird_myanmar_app/src/bloc/black_income_tax/bloc.dart';
import 'package:ird_myanmar_app/src/bloc/black_income_tax/black_income_service.dart';
import 'package:ird_myanmar_app/src/ui/utils/constant_utils.dart';

class BlackIncomeTaxBloc extends Bloc<BlackIncomeEvent, BlackIncomeState> {

  @override
  BlackIncomeState get initialState => BlackIncomeState.initial(taxCalculationRules[0]);

  BlackIncomeService blackIncomeService = BlackIncomeService();

  BlackIncomeTaxBloc();

  final Map<int, String> yearList = {
    0: '၂၀၁၄-၂၀၁၅',
    1: '၂၀၁၅-၂၀၁၆',
    2: '၂၀၁၆-၂၀၁၇',
    3: '၂၀၁၇-၂၀၁၈',
    4: '၂၀၁၈-၂၀၁၉',
  };

  Map<int,List<RuleItem>> taxCalculationRules = {
    0:[
      RuleItem('၁ - ၁၀၀,၀၀၀,၀၀၀', '၃%', 1, 100000000, 3),
      RuleItem('၁၀၀,၀၀၀,၀၀၁ - ၅၀၀,၀၀၀,၀၀၀', '၅%', 100000001, 500000000, 5),
      RuleItem('၅၀၀,၀၀၀,၀၀၁ - ၁၀၀,၀၀၀,၀၀၀,၀', '၁၀%', 500000001, 1000000000, 10),
      RuleItem('၁,၀၀၀,၀၀၀,၀၀၁ - ၁,၅၀၀,၀၀၀,၀၀၀', '၂၀%', 1000000001, 1500000000, 20),
      RuleItem('၁,၅၀၀,၀၀၀,၀၀၀ နှင့်အထက်', '၃၀%', 1500000001, double.infinity, 30),
    ],
    1:[
      RuleItem('၁ - ၁၀၀,၀၀၀,၀၀၀', '၃%',1, 100000000, 3),
      RuleItem('၁၀၀,၀၀၀,၀၀၁ - ၅၀၀,၀၀၀,၀၀၀', '၅%', 100000001, 500000000, 5),
      RuleItem('၅၀၀,၀၀၀,၀၀၁ - ၁၀၀,၀၀၀,၀၀၀,၀', '၁၀%', 500000001, 1000000000, 10),
      RuleItem('၁,၀၀၀,၀၀၀,၀၀၁ - ၁,၅၀၀,၀၀၀,၀၀၀', '၂၀%', 1000000001, 1500000000, 20),
      RuleItem('၁,၅၀၀,၀၀၀,၀၀၀ နှင့်အထက်', '၃၀%', 1500000001, double.infinity, 30),
    ],
    2:[
      RuleItem('၁ - ၃၀,၀၀၀,၀၀၀', '၁၅%', 1, 30000000, 15),
      RuleItem('၃၀,၀၀၀,၀၀၁ - ၁၀၀,၀၀၀,၀၀၀', '၂၀%', 30000001, 100000000, 20),
      RuleItem('၁၀၀,၀၀၀,၀၀၁ နှင့်အထက်	', '၃၀%', 100000001, double.infinity, 30),
    ],
    3:[
      RuleItem('၁ - ၃၀,၀၀၀,၀၀၀', '၁၅%', 1, 30000000, 15),
      RuleItem('၃၀,၀၀၀,၀၀၁ - ၁၀၀,၀၀၀,၀၀၀', '၂၀%', 30000001, 100000000, 20),
      RuleItem('၁၀၀,၀၀၀,၀၀၁ နှင့်အထက်	', '၃၀%', 100000001, double.infinity, 30),
    ],
    4:[
      RuleItem('၁ - ၃၀,၀၀၀,၀၀၀', '၁၅%', 1, 30000000, 15),
      RuleItem('၃၀,၀၀၀,၀၀၁ - ၁၀၀,၀၀၀,၀၀၀', '၂၀%', 30000001, 100000000, 20),
      RuleItem('၁၀၀,၀၀၀,၀၀၁ နှင့်အထက်	', '၃၀%', 100000001, double.infinity, 30),
    ]
  };

  @override
  Stream<BlackIncomeState> mapEventToState(BlackIncomeEvent event) async* {
    if (event is YearOptionChangeEvent) {
      final arr = yearList[event.yearOptionIndex].split("-");
      final sYear = arr[0];
      final eYear = arr[1];

      yield currentState.copyWith(
        yearOptionIndex: event.yearOptionIndex,
        startYear: sYear,
        endYear: eYear,
        selectedRuleItems: taxCalculationRules[event.yearOptionIndex]
      ).copyWith(

      );
    }

    if (event is ExpenseTextChangeEvent) {
      yield currentState.copyWith(
        expense: event.expense
      );
    }

    if (event is WhiteMoneyTextChangeEvent) {
      yield currentState.copyWith(
        whiteMoney: event.whiteMoney
      );
    }

    if (event is ClearEvent) {
      yield BlackIncomeState
          .initial(taxCalculationRules[0]);
    } else {
      yield await blackIncomeService.calculateAll(currentState)
          .then((value)=>value)
          .catchError((onerror){print(onerror);});
    }
  }

  @override
  void onError(Object error, StackTrace stacktrace) {
    print(error);
    print(stacktrace);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void onTransition(Transition<BlackIncomeEvent, BlackIncomeState> transition) {
    print(transition.currentState);
    print(transition.event);
    print(transition.nextState);
  }
}

