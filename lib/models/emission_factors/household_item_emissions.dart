import 'package:go_green/models/emission_factors/emission_data_enums.dart';
import 'package:go_green/models/emission_factors/emission_factors.dart';

enum HouseholdItemType{furniture,}

/// Represents the emissions from household items and furniture
class HouseholdItemEmissions extends EmissionFactor {
  /// The amount of money spent
  final double money;
  /// The units for money
  final MoneyUnit moneyUnit;
  /// The type of clothing
  final HouseholdItemType householdItemType;

  // API Reference: https://www.climatiq.io/data/activity/consumer_goods-type_household_furniture
  /// Creates an Emission Factor for furniture.
  /// 
  /// Parameters:
  ///  - money: the amount of money spent
  ///  - moneyUnit: the type of currency for money
  HouseholdItemEmissions.furniture({
    required this.money, 
    required this.moneyUnit
  }): householdItemType = HouseholdItemType.furniture,
      super(category: EmissionCategory.householdItems,
        id: 'consumer_goods-type_household_furniture');
  
  @override 
  String toString() {
    String result = 'type: ${householdItemType.toString()},\n';
    result += '  id: ${super.toString()},\n';
    result += '  money: $money,\n';
    result += '  money unit: ${moneyUnit.toString()}';
    return result;
  }
}