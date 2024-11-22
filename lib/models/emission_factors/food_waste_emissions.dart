import 'package:go_green/models/emission_factors/emission_data_enums.dart';
import 'package:go_green/models/emission_factors/base_emission_factors/weight_emission_factor.dart';

/// Represents types of food waste.
enum FoodWasteType{meat, grain, dairy, fruitsAndVegetables, mixedOrganics, otherFoodWaste}

/// Represents emissions from food waste
class FoodWasteEmissions extends WeightEmissionFactor {
  /// The type of food waste
  final FoodWasteType foodWasteType;

  /// Creates an Emission Factor for furniture.
  /// 
  /// Parameters:
  ///  - weight: the weight of the emission factor
  ///  - weightUnit: the units of measurement for the weight
  ///  - foodType: the type of food waste
  ///  - composted: whether this waste was composted. Set to false if landfilled.
  FoodWasteEmissions({
    required super.weight, 
    required super.weightUnit,
    required this.foodWasteType,
    required bool composted
  }): super(
    category: EmissionCategory.foodWaste,
    id: switch (foodWasteType) {
      FoodWasteType.meat => 
        'waste-type_food_waste_meat_only-disposal_method_${composted ? 'composted' : 'landfilled'}',
      FoodWasteType.grain => 
        'waste-type_grains-disposal_method_${composted ? 'composted' : 'landfilled'}',
      FoodWasteType.dairy => 
        'waste-type_dairy_products-disposal_method_${composted ? 'composted' : 'landfilled'}',
      FoodWasteType.fruitsAndVegetables => 
        'waste-type_fruits_and_vegetables-disposal_method_${composted ? 'composted' : 'landfilled'}',
      FoodWasteType.mixedOrganics => 
        'waste-type_mixed_organics-disposal_method_${composted ? 'composted' : 'landfilled'}',
      FoodWasteType.otherFoodWaste => 
        'waste-type_food_waste-disposal_method_${composted ? 'composted' : 'landfilled'}',
    }
  );
  
  @override 
  String toString() {
    String result = '${super.toString()},\n';
    result += '  type: ${foodWasteType.toString()}';
    return result;
  }
}