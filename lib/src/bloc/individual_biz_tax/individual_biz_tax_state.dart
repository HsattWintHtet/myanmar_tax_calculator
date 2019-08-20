import 'package:equatable/equatable.dart';
import 'package:myanmar_tax_calculator/src/ui/utils/constant_utils.dart';
import 'package:meta/meta.dart';

@immutable
class IndividualBizTaxState extends Equatable {
  final int yearOptionIndex;
  final String startYear;
  final String endYear;
  final int totalIncome;
  final int basicAllowance;
  final bool isParentAllowanceIncluded;
  final int parentAllowanceRate;
  final int maritalStatusOptionIndex;
  final int partnerAllowance;
  final int childrenAllowanceRate;
  final int totalReductionAmount;
  final int taxableAmount;
  final int totalMonth;
  final int taxAmount;
  final List<RuleItem> selectedRuleItems;
  final int income;
  final int noOfMonth;
  final int donationAmount;
  final int ssbAmount;
  final int partnerInsurance;
  final int insurance;
  final int noOfParent;
  final int noOfChildren;
  final int parentAllowance;
  final int childrenAllowance;
  final int bizTypeOptionIndex;
  final String yearTaxDesc;
  final String bizOptionTypeDesc;
  final String serviceTypeTaxDesc;
  final int tradingTaxAmount;
  final int expense;

  IndividualBizTaxState({
    @required this.yearOptionIndex,
    @required this.startYear,
    @required this.endYear,
    @required this.totalIncome,
    @required this.basicAllowance,
    @required this.isParentAllowanceIncluded,
    @required this.parentAllowanceRate,
    @required this.maritalStatusOptionIndex,
    @required this.partnerAllowance,
    @required this.childrenAllowanceRate,
    @required this.totalReductionAmount,
    @required this.taxableAmount,
    @required this.totalMonth,
    @required this.taxAmount,
    @required this.selectedRuleItems,
    @required this.income,
    @required this.noOfMonth,
    @required this.donationAmount,
    @required this.ssbAmount,
    @required this.partnerInsurance,
    @required this.insurance,
    @required this.noOfParent,
    @required this.noOfChildren,
    @required this.parentAllowance,
    @required this.childrenAllowance,
    @required this.bizTypeOptionIndex,
    @required this.yearTaxDesc,
    @required this.bizOptionTypeDesc,
    @required this.serviceTypeTaxDesc,
    @required this.tradingTaxAmount,
    @required this.expense,
  }) : super([
      yearOptionIndex,
      startYear,
      endYear,
      totalIncome,
      basicAllowance,
      isParentAllowanceIncluded,
      parentAllowanceRate,
      maritalStatusOptionIndex,
      partnerAllowance,
      childrenAllowanceRate,
      totalReductionAmount,
      taxableAmount,
      totalMonth,
      taxAmount,
      selectedRuleItems,
      income,
      noOfMonth,
      donationAmount,
      ssbAmount,
      partnerInsurance,
      insurance,
      noOfParent,
      noOfChildren,
      parentAllowance,
      childrenAllowance,
      bizTypeOptionIndex,
      yearTaxDesc,
      bizOptionTypeDesc,
      serviceTypeTaxDesc,
      tradingTaxAmount,
      expense
  ]);

  factory IndividualBizTaxState.initial(int yearOptionIndex, String year,
                          bool isParentIncluded, List<RuleItem> selectedItemRule,
                          String serviceTypeTaxDesc, String bizOptionTypeDesc,
                          String yearTaxDesc) {
    final arr = year.split("-")[0];
    return IndividualBizTaxState(
      yearOptionIndex: yearOptionIndex,
      startYear: arr[0],
      endYear: arr[1],
      totalIncome: 0,
      basicAllowance: 0,
      isParentAllowanceIncluded: isParentIncluded,
      parentAllowanceRate: 0,
      maritalStatusOptionIndex: 1, // single
      partnerAllowance: 0,
      childrenAllowanceRate: 0,
      totalReductionAmount: 0,
      taxableAmount: 0,
      totalMonth: 0,
      taxAmount: 0,
      selectedRuleItems: selectedItemRule,
      income: 0,
      noOfMonth: 0,
      donationAmount:0,
      ssbAmount:0,
      partnerInsurance:0,
      insurance:0,
      noOfParent:0,
      noOfChildren:0,
      bizTypeOptionIndex:0,
      yearTaxDesc: yearTaxDesc,
      bizOptionTypeDesc: bizOptionTypeDesc,
      serviceTypeTaxDesc: serviceTypeTaxDesc,
      tradingTaxAmount: 0,
      expense: 0,
    );
  }

