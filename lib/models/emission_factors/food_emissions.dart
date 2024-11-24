import 'package:go_green/models/emission_factors/base_emission_factors/money_emission_factor.dart';
import 'package:go_green/models/emission_factors/emission_data_enums.dart';

/// Represents types of food, beverage, or tobacco.
/// FoodType should be the same as the name of the constructor it's used with.
enum FoodType {beef, pork, fish, generalFood, beverage, dairy, sugar, tobacco}

/// Represents emissions from food, beverage, and tobacco.
class FoodEmissions extends MoneyEmissionFactor {
  /// The type of food
  final FoodType foodType;

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
        id: switch (foodType) {
          FoodType.beef => 'consumer_goods-type_meat_products_beef',
          FoodType.pork => 'consumer_goods-type_meat_products_pork',
          FoodType.fish => 'consumer_goods-type_fish_products',
          FoodType.generalFood => 'consumer_goods-type_food_products_not_elsewhere_specified',
          FoodType.beverage => 'consumer_goods-type_beverages',
          FoodType.dairy => 'consumer_goods-type_dairy_products',
          FoodType.sugar => 'consumer_goods-type_sugar',
          FoodType.tobacco => 'consumer_goods-type_tobacco_products',
        }
      );

  @override 
  String toString() {
    String result = '${super.toString()},\n';
    result += '  type: ${foodType.toString()}';
    return result;
  }
}