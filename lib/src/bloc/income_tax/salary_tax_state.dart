import 'package:equatable/equatable.dart';
import 'package:myanmar_tax_calculator/src/ui/utils/constant_utils.dart';
import 'package:meta/meta.dart';

@immutable
class SalaryTaxState extends Equatable {
  final int yearOptionIndex;
  final String startYear;
  final String endYear;
  final int totalMonthlyIncome;
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
  final int bonus;
  final int pocketMoney;
  final int commission;
  final int donationAmount;
  final int ssbAmount;
  final int partnerInsurance;
  final int insurance;
  final int allowance;
  final int underTableMoney;
  final int noOfParent;
  final int noOfChildren;
  final int parentAllowance;
  final int childrenAllowance;

  SalaryTaxState({
    @required this.yearOptionIndex,
    @required this.startYear,
    @required this.endYear,
    @required this.totalMonthlyIncome,
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
    @required this.bonus,
    @required this.pocketMoney,
    @required this.commission,
    @required this.donationAmount,
    @required this.ssbAmount,
    @required this.partnerInsurance,
    @required this.insurance,
    @required this.allowance,
    @required this.underTableMoney,
    @required this.noOfParent,
    @required this.noOfChildren,
    @required this.parentAllowance,
    @required this.childrenAllowance,
  }) : super([
      yearOptionIndex,
      startYear,
      endYear,
      totalMonthlyIncome,
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
      bonus,
      pocketMoney,
      commission,
      donationAmount,
      ssbAmount,
      partnerInsurance,
      insurance,
      allowance,
      underTableMoney,
      noOfParent,
      noOfChildren,
      parentAllowance,
      childrenAllowance,
  ]);

  factory SalaryTaxState.initial(int yearOptionIndex, String year,
                          bool isParentIncluded, List<RuleItem> selectedItemRule) {
    final arr = year.split("-")[0];
    return SalaryTaxState(
      yearOptionIndex: yearOptionIndex,
      startYear: arr[0],
      endYear: arr[1],
      totalMonthlyIncome: 0,
      totalIncome: 0,
      basicAllowance: 0,
      isParentAllowanceIncluded: isParentIncluded,
      parentAllowanceRate: 0,
      maritalStatusOptionIndex: 1, // single
      partnerAllowance: 0,
      childrenAllowanceRate: 0,
      childrenAllowance: 0,
      totalReductionAmount: 0,
      taxableAmount: 0,
      totalMonth: 0,
      taxAmount: 0,
      selectedRuleItems: selectedItemRule,
      income: 0,
      noOfMonth: 0,
      bonus: 0,
      pocketMoney: 0,
      commission:0,
      donationAmount:0,
      ssbAmount:0,
      partnerInsurance:0,
      insurance:0,
      allowance:0,
      underTableMoney:0,
      noOfParent:0,
      noOfChildren:0,
    );
  }

  @override
  String toString() {
    return '''SalaryTaxState {
      yearOptionIndex: $yearOptionIndex,
      startYear: $startYear,
      endYear: $endYear,
      totalMonthlyIncome: $totalMonthlyIncome,
      totalIncome: $totalIncome,
      income: $income,
      noOfMonth: $noOfMonth,
      bonus: $bonus,
      pocketMoney: $pocketMoney,
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
      commission: $commission,
      donationAmount: $donationAmount,
      ssbAmount: $ssbAmount,
      partnerInsurance: $partnerInsurance,
      insurance: $insurance,
      allowance: $allowance,
      underTableMoney: $underTableMoney,
      noOfParent: $noOfParent,
      noOfChildren: $noOfChildren,
      parentAllowance: $parentAllowance,
      childrenAllowance: $childrenAllowance
    }''';
  }

  SalaryTaxState copyWith({
     int yearOptionIndex,
     String startYear,
     String endYear,
     int totalMonthlyIncome,
     int totalIncome,
     int basicAllowance,
     bool isParentAllowanceIncluded,
     int parentAllowanceRate,
     int maritalStatusOptionIndex,
     int partnerAllowance,
     int childrenAllowanceRate,
     int totalReductionAmount,
     int income,
     int noOfMonth,
     int bonus,
     int pocketMoney,
     int taxableAmount,
     int totalMonth,
     int taxAmount,
     List<RuleItem> selectedRuleItems,
    int commission,
    int donationAmount,
    int ssbAmount,
    int partnerInsurance,
    int insurance,
    int allowance,
    int underTableMoney,
    int noOfParent,
    int noOfChildren,
    int parentAllowance,
    int childrenAllowance,
  }) {
    return SalaryTaxState(
      yearOptionIndex: yearOptionIndex ?? this.yearOptionIndex,
      startYear: startYear ?? this.startYear,
      endYear: endYear ?? this.endYear,
      totalMonthlyIncome: totalMonthlyIncome ?? this.totalMonthlyIncome,
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
      bonus: bonus ?? this.bonus,
      pocketMoney: pocketMoney ?? this.pocketMoney,
      commission: commission ?? this.commission,
      donationAmount: donationAmount ?? this.donationAmount,
      ssbAmount: ssbAmount ?? this.ssbAmount,
      partnerInsurance: partnerInsurance ?? this.partnerInsurance,
      insurance: insurance ?? this.insurance,
      allowance: allowance ?? this.allowance,
      underTableMoney: underTableMoney ?? this.underTableMoney,
      parentAllowance: parentAllowance ?? this.parentAllowance,
      childrenAllowance: childrenAllowance ?? this.childrenAllowance,
      noOfChildren: noOfChildren ?? this.noOfChildren,
      noOfParent: noOfParent ?? this.noOfParent,
    );
  }
}
