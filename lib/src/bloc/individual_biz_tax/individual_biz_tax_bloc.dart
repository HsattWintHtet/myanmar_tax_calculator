import 'package:bloc/bloc.dart';
import 'package:ird_myanmar_app/src/bloc/individual_biz_tax/bloc.dart';
import 'package:ird_myanmar_app/src/bloc/individual_biz_tax/IndividualBizTaxService.dart';
import 'package:ird_myanmar_app/src/ui/utils/constant_utils.dart';

class IndividualBizTaxBloc extends Bloc<IndividualBizTaxEvent, IndividualBizTaxState> {
  @override
  IndividualBizTaxState get initialState => IndividualBizTaxState.initial(0, yearList[0][0], false,
    incomeTaxRulesDesc, _businessTax[0], _bizTypeOptionTypesMap[0], _yearInfoMap[0]);

  final IndividualBizService individualBizService = IndividualBizService();


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
    0: '၂၀၁၄ ခုနှစ် ပြည်ထောင်စု၏ အခွန်အကောက်ဥပဒေပုဒ်မ ၁၁(ဂ) ပါ ကုန်စည်များနှင့် ပုဒ်မ ၁၁(စ) ပါ ဝန်ဆောင်မှုများမှအပ ရောင်းရငွေကျပ်သိန်း (၁၅၀) ကျော်လျှင် ကုန်သွယ်လုပ်ငန်းခွန် ကျသင့်သည်။',
    1: '၂၀၁၅ ခုနှစ် ပြည်ထောင်စု၏ အခွန်အကောင်ဥပဒေ ပုဒ်မ ၁၁(ဂ) ပါ ကုန်စည်များနှင့် ပုဒ်မ ၁၁(စ) ပါ ဝန်ဆောင်မှုများမှအပ ရောင်းရငွေကျပ်သိန်း (၂၀၀) ကျော်လျှင် ကုန်သွယ်လုပ်ငန်းခွန် ကျသင့်သည်။',
    2: '၂၀၁၆ ခုနှစ် ပြည်ထောင်စု၏ အခွန်အကောက်ဥပဒေပုဒ်မ ၁၄(က) ပါ ကုန်ပစ္စည်းများနှင့် ပုဒ်မ ၁၄(ဃ)ပါ ဝန်ဆောင်မှုများမှအပ ရောင်းရငွေကျပ်သိန်း (၂၀၀) ကျော်လျှင် ကုန်သွယ်လုပ်ငန်းခွန် ကျသင့်သည်။',
    3: '၂၀၁၇ ခုနှစ် ပြည်ထောင်စု၏ အခွန်အကောက်ဥပဒေပုဒ်မ ၁၄(က) ပါကုန်စည်များနှင့် ပုဒ်မ ၁၄(ဃ)ပါ ဝန်ဆောင်မှုများမှ အပ ရောင်းရငွေကျပ်သိန်း (၅၀၀) ကျော်လျှင် ကုန်သွယ်လုပ်ငန်းခွန်ကျသင့်သည်။',
  };

  final Map<int, String> _bizTypeOptionTypesMap = {
    0: '၂၀၁၄ ခုနှစ် ပြည်ထောင်စု၏ အခွန်အကောက်ဥပဒေပုဒ်မ ၁၁(ဂ) ပါ ကုန်စည်များနှင့် ပုဒ်မ ၁၁(စ) ပါ ဝန်ဆောင်မှုများ',
    1: '၂၀၁၅ ခုနှစ် ပြည်ထောင်စု၏ အခွန်အကောင်ဥပဒေ ပုဒ်မ ၁၁(ဂ) ပါ ကုန်စည်များနှင့် ပုဒ်မ ၁၁(စ) ပါ ဝန်ဆောင်မှုများ',
    2: '၂၀၁၆ ခုနှစ် ပြည်ထောင်စု၏ အခွန်အကောက်ဥပဒေပုဒ်မ ၁၄(က)ပါ ကုန်ပစ္စည်းများနှင့် ပုဒ်မ ၁၄(ဃ)ပါ ဝန်ဆောင်မှုများ',
    3: '၂၀၁၇ ခုနှစ် ပြည်ထောင်စု၏ အခွန်အကောက်ဥပဒေပုဒ်မ ၁၄(က) ပါကုန်စည်များနှင့် ပုဒ်မ ၁၄(ဃ) ပါဝန်ဆောင်မှုလုပ်ငန်းမျာ',
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

  IndividualBizTaxBloc();

  int year2015 = 0;
  int married = 0;

  @override
  Stream<IndividualBizTaxState> mapEventToState(IndividualBizTaxEvent event) async* {
    if (event is YearOptionChangeEvent) {
      final arr = yearList[event.selectOptionIndex][0].split("-");
      final sYear = arr[0];
      final eYear = arr[1];

      yield currentState.copyWith(
          yearOptionIndex: event.selectOptionIndex,
          startYear: sYear,
          endYear: eYear,
          yearTaxDesc: _yearInfoMap[event.selectOptionIndex],
          bizOptionTypeDesc: _bizTypeOptionTypesMap[event.selectOptionIndex]
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
      yield IndividualBizTaxState.initial(0, yearList[0][0], false,
          incomeTaxRulesDesc, _businessTax[0],_bizTypeOptionTypesMap[0], _yearInfoMap[0]);
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
  void onTransition(Transition<IndividualBizTaxEvent, IndividualBizTaxState> transition) {
    print(transition.currentState);
    print(transition.event);
    print(transition.nextState);
  }
}



