import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class IndividualBizTaxEvent extends Equatable {
  IndividualBizTaxEvent([List props = const []]) : super(props);
}

class YearOptionChangeEvent extends IndividualBizTaxEvent {
  final int selectOptionIndex;

  YearOptionChangeEvent(this.selectOptionIndex);

}

class MaritalStatusChangeEvent extends IndividualBizTaxEvent {
  final int maritalStatusOptionIndex;

  MaritalStatusChangeEvent(this.maritalStatusOptionIndex);
}

class IncomeTextChangeEvent extends IndividualBizTaxEvent {
  final int income;

  IncomeTextChangeEvent(this.income);
}

class ExpenseTextChangeEvent extends IndividualBizTaxEvent {
  final int expense;

  ExpenseTextChangeEvent(this.expense);
}

class BizOptionChangeEvent extends IndividualBizTaxEvent {
  final int bizOptionIndex;

  BizOptionChangeEvent(this.bizOptionIndex);
}

class AllowanceChangeEvent extends IndividualBizTaxEvent {
  final int allowance;

  AllowanceChangeEvent(this.allowance);
}

class NoOfParentChangeEvent extends IndividualBizTaxEvent {
  final int noOfParent;

  NoOfParentChangeEvent(this.noOfParent);
}

class PartnerAllowanceChangeEvent extends IndividualBizTaxEvent {
  final int partnerAllowance;

  PartnerAllowanceChangeEvent(this.partnerAllowance);
}

class InsuranceChangeEvent extends IndividualBizTaxEvent {
  final int insurance;

  InsuranceChangeEvent(this.insurance);
}

class SSBAmountChangeEvent extends IndividualBizTaxEvent {
  final int ssbAmount;

  SSBAmountChangeEvent(this.ssbAmount);
}

class DonationAmountChangeEvent extends IndividualBizTaxEvent {
  final int donationAmount;

  DonationAmountChangeEvent(this.donationAmount);
}

class CommissionChangeEvent extends IndividualBizTaxEvent {
  final int commission;

  CommissionChangeEvent(this.commission);
}

class PartnerInsuranceChangeEvent extends IndividualBizTaxEvent {
  final int partnerInsurance;

  PartnerInsuranceChangeEvent(this.partnerInsurance);
}

class ChildrenAllowanceChangeEvent extends IndividualBizTaxEvent {
  final int noOfChildren;

  ChildrenAllowanceChangeEvent(this.noOfChildren);
}

class ClearEvent extends IndividualBizTaxEvent {
  ClearEvent();
}