  @override
  String toString() {
    return '''SalaryTaxState {
      yearOptionIndex: $yearOptionIndex,
      startYear: $startYear,
      endYear: $endYear,
      totalIncome: $totalIncome,
      income: $income,
      noOfMonth: $noOfMonth,
      basicAllowance: $basicAllowance,
      isParentAllowanceIncluded: $isParentAllowanceIncluded,
      parentAllowance: $parentAllowanceRate,
      maritalStatusOptionIndex: $maritalStatusOptionIndex,
      partnerAllowance: $partnerAllowance,
      childrenAllowance: $childrenAllowanceRate,
      totalReductionAmount: $totalReductionAmount,
      taxableAmount: $taxableAmount,
      totalMonth: $totalMonth,
      taxAmount: $taxAmount,
      selectedRuleItems: $selectedRuleItems
      donationAmount: $donationAmount,
      ssbAmount: $ssbAmount,
      partnerInsurance: $partnerInsurance,
      insurance: $insurance,
      noOfParent: $noOfParent,
      noOfChildren: $noOfChildren,
      parentAllowance: $parentAllowance,
      childrenAllowance: $childrenAllowance,
      bizTypeOptionIndex: $bizTypeOptionIndex,
      yearTaxDesc: $yearTaxDesc
      bizOptionTypeDesc: $bizOptionTypeDesc,
      serviceTypeTaxDesc: $serviceTypeTaxDesc,
      tradingTaxAmount: $tradingTaxAmount,
      expense: $expense,
      bizTypeOptionIndex: $bizTypeOptionIndex
    }''';
  }

  IndividualBizTaxState copyWith({
     int yearOptionIndex,
     String startYear,
     String endYear,
     int totalIncome,
     int basicAllowance,
     bool isParentAllowanceIncluded,
     int parentAllowanceRate,
     int maritalStatusOptionIndex,
     int partnerAllowance,
     int childrenAllowanceRate,
     int totalReductionAmount,
     int income,
     int taxableAmount,
     int totalMonth,
     int taxAmount,
     List<RuleItem> selectedRuleItems,
    int donationAmount,
    int ssbAmount,
    int partnerInsurance,
    int insurance,
    int noOfParent,
    int noOfChildren,
    int parentAllowance,
    int childrenAllowance,
    int bizTypeOptionIndex,
    String yearTaxDesc,
    String bizOptionTypeDesc,
    String serviceTypeTaxDesc,
    int tradingTaxAmount,
    int expense,
  }) {
    return IndividualBizTaxState(
      yearOptionIndex: yearOptionIndex ?? this.yearOptionIndex,
      startYear: startYear ?? this.startYear,
      endYear: endYear ?? this.endYear,
      totalIncome: totalIncome ?? this.totalIncome,
      basicAllowance: basicAllowance ?? this.basicAllowance,
      isParentAllowanceIncluded: isParentAllowanceIncluded ?? this.isParentAllowanceIncluded,
      parentAllowanceRate: parentAllowanceRate ?? this.parentAllowanceRate,
      maritalStatusOptionIndex: maritalStatusOptionIndex ?? this.maritalStatusOptionIndex,
      partnerAllowance: partnerAllowance ?? this.partnerAllowance,
      childrenAllowanceRate: childrenAllowanceRate ?? this.childrenAllowanceRate,
      totalReductionAmount: totalReductionAmount ?? this.totalReductionAmount,
      taxableAmount: taxableAmount ?? this.taxableAmount,
      totalMonth: totalMonth ?? this.totalMonth,
      taxAmount: taxAmount ?? this.taxAmount,
      selectedRuleItems: selectedRuleItems ?? this.selectedRuleItems,
      income: income ?? this.income,
      noOfMonth: noOfMonth ?? this.noOfMonth,
      donationAmount: donationAmount ?? this.donationAmount,
      ssbAmount: ssbAmount ?? this.ssbAmount,
      partnerInsurance: partnerInsurance ?? this.partnerInsurance,
      insurance: insurance ?? this.insurance,
      parentAllowance: parentAllowance ?? this.parentAllowance,
      childrenAllowance: childrenAllowance ?? this.childrenAllowance,
      noOfChildren: noOfChildren ?? this.noOfChildren,
      noOfParent: noOfParent ?? this.noOfParent,
      bizTypeOptionIndex: bizTypeOptionIndex ?? this.bizTypeOptionIndex,
      yearTaxDesc: yearTaxDesc ?? this.yearTaxDesc,
      bizOptionTypeDesc: bizOptionTypeDesc ?? this.bizOptionTypeDesc,
      serviceTypeTaxDesc: serviceTypeTaxDesc ?? this.serviceTypeTaxDesc,
      tradingTaxAmount: tradingTaxAmount ?? this.tradingTaxAmount,
      expense: expense ?? this.expense
    );
  }
}
