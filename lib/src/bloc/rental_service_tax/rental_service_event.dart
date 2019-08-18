
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RentalServiceEvent extends Equatable {
  RentalServiceEvent([List props = const []]) : super(props);
}

class YearOptionChangeEvent extends RentalServiceEvent{
  final yearOptionIndex;

  YearOptionChangeEvent(this.yearOptionIndex);
}

class ServiceTypeOptionChangeEvent extends RentalServiceEvent{
  final serviceTypeOptionIndex;

  ServiceTypeOptionChangeEvent(this.serviceTypeOptionIndex);
}

class IncomeTextChangeEvent extends RentalServiceEvent{
  final income;

  IncomeTextChangeEvent(this.income);
}

class ExpenseTextChangeEvent extends RentalServiceEvent{
  final expense;

  ExpenseTextChangeEvent(this.expense);
}

class ParentAllowanceTextChangeEvent extends RentalServiceEvent{
  final noOfParent;

  ParentAllowanceTextChangeEvent(this.noOfParent);
}

class MaritalStatusChangeEvent extends RentalServiceEvent{
  final maritalStatusOptionIndex;

  MaritalStatusChangeEvent(this.maritalStatusOptionIndex);
}

class ChildrenAllowanceTextChangeEvent extends RentalServiceEvent{
  final noOfChildren;

  ChildrenAllowanceTextChangeEvent(this.noOfChildren);
}

class SSBAmountTextChangeEvent extends RentalServiceEvent{
  final ssbAmount;

  SSBAmountTextChangeEvent(this.ssbAmount);
}

class InsuranceTextChangeEvent extends RentalServiceEvent{
  final insurance;

  InsuranceTextChangeEvent(this.insurance);
}

class PartnerInsuranceTextChangeEvent extends RentalServiceEvent{
  final partnerInsurance;

  PartnerInsuranceTextChangeEvent(this.partnerInsurance);
}

class DonationTextChangeEvent extends RentalServiceEvent{
  final donationAmount;

  DonationTextChangeEvent(this.donationAmount);
}


class ClearEvent extends RentalServiceEvent {
  ClearEvent();
}