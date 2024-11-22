import 'package:go_green/models/emission_factors/emission_data_enums.dart';
import 'package:go_green/models/emission_factors/money_emission_factor.dart';

/// Represents types of furniture.
enum FurnitureType{otherFurniture, blinds, matress, officeFurniture, woodCabinet, woodCountertop, carpet}

/// Represents the emissions from household items and furniture
class FurnitureEmissions extends MoneyEmissionFactor {
  /// The type of clothing
  final FurnitureType furnitureType;

  // API Reference: https://www.climatiq.io/data/activity/consumer_goods-type_household_furniture
  /// Creates an Emission Factor for furniture.
  /// 
  /// Parameters:
  ///  - money: the amount of money spent
  ///  - moneyUnit: the type of currency for money
  FurnitureEmissions({
    required super.money, 
    required super.moneyUnit,
    required this.furnitureType
  }): super(
    category: EmissionCategory.furniture,
    id: switch (furnitureType) {
      FurnitureType.blinds => 
        'consumer_goods-type_blinds_shades_and_curtain_fixtures',
      FurnitureType.matress => 
        'consumer_goods-type_mattresses_and_foundations',
      FurnitureType.officeFurniture => 
        'consumer_goods-type_blinds_shades_and_curtain_fixtures',
      FurnitureType.woodCabinet || FurnitureType.woodCountertop => 
        'consumer_goods-type_wood_cabinets_and_counter_tops',
      FurnitureType.carpet => 
        'consumer_goods-type_carpets_rugs',
      FurnitureType.otherFurniture => 
        'consumer_goods-type_household_furniture',
    }
  );
  
  @override 
  String toString() {
    String result = '${super.toString()},\n';
    result += '  type: ${furnitureType.toString()}';
    return result;
  }
}