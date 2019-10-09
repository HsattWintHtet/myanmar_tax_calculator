import 'package:logging/logging.dart';
import 'package:myanmar_tax_calculator/src/ui/utils/constant_utils.dart';

class TaxCalculator {

  final Logger log = new Logger('tax_calculator');
  
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
        log.info('item ${item.startAmount}:${item.endAmount}:${item.taxPercentage}%');
        log.info(taxEligibleAmount);
      });
    }
    return taxEligibleAmount;
  }
}