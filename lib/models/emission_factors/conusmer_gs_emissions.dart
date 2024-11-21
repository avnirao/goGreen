import 'package:go_green/models/emission_factors/emission_factors.dart';

/// Represents the emissions from consumer goods and services
class ConusmerGSEmissions extends EmissionFactor {
  /// The amount of this good/service purchased (money or weight, depending on type)
  final double amount;
  /// The units for the amount
  final String amountUnit;

  // HOUSEHOLD ITEMS //

  // API Reference: https://www.climatiq.io/data/activity/consumer_goods-type_household_furniture
  ConusmerGSEmissions.furniture({
    required double money, 
    required String moneyUnit
  }): amount = money,
      amountUnit = moneyUnit,
      super(id: 'consumer_goods-type_household_furniture');


  // CLOTHING //

  // API Reference: https://www.climatiq.io/data/activity/consumer_goods-type_leather_leather_products
  ConusmerGSEmissions.leatherProducts({
    required double money, 
    required String moneyUnit
  }): amount = money,
      amountUnit = moneyUnit,
      super(id: 'consumer_goods-type_leather_leather_products');

  // API Reference: https://www.climatiq.io/data/activity/consumer_goods-type_footwear
  ConusmerGSEmissions.footwear({
    required double money, 
    required String moneyUnit
  }): amount = money,
      amountUnit = moneyUnit,
      super(id: 'consumer_goods-type_footwear');

  // API Reference: https://www.climatiq.io/data/activity/consumer_goods-type_mens_womens_boys_and_girls_clothing
  ConusmerGSEmissions.newClothing({
    required double money, 
    required String moneyUnit
  }): amount = money,
      amountUnit = moneyUnit,
      super(id: 'consumer_goods-type_mens_womens_boys_and_girls_clothing');

  // API Reference: https://www.climatiq.io/data/activity/consumer_goods-type_infant_clothing
  ConusmerGSEmissions.infantClothing({
    required double money, 
    required String moneyUnit
  }): amount = money,
      amountUnit = moneyUnit,
      super(id: 'consumer_goods-type_infant_clothing');
  
  // API Reference: https://www.climatiq.io/data/activity/consumer_goods-type_clothing_reused
  /// This API call takes weight instead of money
  ConusmerGSEmissions.reusedClothing({
    required double weight, 
    required String weightUnit
  }): amount = weight,
      amountUnit = weightUnit,
      super(id: 'consumer_goods-type_clothing_reused');


  // FOOD, BEVERAGE, TOBACCO //

  // API Reference: https://www.climatiq.io/data/activity/consumer_goods-type_meat_products_beef
  ConusmerGSEmissions.beef({
    required double money, 
    required String moneyUnit
  }): amount = money,
      amountUnit = moneyUnit,
      super(id: 'consumer_goods-type_meat_products_beef');
  
  // API Reference: https://www.climatiq.io/data/activity/consumer_goods-type_meat_products_pork
  ConusmerGSEmissions.pork({
    required double money, 
    required String moneyUnit
  }): amount = money,
      amountUnit = moneyUnit,
      super(id: 'consumer_goods-type_meat_products_pork');
  
  // API Reference: https://www.climatiq.io/data/activity/consumer_goods-type_fish_products
  ConusmerGSEmissions.fish({
    required double money, 
    required String moneyUnit
  }): amount = money,
      amountUnit = moneyUnit,
      super(id: 'consumer_goods-type_fish_products');
  
  // API Reference: https://www.climatiq.io/data/activity/consumer_goods-type_food_products_not_elsewhere_specified
  ConusmerGSEmissions.generalFood({
    required double money, 
    required String moneyUnit
  }): amount = money,
      amountUnit = moneyUnit,
      super(id: 'consumer_goods-type_food_products_not_elsewhere_specified');
  
  // API Reference: https://www.climatiq.io/data/activity/consumer_goods-type_beverages
  ConusmerGSEmissions.beverage({
    required double money, 
    required String moneyUnit
  }): amount = money,
      amountUnit = moneyUnit,
      super(id: 'consumer_goods-type_beverages');
  
  // API Reference: https://www.climatiq.io/data/activity/consumer_goods-type_dairy_products
  ConusmerGSEmissions.dairy({
    required double money, 
    required String moneyUnit
  }): amount = money,
      amountUnit = moneyUnit,
      super(id: 'consumer_goods-type_dairy_products');
  
  // API Reference: https://www.climatiq.io/data/activity/consumer_goods-type_sugar
  ConusmerGSEmissions.sugar({
    required double money, 
    required String moneyUnit
  }): amount = money,
      amountUnit = moneyUnit,
      super(id: 'consumer_goods-type_sugar');
  
  // API Reference: https://www.climatiq.io/data/activity/consumer_goods-type_tobacco_products
  ConusmerGSEmissions.tobacco({
    required double money, 
    required String moneyUnit
  }): amount = money,
      amountUnit = moneyUnit,
      super(id: 'consumer_goods-type_tobacco_products');
}