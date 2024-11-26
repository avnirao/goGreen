import 'package:go_green/models/emission_data/emission_subtypes.dart';
import 'package:go_green/models/emission_factors/base_emission_factors/weight_emission_factor.dart';
import 'package:go_green/models/emission_data/emission_data_enums.dart';

/// Represents types of food waste.
// enum WasteType{cardboard, paper, glass, books, clothing, plastic, carpet, metalCans, mixedWaste}

/// Represents emissions from food waste
class GeneralWasteEmissions extends WeightEmissionFactor {
  /// The type of waste
  final String wasteType;

  /// Creates an Emission Factor for paper.
  /// 
  /// Parameters:
  ///  - weight: the weight of the emission factor
  ///  - weightUnit: the units of measurement for the weight
  ///  - recycled: Whether the waste was recycled or composted. Set to false if landfilled.
  GeneralWasteEmissions({
    required super.weight, 
    required super.weightUnit,
    required this.wasteType
  }): super(
        category: EmissionCategory.generalWaste,
        id: EmissionSubtypes().generalWasteTypes[wasteType] ?? 'type not found'
      );
  
  @override 
  String toString() {
    String result = '${super.toString()},\n';
    result += '  type: ${wasteType.toString()}';
    return result;
  }
}