import 'package:bloc/bloc.dart';
import 'package:myanmar_tax_calculator/src/bloc/income_tax/bloc.dart';
import 'package:myanmar_tax_calculator/src/bloc/income_tax/SalaryTaxService.dart';
import 'package:myanmar_tax_calculator/src/ui/utils/constant_utils.dart';

class SalaryTaxBloc extends Bloc<SalaryTaxEvent, SalaryTaxState> {
  @override
  SalaryTaxState get initialState => SalaryTaxState.initial(0, yearList[0], false, incomeTaxRulesDesc);

  final SalaryTaxService salaryTaxService = SalaryTaxService();

  final Map<int, String> yearList = {
    0: '၂၀၁၅-၂၀၁၆',
    1: '၂၀၁၆-၂၀၁၇',
    2: '၂၀၁၇-၂၀၁၈',
    3: '၂၀၁၈-၂၀၁၉',
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

  SalaryTaxBloc();

  int year2015 = 0;
  int married = 0;

  @override
  Stream<SalaryTaxState> mapEventToState(SalaryTaxEvent event) async* {
    if (event is YearOptionChangeEvent) {
      final arr = yearList[event.selectOptionIndex].split("-");
      final sYear = arr[0];
      final eYear = arr[1];

      yield currentState.copyWith(
          yearOptionIndex: event.selectOptionIndex,
          startYear: sYear,
          endYear: eYear,
      );
    }

    if (event is IncomeTextChangeEvent) {
      yield currentState.copyWith(
        income: event.income,
      );
    }

    if (event is NoOfMonthChangeEvent) {
      yield currentState.copyWith(
        noOfMonth: event.noOfMonth,
      );
    }

    if (event is BonusChangeEvent) {
      yield currentState.copyWith(
        bonus: event.bonus,
      );
    }

    if (event is PocketMoneyChangeEvent) {
      yield currentState.copyWith(
        pocketMoney: event.pocketMoney,
      );
    }

    if (event is UnderTableMoneyChangeEvent) {
      yield currentState.copyWith(
        underTableMoney: event.unerTableMoney,
      );
    }

    if (event is AllowanceChangeEvent) {
      yield currentState.copyWith(
        allowance: event.allowance,
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

    if (event is NoOfParentChangeEvent) {
      yield currentState.copyWith(
        noOfParent: event.noOfParent,
//        parentAllowanceRate: 1000000,
        isParentAllowanceIncluded: currentState.yearOptionIndex == year2015? false: true,
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
        ssbAmount: event.ssbAmount*currentState.noOfMonth,
      );
    }
    if (event is DonationAmountChangeEvent) {
      yield currentState.copyWith(
        donationAmount: event.donationAmount,
      );
    }
    if (event is CommissionChangeEvent) {
      yield currentState.copyWith(
        commission: event.commission,
      );
    }
    if (event is ChildrenAllowanceChangeEvent) {
      yield currentState.copyWith(
        noOfChildren: event.noOfChildren,
      );
    }

    if (event is ClearEvent) {
      yield SalaryTaxState.initial(0, yearList[0][0], false, incomeTaxRulesDesc);
    }
    yield await salaryTaxService.calculateAll(currentState)
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
  void onTransition(Transition<SalaryTaxEvent, SalaryTaxState> transition) {
    print(transition.currentState);
    print(transition.event);
    print(transition.nextState);
  }
}



