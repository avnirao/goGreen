import 'package:go_green/models/emission_factors/emission_data_enums.dart';
import 'package:go_green/models/emission_factors/emission_factors.dart';

/// Represents types of clothing.
/// ClothingType should be the same as the name of the constructor it's used with.
enum ClothingType {leather, footwear, newClothing, usedClothing, infantClothing}

/// Represents the emissions from clothing
class ClothingEmissions extends EmissionFactor {
  /// The amount of clothing acquired (money or weight, depending on type)
  final double _amount;
  /// The units for money
  final MoneyUnit? _moneyUnit;
  /// The units for weight
  final WeightUnit? _weightUnit;
  /// The type of clothing
  final ClothingType _clothingType;

  // API Reference: https://www.climatiq.io/data/activity/consumer_goods-type_leather_leather_products
  /// Creates an Emission Factor for leather products.
  /// 
  /// Parameters:
  ///  - money: the amount of money spent
  ///  - moneyUnit: the type of currency for money
  ClothingEmissions.leather ({
    required double money, 
    required MoneyUnit moneyUnit
  }): _amount = money,
      _moneyUnit = moneyUnit,
      _weightUnit = null,
      _clothingType = ClothingType.leather,
      super(category: EmissionCategory.clothing,
        id: 'consumer_goods-type_leather_leather_products');

  // API Reference: https://www.climatiq.io/data/activity/consumer_goods-type_footwear
  /// Creates an Emission Factor for footwear.
  /// 
  /// Parameters:
  ///  - money: the amount of money spent
  ///  - moneyUnit: the type of currency for money
  ClothingEmissions.footwear({
    required double money, 
    required MoneyUnit moneyUnit
  }): _amount = money,
      _moneyUnit = moneyUnit,
      _weightUnit = null,
      _clothingType = ClothingType.footwear,
      super(category: EmissionCategory.clothing,
        id: 'consumer_goods-type_footwear');

  // API Reference: https://www.climatiq.io/data/activity/consumer_goods-type_mens_womens_boys_and_girls_clothing
  /// Creates an Emission Factor for new clothing.
  /// 
  /// Parameters:
  ///  - money: the amount of money spent
  ///  - moneyUnit: the type of currency for money
  ClothingEmissions.newClothing({
    required double money, 
    required MoneyUnit moneyUnit
  }): _amount = money,
      _moneyUnit = moneyUnit,
      _weightUnit = null,
      _clothingType = ClothingType.newClothing,
      super(category: EmissionCategory.clothing,
        id: 'consumer_goods-type_mens_womens_boys_and_girls_clothing');

  // API Reference: https://www.climatiq.io/data/activity/consumer_goods-type_infant_clothing
  /// Creates an Emission Factor for infant clothing.
  /// 
  /// Parameters:
  ///  - money: the amount of money spent
  ///  - moneyUnit: the type of currency for money
  ClothingEmissions.infantClothing({
    required double money, 
    required MoneyUnit moneyUnit
  }): _amount = money,
      _moneyUnit = moneyUnit,
      _weightUnit = null,
      _clothingType = ClothingType.infantClothing,
      super(category: EmissionCategory.clothing,
        id: 'consumer_goods-type_infant_clothing');
  
  // API Reference: https://www.climatiq.io/data/activity/consumer_goods-type_clothing_reused
  /// Creates an Emission Factor for used clothing.
  /// 
  /// Parameters:
  ///  - weight: the total weight of the clothing
  ///  - weightUnit: the unit of measurement for the weight
  ClothingEmissions.usedClothing({
    required double weight, 
    required WeightUnit weightUnit
  }): _amount = weight,
      _moneyUnit = null,
      _weightUnit = weightUnit,
      _clothingType = ClothingType.usedClothing,
      super(category: EmissionCategory.clothing,
        id: 'consumer_goods-type_clothing_reused');


  // GETTER METHODS //

  /// Returns the amount of money if money is being used instead of weight.
  /// Returns null if weight is being used for this emission factor
  double? get money => _moneyUnit != null ? _amount : null;
  /// Returns the weight if weight is being used instead of money.
  /// Returns null if money is being used for this emission factor
  double? get weight => _weightUnit != null ? _amount : null;
  /// Returns the amount, regardless of whether it's money or weight
  double get amount => _amount;

  /// Returns the type of currency (money unit) that this emission factor uses.
  /// Returns null if weight is being used for this emission factor
  MoneyUnit? get moneyUnit => _moneyUnit;
  /// Returns the type of currency (money unit) that this emission factor uses.
  /// Returns null if weight is being used for this emission factor
  WeightUnit? get weightUnit => _weightUnit;

  /// Returns the type of clothing
  ClothingType get clothingType => _clothingType;


  @override 
  String toString() {
    String result = 'type: ${clothingType.toString()},\n';
    result += '  id: ${super.toString()},\n';
    result += (weight != null) ? '  weight: $_amount,\n' : '  money: $_amount,\n';
    result += (weightUnit != null) ? '  weight unit: ${weightUnit.toString()}' 
                                   : '  money unit: ${moneyUnit.toString()}';
    return result;
  }
}