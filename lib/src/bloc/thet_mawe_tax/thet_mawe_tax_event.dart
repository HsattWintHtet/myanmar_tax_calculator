import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class ThetMaweBizTaxEvent extends Equatable {
  ThetMaweBizTaxEvent([List props = const []]) : super(props);
}

class YearOptionChangeEvent extends ThetMaweBizTaxEvent {
  final int selectOptionIndex;

  YearOptionChangeEvent(this.selectOptionIndex);

}

class MaritalStatusChangeEvent extends ThetMaweBizTaxEvent {
  final int maritalStatusOptionIndex;

  MaritalStatusChangeEvent(this.maritalStatusOptionIndex);
}

class IncomeTextChangeEvent extends ThetMaweBizTaxEvent {
  final int income;

  IncomeTextChangeEvent(this.income);
}

class ExpenseTextChangeEvent extends ThetMaweBizTaxEvent {
  final int expense;

  ExpenseTextChangeEvent(this.expense);
}

class BizOptionChangeEvent extends ThetMaweBizTaxEvent {
  final int bizOptionIndex;

  BizOptionChangeEvent(this.bizOptionIndex);
}

class AllowanceChangeEvent extends ThetMaweBizTaxEvent {
  final int allowance;

  AllowanceChangeEvent(this.allowance);
}

class NoOfParentChangeEvent extends ThetMaweBizTaxEvent {
  final int noOfParent;

  NoOfParentChangeEvent(this.noOfParent);
}

class PartnerAllowanceChangeEvent extends ThetMaweBizTaxEvent {
  final int partnerAllowance;

  PartnerAllowanceChangeEvent(this.partnerAllowance);
}

class InsuranceChangeEvent extends ThetMaweBizTaxEvent {
  final int insurance;

  InsuranceChangeEvent(this.insurance);
}

class SSBAmountChangeEvent extends ThetMaweBizTaxEvent {
  final int ssbAmount;

  SSBAmountChangeEvent(this.ssbAmount);
}

class DonationAmountChangeEvent extends ThetMaweBizTaxEvent {
  final int donationAmount;

  DonationAmountChangeEvent(this.donationAmount);
}

class CommissionChangeEvent extends ThetMaweBizTaxEvent {
  final int commission;

  CommissionChangeEvent(this.commission);
}

class PartnerInsuranceChangeEvent extends ThetMaweBizTaxEvent {
  final int partnerInsurance;

  PartnerInsuranceChangeEvent(this.partnerInsurance);
}

class ChildrenAllowanceChangeEvent extends ThetMaweBizTaxEvent {
  final int noOfChildren;

  ChildrenAllowanceChangeEvent(this.noOfChildren);
}

class ClearEvent extends ThetMaweBizTaxEvent {
  ClearEvent();
}

