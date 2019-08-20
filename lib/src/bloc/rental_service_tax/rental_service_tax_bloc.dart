import 'package:bloc/bloc.dart';
import 'package:myanmar_tax_calculator/src/bloc/rental_service_tax/bloc.dart';
import 'package:myanmar_tax_calculator/src/bloc/rental_service_tax/rental_service.dart';

class RentalServiceBloc extends Bloc<RentalServiceEvent, RentalServiceState> {

  @override
  RentalServiceState get initialState => RentalServiceState.initial(0, yearList[0][0], 1, businessTax[1]);

  RentalService rentalService = RentalService();

  RentalServiceBloc();

  final Map<int, List> yearList = {
    0: ['၂၀၁၅-၂၀၁၆', '၁၅၀', '၂၀၁၄', 15000000],
    1: ['၂၀၁၆-၂၀၁၇', '၂၀၀', '၂၀၁၆', 20000000],
    2: ['၂၀၁၇-၂၀၁၈', '၂၀၀', '၂၀၁၅', 20000000],
    3: ['၂၀၁၈-၂၀၁၉', '၅၀၀', '၂၀၁၇', 50000000],
  };

  final Map<int, String> yearInfoMap = {
    0: '၂၀၁၄ ခုနှစ် ပြည်ထောင်စု၏ အခွန်အကောက်ဥပဒေပုဒ်မ ပုဒ်မ ၁၁(စ) စဉ်(၁) အရ ကုန်သွယ်လုပ်ငန်းခွန် မကျသင့်သော်လည်း စီးပွားဖြစ်ဌားရမ်းခြင်းဖြစ်ပါက ကုန်သွယ်လုပ်ငန်းခွန်ကျသင့်ပါမည်။',
    1: '၂၀၁၅ ခုနှစ် ပြည်ထောင်စု၏ အခွန်အကောက်ဥပဒေပုဒ်မ ပုဒ်မ ၁၁(စ) စဉ်(၁) အရ ကုန်သွယ်လုပ်ငန်းခွန် မကျသင့်သော်လည်း စီးပွားဖြစ်ဌားရမ်းခြင်းဖြစ်ပါက ကုန်သွယ်လုပ်ငန်းခွန်ကျသင့်ပါမည်။',
    2: '၂၀၁၆ ခုနှစ် ပြည်ထောင်စု၏ အခွန်အကောက်ဥပဒေ ပုဒ်မ ၁၁(ဃ) စဉ်(၁) အရ စီးပွားဖြစ်ဌားရမ်းခြင်းဖြစ်ပါက ကုန်သွယ်လုပ်ငန်းခွန် ကျသင့်ပါမည်။',
    3: '၂၀၁၇ ခုနှစ် ပြည်ထောင်စု၏ အခွန်အကောက်ဥပဒေပုဒ်မ ပုဒ်မ ၁၅ ပုဒ်မခွဲ(ခ) ပုဒ်မငယ်(၂) အရ ကျပ်သိန်း (၅၀၀) ကျော်လျှင် ကုန်သွယ်လုပ်ငန်းခွန် ကျသင့်ပါမည်။',
  };

  final Map<int, String> businessTax = {
    0: '၅% ကျသင့်ပါသည်။',
    1: 'မကျသင့်ပါ။',
  };

  int partnerAllowAmtIn2015Year = 500000;
  int partnerAllowAmtInAllYear = 1000000;

  int childrenAllowAmtIn2015Year = 300000;
  int childrenAllowAmtInAllYear = 500000;

  int yr2015 = 0;
  int married = 0;
  int noJob = 1;

  @override
  Stream<RentalServiceState> mapEventToState(RentalServiceEvent event) async* {
    if (event is YearOptionChangeEvent) {
      final arr = yearList[event.yearOptionIndex][0].split("-");
      final sYear = arr[0];
      final eYear = arr[1];

      int partnerAllowance = 0;
      int childrenAllowanceAmount = 0;
      bool isParentAllowanceIncluded = false;

      if(event.yearOptionIndex == 3) {
        yield currentState.copyWith(
          serviceTypeOptionIndex: 1,
          serviceTypeTaxDesc: businessTax[1],
        );
      }
      if(event.yearOptionIndex == 0) {
        partnerAllowance = partnerAllowAmtIn2015Year;
        childrenAllowanceAmount = childrenAllowAmtIn2015Year;
        isParentAllowanceIncluded = false;

      } else {

        partnerAllowance = partnerAllowAmtInAllYear;
        childrenAllowanceAmount = childrenAllowAmtInAllYear;
        isParentAllowanceIncluded = true;
      }
      yield currentState.copyWith(
        yearOptionIndex: event.yearOptionIndex,
        startYear: sYear,
        endYear: eYear,
        isParentAllowanceIncluded: isParentAllowanceIncluded,
        partnerAllowance: currentState.maritalStatusOptionIndex==married? partnerAllowance:0,
        childrenAllowanceAmount: childrenAllowanceAmount,
        parentAllowance: 0,
        noOfParents: 0
      );
    }

    if (event is IncomeTextChangeEvent) {
      yield currentState.copyWith(
        income: event.income,
      );
    }

    if (event is MaritalStatusChangeEvent) {
      int partnerAllowance = 0;
      if(event.maritalStatusOptionIndex == married) {
        if (currentState.yearOptionIndex == yr2015) {
          partnerAllowance = partnerAllowAmtIn2015Year;
        } else {
          partnerAllowance = partnerAllowAmtInAllYear;
        }
      }

      yield currentState.copyWith(
        maritalStatusOptionIndex: event.maritalStatusOptionIndex,
        partnerAllowance: partnerAllowance,
      );
    }

    if (event is ServiceTypeOptionChangeEvent) {
      yield currentState.copyWith(
        serviceTypeTaxDesc: businessTax[event.serviceTypeOptionIndex],
        serviceTypeOptionIndex: event.serviceTypeOptionIndex,
      );
    }

    if (event is ExpenseTextChangeEvent) {
      yield currentState.copyWith(
        expense: event.expense,
      );
    }

    if (event is ParentAllowanceTextChangeEvent) {
      yield currentState.copyWith(
        noOfParents: event.noOfParent
      );
    }

    if (event is PartnerInsuranceTextChangeEvent) {
      yield currentState.copyWith(
        partnerInsurance: event.partnerInsurance
      );
    }

    if (event is SSBAmountTextChangeEvent) {
      yield currentState.copyWith(
        ssb: event.ssbAmount
      );
    }

    if (event is DonationTextChangeEvent) {
      yield currentState.copyWith(
        donation: event.donationAmount
      );
    }

    if (event is ChildrenAllowanceTextChangeEvent) {
      yield currentState.copyWith(
        noOfChildren: event.noOfChildren
      );
    }

    if (event is InsuranceTextChangeEvent) {
      yield currentState.copyWith(
          insurance: event.insurance
      );
    }



    if (event is ClearEvent) {
      yield RentalServiceState.initial(0, yearList[0][0], 0, businessTax[0]);
    } else {
      yield await rentalService.calculateAll(currentState).then((value)=>value).catchError((onerror){print(onerror);});
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
  void onTransition(Transition<RentalServiceEvent, RentalServiceState> transition) {
    print(transition.currentState);
    print(transition.event);
    print(transition.nextState);
  }
}

