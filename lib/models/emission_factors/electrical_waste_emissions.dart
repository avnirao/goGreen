import 'package:go_green/models/emission_data/emission_data_enums.dart';
import 'package:go_green/models/emission_data/emission_subtypes.dart';
import 'package:go_green/models/emission_factors/base_emission_factors/weight_emission_factor.dart';


/// Represents emissions from food waste
class ElectricalWasteEmissions extends WeightEmissionFactor {
  /// The type of food waste
  final String electricalWasteType;

  /// Creates an Emission Factor for furniture.
  /// 
  /// Parameters:
  ///  - weight: the weight of the emission factor
  ///  - weightUnit: the units of measurement for the weight
  ///  - foodType: the type of food waste
  ///  - recycled: whether this waste was recycled. Set to false if landfilled.
  ElectricalWasteEmissions({
    required super.weight, 
    required super.weightUnit,
    required this.electricalWasteType
  }): super(
    category: EmissionCategory.electricalWaste,
    id: EmissionSubtypes().electricalWasteTypes[electricalWasteType] ?? 'type not found'
  );
  
  @override 
  String toString() {
    String result = '${super.toString()},\n';
    result += '  type: ${electricalWasteType.toString()}';
    return result;
  }
}