import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class CorporateState extends Equatable {
  final int yearOptionIndex;

  final int bizTypeOptionIndex;
  final int serviceTypeOptionIndex;

  final int income;
  final int amountNotIncludedInServiceTax;
  final int productionCost;
  final int basicProfit;
  final int managementCost;
  final int depreciation;
  final int netProfit;
  final int taxAmount;

  // for show
  final String startYear;
  final String endYear;
  final String serviceTypeDesc;
  final String yearDesc;
  final String serviceTypeTaxDesc;

  final int amountOfServiceTax;
  final int taxPercentageOfServiceTax;

  CorporateState({
    @required this.yearOptionIndex,
    @required this.startYear,
    @required this.endYear,
    @required this.bizTypeOptionIndex,
    @required this.serviceTypeOptionIndex,
    @required this.income,
    @required this.amountNotIncludedInServiceTax,
    @required this.productionCost,
    @required this.basicProfit,
    @required this.managementCost,
    @required this.depreciation,
    @required this.netProfit,
    @required this.taxAmount,
    @required this.serviceTypeDesc,
    @required this.yearDesc,
    @required this.serviceTypeTaxDesc,
    @required this.amountOfServiceTax,
    @required this.taxPercentageOfServiceTax,
  }) : super([
          yearOptionIndex,
          startYear,
          endYear,
          bizTypeOptionIndex,
          serviceTypeOptionIndex,
          income,
          amountNotIncludedInServiceTax,
          productionCost,
          basicProfit,
          managementCost,
          depreciation,
          netProfit,
          taxAmount,
          serviceTypeDesc,
          yearDesc,
          serviceTypeTaxDesc,
          amountOfServiceTax,
          taxPercentageOfServiceTax,
        ]);

  factory CorporateState.initial() {
    return CorporateState(
      yearOptionIndex: 0,
      startYear: '၂၀၁၅',
      endYear: '၂၀၁၆',
      bizTypeOptionIndex: 0,
      serviceTypeOptionIndex: 0,
      income: 0,
      amountNotIncludedInServiceTax: 0,
      productionCost: 0,
      basicProfit: 0,
      managementCost: 0,
      depreciation: 0,
      netProfit: 0,
      taxAmount: 0,
      serviceTypeDesc:
          '၂၀၁၄ ခုနှစ် ပြည်ထောင်စု၏ အခွန်အကောက်ဥပဒေပုဒ်မ ၁၁(ဂ) ပါ ကုန်စည်များနှင့် ပုဒ်မ ၁၁(စ) ပါ ဝန်ဆောင်မှုများ',
      yearDesc:
          '၂၀၁၄ ခုနှစ် ပြည်ထောင်စု၏ အခွန်အကောက်ဥပဒေပုဒ်မ ၁၁(ဂ) ပါ ကုန်စည်များနှင့် ပုဒ်မ ၁၁(စ) ပါ ဝန်ဆောင်မှုများမှ အပရောင်းရငွေကျပ်သိန်း (၁၅၀) ကျော်လျှင် ကုန်သွယ်လုပ်ငန်းခွန် ကျသင့်သည်။',
      serviceTypeTaxDesc: 'ကုန်သွယ်လုပ်ငန်းခွန် မကျသင့်ပါ။',
      amountOfServiceTax: 0,
      taxPercentageOfServiceTax: 0,
    );
  }

  CorporateState copyWith({
    int yearOptionIndex,
    String startYear,
    String endYear,
    int bizTypeOptionIndex,
    int serviceTypeOptionIndex,
    int income,
    int amountNotIncludedInServiceTax,
    int productionCost,
    int basicProfit,
    int managementCost,
    int depreciation,
    int netProfit,
    int taxAmount,
    String serviceTypeDesc,
    String yearDesc,
    String serviceTypeTaxDesc,
    int amountOfServiceTax,
    int taxPercentageOfServiceTax,
  }) {
    print('copywith netprofit $netProfit, basicProfit $basicProfit, taxAmount: $taxAmount');
    return CorporateState(
      yearOptionIndex: yearOptionIndex ?? this.yearOptionIndex,
      startYear: startYear ?? this.startYear,
      endYear: endYear ?? this.endYear,
      bizTypeOptionIndex: bizTypeOptionIndex ?? this.bizTypeOptionIndex,
      serviceTypeOptionIndex:
          serviceTypeOptionIndex ?? this.serviceTypeOptionIndex,
      income: income ?? this.income,
      amountNotIncludedInServiceTax:
          amountNotIncludedInServiceTax ?? this.amountNotIncludedInServiceTax,
      productionCost: productionCost ?? this.productionCost,
      basicProfit: basicProfit ?? this.basicProfit,
      managementCost: managementCost ?? this.managementCost,
      depreciation: depreciation ?? this.depreciation,
      netProfit: netProfit ?? this.netProfit,
      taxAmount: taxAmount ?? this.taxAmount,
      serviceTypeDesc: serviceTypeDesc ?? this.serviceTypeDesc,
      yearDesc: yearDesc ?? this.yearDesc,
      serviceTypeTaxDesc: serviceTypeTaxDesc ?? this.serviceTypeTaxDesc,
      amountOfServiceTax: amountOfServiceTax ?? this.amountOfServiceTax,
      taxPercentageOfServiceTax:
          taxPercentageOfServiceTax ?? this.taxPercentageOfServiceTax,
    );
  }

  @override
  String toString() {
    return '''CorporateState {
      yearOptionIndex: $yearOptionIndex,
      startYear: $startYear,
      endYear: $endYear,
      bizTypeOptionIndex: $bizTypeOptionIndex,
      serviceTypeOptionIndex:
          $serviceTypeOptionIndex,
      income: $income,
      amountNotIncludedInServiceTax:
          $amountNotIncludedInServiceTax,
      productionCost: $productionCost,
      basicProfit: $basicProfit,
      managementCost: $managementCost,
      depreciation: $depreciation,
      netProfit: $netProfit,
      taxAmount: $taxAmount,
      serviceTypeDesc: $serviceTypeDesc,
      yearDesc: $yearDesc,
      serviceTypeTaxDesc: $serviceTypeTaxDesc,
      amountOfServiceTax: $amountOfServiceTax,
      taxPercentageOfServiceTax:
          $taxPercentageOfServiceTax
    }''';
  }
}
