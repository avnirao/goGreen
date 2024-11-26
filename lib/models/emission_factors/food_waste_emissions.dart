import 'package:go_green/models/emission_data/emission_data_enums.dart';
import 'package:go_green/models/emission_data/emission_subtypes.dart';
import 'package:go_green/models/emission_factors/base_emission_factors/weight_emission_factor.dart';

/// Represents types of food waste.
// enum FoodWasteType{meat, grain, dairy, fruitsAndVegetables, mixedOrganics, otherFoodWaste}

/// Represents emissions from food waste
class FoodWasteEmissions extends WeightEmissionFactor {
  /// The type of food waste
  final String foodWasteType;

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
    required this.foodWasteType
  }): super(
    category: EmissionCategory.foodWaste,
    id: EmissionSubtypes().foodWasteTypes[foodWasteType] ?? 'type not found'
  );
  
  @override 
  String toString() {
    String result = '${super.toString()},\n';
    result += '  type: ${foodWasteType.toString()}';
    return result;
  }
}