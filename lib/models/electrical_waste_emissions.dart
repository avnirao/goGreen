import 'package:go_green/models/emission_factors/emission_data_enums.dart';
import 'package:go_green/models/emission_factors/base_emission_factors/weight_emission_factor.dart';

/// Represents types of electronic waste.
enum ElectricalWasteType{batteries, monitors, otherSmallDevices}

/// Represents emissions from food waste
class ElectricalWasteEmissions extends WeightEmissionFactor {
  /// The type of food waste
  final ElectricalWasteType electricalWasteType;

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
    required this.electricalWasteType,
    required bool recycled
  }): super(
    category: EmissionCategory.electricalWaste,
    id: switch (electricalWasteType) {
      ElectricalWasteType.batteries => 
        'waste-type_batteries-disposal_method_${recycled ? 'open_loop' : 'landfill'}',
      ElectricalWasteType.monitors => 
        'waste-type_flat_panel_displays-disposal_method_${recycled ? 'recycled' : 'landfilled'}',
      ElectricalWasteType.otherSmallDevices => 
        'waste-type_electronic_peripherals-disposal_method_${recycled ? 'recycled' : 'landfilled'}',
    }
  );
  
  @override 
  String toString() {
    String result = '${super.toString()},\n';
    result += '  type: ${electricalWasteType.toString()}';
    return result;
  }
}