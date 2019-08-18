

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class RentalServiceState extends Equatable {

  final int yearOptionIndex;
  final String startYear;
  final String endYear;

  final int serviceTypeOptionIndex;
  final String serviceTypeTaxDesc;
  final int tradingTaxAmount;
  final int income;
  final int expense;
  final int totalIncome;
  final int basicAllowance;
  final bool isParentAllowanceIncluded;
  final int noOfParents;
  final int maritalStatusOptionIndex;
  final int partnerJobOptionIndex;
  final int partnerAllowance;
  final int parentAllowance;
  final bool hasPartnerJob;
  final int noOfChildren;
  final int totalDeduction;
  final int income25PercentDeduction;
  final int taxableAmount;
  final int taxAmount;

  final int childrenAllowanceAmount;
  final int childrenAllowance;

  final int partnerInsurance;
  final int insurance;
  final int ssb;
  final int donation;

  RentalServiceState({
    @required this.yearOptionIndex,
    @required this.startYear,
    @required this.endYear,
    @required this.serviceTypeOptionIndex,
    @required this.serviceTypeTaxDesc,
    @required this.tradingTaxAmount,
    @required this.totalIncome,
    @required this.expense,
    @required this.basicAllowance,
    @required this.isParentAllowanceIncluded,
    @required this.noOfParents,
    @required this.maritalStatusOptionIndex,
    @required this.partnerJobOptionIndex,
    @required this.partnerAllowance,
    @required this.noOfChildren,
    @required this.totalDeduction,
    @required this.taxableAmount,
    @required this.taxAmount,
    @required this.childrenAllowanceAmount,
    @required this.income,
    @required this.hasPartnerJob,
    @required this.partnerInsurance,
    @required this.insurance,
    @required this.ssb,
    @required this.donation,
    @required this.parentAllowance,
    @required this.childrenAllowance,
    @required this.income25PercentDeduction
  }) : super([
    yearOptionIndex,
    startYear,
    endYear,
    serviceTypeOptionIndex,
    serviceTypeTaxDesc,
    tradingTaxAmount,
    totalIncome,
    expense,
    basicAllowance,
    isParentAllowanceIncluded,
    noOfParents,
    maritalStatusOptionIndex,
    partnerJobOptionIndex,
    partnerAllowance,
    noOfChildren,
    totalDeduction,
    taxableAmount,
    taxAmount,
    childrenAllowanceAmount,
    income,
    hasPartnerJob,
    partnerInsurance,
    insurance,
    ssb,
    donation,
    parentAllowance,
    childrenAllowance,
    income25PercentDeduction
  ]);

  factory RentalServiceState.initial(int yearOptionIndex, String year, int serviceTypeOptionIndex, String serviceTypeTaxDesc) {
    final arr = year.split("-")[0];
    return RentalServiceState(
      yearOptionIndex: yearOptionIndex,
      startYear: arr[0],
      endYear: arr[1],
      serviceTypeOptionIndex: serviceTypeOptionIndex,
      serviceTypeTaxDesc: serviceTypeTaxDesc,
      tradingTaxAmount: 0,
      income: 0,
      totalIncome: 0,
      basicAllowance: 0,
      isParentAllowanceIncluded: false,
      noOfParents: 0,
      maritalStatusOptionIndex: 1,
      partnerJobOptionIndex: 0,
      partnerAllowance: 0,
      noOfChildren: 0,
      totalDeduction: 0,
      taxableAmount: 0,
      taxAmount: 0,
      childrenAllowanceAmount: 0,
      expense: 0,
      hasPartnerJob: false,
      insurance: 0,
      ssb: 0,
      donation: 0,
      parentAllowance: 0,
      childrenAllowance: 0,
      partnerInsurance: 0,
      income25PercentDeduction: 0,
    );
  }

  RentalServiceState copyWith({
    int yearOptionIndex,
    String startYear,
    String endYear,
    int serviceTypeOptionIndex,
    String serviceTypeTaxDesc,
    int tradingTaxAmount,
    int income,
    int totalIncome,
    int basicAllowance,
    bool isParentAllowanceIncluded,
    int noOfParents,
    int maritalStatusOptionIndex,
    int partnerJobOptionIndex,
    int partnerAllowance,
    int noOfChildren,
    int taxableAmount,
    int totalDeduction,
    int taxAmount,
    int childrenAllowanceAmount,
    int expense,
    int isMarried,
    int hasPartnerJob,
    int insurance,
    int ssb,
    int donation,
    int parentAllowance,
    int childrenAllowance,
    int partnerInsurance,
    int income25PercentDeduction
  }) {
    return RentalServiceState(
      yearOptionIndex: yearOptionIndex ?? this.yearOptionIndex,
      startYear: startYear ?? this.startYear,
      endYear: endYear ?? this.endYear,
      serviceTypeOptionIndex: serviceTypeOptionIndex ?? this.serviceTypeOptionIndex,
      serviceTypeTaxDesc: serviceTypeTaxDesc ?? this.serviceTypeTaxDesc,
      tradingTaxAmount: tradingTaxAmount ?? this.tradingTaxAmount,
      income: income ?? this.income,
      totalIncome: totalIncome ?? this.totalIncome,
      basicAllowance: basicAllowance ?? this.basicAllowance,
      isParentAllowanceIncluded: isParentAllowanceIncluded ?? this.isParentAllowanceIncluded,
      noOfParents: noOfParents ?? this.noOfParents,
      maritalStatusOptionIndex: maritalStatusOptionIndex ?? this.maritalStatusOptionIndex,
      partnerJobOptionIndex: partnerJobOptionIndex ?? this.partnerJobOptionIndex,
      partnerAllowance: partnerAllowance ?? this.partnerAllowance,
      noOfChildren: noOfChildren ?? this.noOfChildren,
      totalDeduction: totalDeduction ?? this.totalDeduction,
      taxableAmount: taxableAmount ?? this.taxableAmount,
      taxAmount: taxAmount ?? this.taxAmount,
      childrenAllowanceAmount: childrenAllowanceAmount ?? this.childrenAllowanceAmount,
      expense: expense ?? this.expense,
      hasPartnerJob: hasPartnerJob ?? this.hasPartnerJob,
      insurance: insurance ?? this.insurance,
      ssb: ssb ?? this.ssb,
      donation: donation ?? this.donation,
      parentAllowance: parentAllowance ?? this.parentAllowance,
      childrenAllowance: childrenAllowance ?? this.childrenAllowance,
      partnerInsurance: partnerInsurance ?? this.partnerInsurance,
      income25PercentDeduction: income25PercentDeduction ?? this.income25PercentDeduction,
    );
  }

  @override
  String toString() {
    return '''ProfitState {
      yearOptionIndex: $yearOptionIndex,
      startYear: $startYear,
      endYear: $endYear,
      serviceTypeOptionIndex: $serviceTypeOptionIndex,
      serviceTypeTaxDesc: $serviceTypeTaxDesc,
      tradingTaxAmount: $tradingTaxAmount,
      income: $income,
      expense: $expense,
      totalIncome: $totalIncome,
      basicAllowance: $basicAllowance,
      isParentAllowanceIncluded: $isParentAllowanceIncluded,
      noOfParents: $noOfParents,
      maritalStatusOptionIndex: $maritalStatusOptionIndex,
      partnerJobOptionIndex: $partnerJobOptionIndex,
      partnerAllowance: $partnerAllowance,
      noOfChildren: $noOfChildren,
      totalDeduction: $totalDeduction,
      taxableAmount: $taxableAmount,
      taxAmount: $taxAmount,
      childrenAllowanceAmount: $childrenAllowanceAmount,
      hasPartnerJob: $hasPartnerJob
      insurance: $insurance
      ssb: $ssb,
      donation: $donation,
      parentAllowance: $parentAllowance,
      childrenAllowance: $childrenAllowance,
      partnerInsurance: $partnerInsurance,
      income25PercentDeduction $income25PercentDeduction
    }''';
  }
}