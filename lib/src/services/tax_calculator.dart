import 'package:ird_myanmar_app/src/ui/utils/constant_utils.dart';

class TaxCalculator {

  Future<double> calculateTax(List<RuleItem> items, double eligibleAmount) async {
    double taxEligibleAmount = 0.0;
    if(eligibleAmount > 0) {
      await items.forEach((item) {
        if (eligibleAmount >= item.startAmount && eligibleAmount >= item.endAmount) {
          taxEligibleAmount += ((1+item.endAmount-item.startAmount) * item.taxPercentage)/100;

        } else if(eligibleAmount >= item.startAmount && eligibleAmount < item.endAmount){
//          eligibleAmount += item.endAmount == double.infinity? 0:1;
          taxEligibleAmount += ((1+eligibleAmount - item.startAmount)*item.taxPercentage)/100;
        }
        print('item ${item.startAmount}:${item.endAmount}:${item.taxPercentage}%');
        print(taxEligibleAmount);
      });
    }
    return taxEligibleAmount;
  }
}