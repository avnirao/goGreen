import 'package:go_green/models/emission_data/emission_data_enums.dart';
import 'package:go_green/models/emission_data/emission_subtypes.dart';
import 'package:go_green/models/emission_factors/base_emission_factors/money_emission_factor.dart';

/// Represents types of furniture.
// enum FurnitureType{otherFurniture, blinds, matress, officeFurniture, woodCabinet, woodCountertop, carpet}

/// Represents the emissions from household items and furniture
class FurnitureEmissions extends MoneyEmissionFactor {
  /// The type of clothing
  final String furnitureType;

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
    id: EmissionSubtypes().furnitureTypes[furnitureType] ?? 'type not found'
  );
  
  @override 
  String toString() {
    String result = '${super.toString()},\n';
    result += '  type: ${furnitureType.toString()}';
    return result;
  }
}