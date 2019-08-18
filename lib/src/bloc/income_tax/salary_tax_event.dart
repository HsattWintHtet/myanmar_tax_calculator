import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class SalaryTaxEvent extends Equatable {
  SalaryTaxEvent([List props = const []]) : super(props);
}

class YearOptionChangeEvent extends SalaryTaxEvent {
  final int selectOptionIndex;

  YearOptionChangeEvent(this.selectOptionIndex);

}

class MaritalStatusChangeEvent extends SalaryTaxEvent {
  final int maritalStatusOptionIndex;

  MaritalStatusChangeEvent(this.maritalStatusOptionIndex);
}

class IncomeTextChangeEvent extends SalaryTaxEvent {
  final int income;

  IncomeTextChangeEvent(this.income);
}

class NoOfMonthChangeEvent extends SalaryTaxEvent {
  final int noOfMonth;

  NoOfMonthChangeEvent(this.noOfMonth);
}

class BonusChangeEvent extends SalaryTaxEvent {
  final int bonus;

  BonusChangeEvent(this.bonus);
}

class PocketMoneyChangeEvent extends SalaryTaxEvent {
  final int pocketMoney;

  PocketMoneyChangeEvent(this.pocketMoney);
}

class UnderTableMoneyChangeEvent extends SalaryTaxEvent {
  final int unerTableMoney;

  UnderTableMoneyChangeEvent(this.unerTableMoney);
}

class AllowanceChangeEvent extends SalaryTaxEvent {
  final int allowance;

  AllowanceChangeEvent(this.allowance);
}

class NoOfParentChangeEvent extends SalaryTaxEvent {
  final int noOfParent;

  NoOfParentChangeEvent(this.noOfParent);
}

class PartnerAllowanceChangeEvent extends SalaryTaxEvent {
  final int partnerAllowance;

  PartnerAllowanceChangeEvent(this.partnerAllowance);
}

class InsuranceChangeEvent extends SalaryTaxEvent {
  final int insurance;

  InsuranceChangeEvent(this.insurance);
}

class SSBAmountChangeEvent extends SalaryTaxEvent {
  final int ssbAmount;

  SSBAmountChangeEvent(this.ssbAmount);
}

class DonationAmountChangeEvent extends SalaryTaxEvent {
  final int donationAmount;

  DonationAmountChangeEvent(this.donationAmount);
}

class CommissionChangeEvent extends SalaryTaxEvent {
  final int commission;

  CommissionChangeEvent(this.commission);
}

class PartnerInsuranceChangeEvent extends SalaryTaxEvent {
  final int partnerInsurance;

  PartnerInsuranceChangeEvent(this.partnerInsurance);
}

class ChildrenAllowanceChangeEvent extends SalaryTaxEvent {
  final int noOfChildren;

  ChildrenAllowanceChangeEvent(this.noOfChildren);
}

class ClearEvent extends SalaryTaxEvent {
  ClearEvent();
}

