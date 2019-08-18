import 'package:bloc/bloc.dart';
import 'package:ird_myanmar_app/src/bloc/thet_mawe_tax/bloc.dart';
import 'package:ird_myanmar_app/src/bloc/thet_mawe_tax/ThetMaweBizTaxService.dart';
import 'package:ird_myanmar_app/src/ui/utils/constant_utils.dart';

class ThetMaweBizTaxBloc extends Bloc<ThetMaweBizTaxEvent, ThetMaweBizTaxState> {
  @override
  ThetMaweBizTaxState get initialState => ThetMaweBizTaxState.initial(0, yearList[0][0], false,
    incomeTaxRulesDesc, _businessTax[0], _yearInfoMap[0]);

  final ThetMaweBizService individualBizService = ThetMaweBizService();


  final Map<int, List> yearList = {
    0: ['၂၀၁၅-၂၀၁၆', '၁၅၀', '၂၀၁၄', 15000000],
    1: ['၂၀၁၆-၂၀၁၇', '၂၀၀', '၂၀၁၆', 20000000],
    2: ['၂၀၁၇-၂၀၁၈', '၂၀၀', '၂၀၁၅', 20000000],
    3: ['၂၀၁၈-၂၀၁၉', '၅၀၀', '၂၀၁၇', 50000000],
  };

  final Map<int, String> _businessTax = {
    0: 'မကျသင့်ပါ။',
    1: '၅% ကျသင့်ပါသည်။'
  };

  final Map<int, String> _yearInfoMap = {
    0: 'ပညာရေး၊ ကျန်းမာရေး၊ အနုပညာမှအပ ကျန်လုပ်ငန်းများ ကျပ်သိန်း ၁၅၀ ကျော်လျှင် ၅% ကုန်သွယ်ခွန်ကျ (၂၀၁၄ ခုနှစ် ပြည်ထောင်စု၏ အခွန်အကောက်ဥပဒေအရ)',
    1: 'ပညာရေး၊ ကျန်းမာရေး၊ အနုပညာမှအပ ကျန်လုပ်ငန်းများ ကျပ်သိန်း ၂၀၀ ကျော်လျှင် ၅% ကုန်သွယ်ခွန်ကျ (၂၀၁၆ ခုနှစ် ပြည်ထောင်စု၏ အခွန်အကောက်ဥပဒေအရ)',
    2: 'ပညာရေး၊ ကျန်းမာရေး၊ အနုပညာမှအပ ကျန်လုပ်ငန်းများ ကျပ်သိန်း ၂၀၀ ကျော်လျှင် ၅% ကုန်သွယ်ခွန်ကျ (၂၀၁၅ ခုနှစ် ပြည်ထောင်စု၏ အခွန်အကောက်ဥပဒေအရ)',
    3: 'ပညာရေး၊ ကျန်းမာရေး၊ အနုပညာမှအပ ကျန်လုပ်ငန်းများ ကျပ်သိန်း ၅၀၀ ကျော်လျှင် ၅% ကုန်သွယ်ခွန်ကျ (၂၀၁၇ ခုနှစ် ပြည်ထောင်စု၏ အခွန်အကောက်ဥပဒေအရ)',
  };

  // based on 2014 rule. It is for show.
  List<RuleItem> incomeTaxRulesDesc = [
    RuleItem('၁ မှ ၂,၀၀၀,၀၀၀ ထိ', '၀%', 1, 2000000, 0),
    RuleItem('၂,၀၀၀,၀၀၁ မှ ၅,၀၀၀,၀၀၀ ထိ', '၅%', 2000001, 5000000, 5),
    RuleItem('၅,၀၀၀,၀၀၁ မှ ၁၀,၀၀၀,၀၀၀ ထိ', '၁၀%', 5000001, 10000000, 10),
    RuleItem('၁၀,၀၀၀,၀၀၁ မှ ၂၀,၀၀၀,၀၀၀ ထိ', '၁၅%', 10000001, 20000000, 15),
    RuleItem('၂၀,၀၀၀,၀၀၁ မှ ၃၀,၀၀၀,၀၀၀ ထိ', '၂၀%', 20000001, 30000000, 20),
    RuleItem('၃၀,၀၀၀,၀၀၁ နှင့်အထက်', '၂၅%', 30000001, double.infinity, 25),
  ];

  ThetMaweBizTaxBloc();

  int year2015 = 0;
  int married = 0;

  @override
  Stream<ThetMaweBizTaxState> mapEventToState(ThetMaweBizTaxEvent event) async* {
    if (event is YearOptionChangeEvent) {
      final arr = yearList[event.selectOptionIndex][0].split("-");
      final sYear = arr[0];
      final eYear = arr[1];

      yield currentState.copyWith(
          yearOptionIndex: event.selectOptionIndex,
          startYear: sYear,
          endYear: eYear,
          yearTaxDesc: _yearInfoMap[event.selectOptionIndex],
      );
    }

    if (event is IncomeTextChangeEvent) {
      yield currentState.copyWith(
        income: event.income,
      );
    }

    if (event is BizOptionChangeEvent) {
      yield currentState.copyWith(
        bizTypeOptionIndex: event.bizOptionIndex,
      );
    }

    if (event is ExpenseTextChangeEvent) {
      yield currentState.copyWith(
        expense: event.expense,
      );
    }
    if (event is MaritalStatusChangeEvent) {
      int partnerAllowance = 0;
      if(event.maritalStatusOptionIndex == married) {
        partnerAllowance = currentState.yearOptionIndex == year2015? 500000: 1000000;
      }
      yield currentState.copyWith(
        maritalStatusOptionIndex: event.maritalStatusOptionIndex,
        partnerAllowance: partnerAllowance,
      );
    }

    if (event is ChildrenAllowanceChangeEvent) {
      yield currentState.copyWith(
        noOfChildren: event.noOfChildren,
      );
    }

    if (event is PartnerInsuranceChangeEvent) {
      yield currentState.copyWith(
        partnerInsurance: event.partnerInsurance,
      );
    }
    if (event is InsuranceChangeEvent) {
      yield currentState.copyWith(
        insurance: event.insurance,
      );
    }
    if (event is SSBAmountChangeEvent) {
      yield currentState.copyWith(
        ssbAmount: event.ssbAmount,
      );
    }
    if (event is DonationAmountChangeEvent) {
      yield currentState.copyWith(
        donationAmount: event.donationAmount,
      );
    }
    if (event is NoOfParentChangeEvent) {
      yield currentState.copyWith(
        noOfParent: event.noOfParent,
//        parentAllowanceRate: 1000000,
        isParentAllowanceIncluded: currentState.yearOptionIndex == year2015? false: true,
      );
    }

    if (event is ClearEvent) {
      yield ThetMaweBizTaxState.initial(0, yearList[0][0], false,
          incomeTaxRulesDesc, _businessTax[0], _yearInfoMap[0]);
    }

    yield await individualBizService.calculateAll(currentState)
        .then((value)=>value)
        .catchError((onerror){print(onerror);});
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
  void onTransition(Transition<ThetMaweBizTaxEvent, ThetMaweBizTaxState> transition) {
    print(transition.currentState);
    print(transition.event);
    print(transition.nextState);
  }
}



