import 'package:bloc/bloc.dart';
import 'package:logging/logging.dart';
import 'package:myanmar_tax_calculator/src/bloc/profit_tax/bloc.dart';
import 'package:myanmar_tax_calculator/src/bloc/profit_tax/profit_service.dart';

class ProfitTaxBloc extends Bloc<ProfitEvent, ProfitState> {

  @override
  ProfitState get initialState => ProfitState.initial();

  final Logger log = new Logger('profit_tax_bloc');

  ProfitService profitService = ProfitService();

  ProfitTaxBloc();

  final Map<int, String> yearList = {
    0: '၂၀၁၄-၂၀၁၅',
    1: '၂၀၁၅-၂၀၁၆',
    2: '၂၀၁၆-၂၀၁၇',
    3: '၂၀၁၇-၂၀၁၈',
    4: '၂၀၁၈-၂၀၁၉',
  };

  @override
  Stream<ProfitState> mapEventToState(ProfitEvent event) async* {
    if (event is YearOptionChangeEvent) {
      final arr = yearList[event.yearOptionIndex].split("-");
      final sYear = arr[0];
      final eYear = arr[1];

      yield currentState.copyWith(
        yearOptionIndex: event.yearOptionIndex,
        startYear: sYear,
        endYear: eYear,
      );

      yield profitService.calculateAll(currentState);
    }

    if (event is PricingByOrgChangeEvent) {
      yield currentState.copyWith(
        pricingByOrg: event.pricingByOrg,
      );
      yield currentState.copyWith(
          sellingPrice: profitService.calculateSellingPriceAmount(currentState.inHandPricing, currentState.depreciation)
      );

      yield currentState.copyWith(
          totalAllowrance: profitService.calculateAllowranceAmount(currentState.sellingPrice, currentState.additionalValue, currentState.marketingCost)
      );


      yield currentState.copyWith(
          profit: profitService.calculateProfit(currentState.pricingByOrg, currentState.totalAllowrance)
      );

      yield currentState.copyWith(
          taxAmount: profitService.calculateTax(currentState.profit).round()
      );
    }

    if (event is InHandPricingChangeEvent) {
      yield currentState.copyWith(
        inHandPricing: event.inHandPricing,
      );

      yield currentState.copyWith(
          sellingPrice: profitService.calculateSellingPriceAmount(currentState.inHandPricing, currentState.depreciation)
      );

      yield currentState.copyWith(
          totalAllowrance: profitService.calculateAllowranceAmount(currentState.sellingPrice, currentState.additionalValue, currentState.marketingCost)
      );


      yield currentState.copyWith(
          profit: profitService.calculateProfit(currentState.pricingByOrg, currentState.totalAllowrance)
      );

      yield currentState.copyWith(
          taxAmount: profitService.calculateTax(currentState.profit).round()
      );
    }

    if (event is DepreciationChangeEvent) {
      yield currentState.copyWith(
        depreciationPricing: event.depreciationPricing,
      );
      yield currentState.copyWith(
          sellingPrice: profitService.calculateSellingPriceAmount(currentState.inHandPricing, currentState.depreciation)
      );

      yield currentState.copyWith(
          totalAllowrance: profitService.calculateAllowranceAmount(currentState.sellingPrice, currentState.additionalValue, currentState.marketingCost)
      );


      yield currentState.copyWith(
          profit: profitService.calculateProfit(currentState.pricingByOrg, currentState.totalAllowrance)
      );

      yield currentState.copyWith(
          taxAmount: profitService.calculateTax(currentState.profit).round()
      );
    }

    if (event is MarketingCostChangeEvent) {
      yield currentState.copyWith(
        marketingCost: event.marketingCost,
      );
      yield currentState.copyWith(
          sellingPrice: profitService.calculateSellingPriceAmount(currentState.inHandPricing, currentState.depreciation)
      );

      yield currentState.copyWith(
          totalAllowrance: profitService.calculateAllowranceAmount(currentState.sellingPrice, currentState.additionalValue, currentState.marketingCost)
      );


      yield currentState.copyWith(
          profit: profitService.calculateProfit(currentState.pricingByOrg, currentState.totalAllowrance)
      );

      yield currentState.copyWith(
          taxAmount: profitService.calculateTax(currentState.profit).round()
      );
    }

    if (event is AdditionalValueChangeEvent) {
      yield currentState.copyWith(
        additionalValue: event.additionalValue,
      );
      yield currentState.copyWith(
          sellingPrice: profitService.calculateSellingPriceAmount(currentState.inHandPricing, currentState.depreciation)
      );

      yield currentState.copyWith(
          totalAllowrance: profitService.calculateAllowranceAmount(currentState.sellingPrice, currentState.additionalValue, currentState.marketingCost)
      );


      yield currentState.copyWith(
          profit: profitService.calculateProfit(currentState.pricingByOrg, currentState.totalAllowrance)
      );

      yield currentState.copyWith(
          taxAmount: profitService.calculateTax(currentState.profit).round()
      );
    }

    if (event is ClearEvent) {
      yield ProfitState.initial();
    }
  }

  @override
  void onError(Object error, StackTrace stacktrace) {
    log.severe(error);
    log.severe(stacktrace);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void onTransition(Transition<ProfitEvent, ProfitState> transition) {
    log.info(transition.currentState);
    log.info(transition.event);
    log.info(transition.nextState);
  }
}

