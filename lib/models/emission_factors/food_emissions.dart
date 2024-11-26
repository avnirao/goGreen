import 'package:go_green/models/emission_data/emission_subtypes.dart';
import 'package:go_green/models/emission_factors/base_emission_factors/money_emission_factor.dart';
import 'package:go_green/models/emission_data/emission_data_enums.dart';

/// Represents types of food, beverage, or tobacco.
/// FoodType should be the same as the name of the constructor it's used with.
// enum FoodType {beef, pork, fish, otherFood, beverage, dairy, sugar, tobacco}

class FoodTypeTest {
  final String beefDisplayName = 'Beef';
  final String beefId = 'consumer_goods-type_meat_products_beef';
}

/// Represents emissions from food, beverage, and tobacco.
class FoodEmissions extends MoneyEmissionFactor {
  /// The type of food
  final String foodType;

  /// Creates an Emission Factor for food, beverage, or tobacco.
  /// 
  /// Parameters:
  ///  - money: the amount of money spent
  ///  - moneyUnit: the type of currency for money
  ///  - foodType: the type of food/beverage/tobacco
  FoodEmissions({
    required super.money, 
    required super.moneyUnit, 
    required this.foodType
  }): super(
        category: EmissionCategory.food,
        id: EmissionSubtypes().foodTypes[foodType] ?? 'type not found'
      );

  @override 
  String toString() {
    String result = '${super.toString()},\n';
    result += '  type: ${foodType.toString()}';
    return result;
  }
}