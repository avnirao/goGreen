import 'package:go_green/models/emission_factors/base_emission_factors/weight_emission_factor.dart';
import 'package:go_green/models/emission_factors/emission_data_enums.dart';

/// Represents types of food waste.
enum WasteType{cardboard, paper, glass, books, clothing, plastic, carpet, metalCans, mixedWaste}

/// Represents emissions from food waste
class GeneralWasteEmissions extends WeightEmissionFactor {
  /// The type of waste
  final WasteType wasteType;

  /// Creates an Emission Factor for paper.
  /// 
  /// Parameters:
  ///  - weight: the weight of the emission factor
  ///  - weightUnit: the units of measurement for the weight
  ///  - recycled: Whether the waste was recycled or composted. Set to false if landfilled.
  GeneralWasteEmissions({
    required super.weight, 
    required super.weightUnit,
    required this.wasteType,
    required bool recycled
  }): super(
        category: EmissionCategory.generalWaste,
        id: switch(wasteType) {
          WasteType.cardboard => 
            'waste-type_cardboard-disposal_method_${recycled ? 'composting' : 'landfill'}',
          WasteType.paper => 
            'waste-type_mixed_paper_general-disposal_method_${recycled ? 'recycled' : 'landfilled'}',
          WasteType.glass => 
            'waste-type_glass-disposal_method_${recycled ? 'recycled' : 'landfill'}',
          WasteType.books => 
            'waste-type_books-disposal_method_${recycled ? 'closed_loop' : 'landfill'}',
          WasteType.clothing => 
            'waste-type_clothing-disposal_method_${recycled ? 'closed_loop' : 'landfill'}',
          WasteType.plastic => 
            'waste-type_mixed_plastics-disposal_method_${recycled ? 'recycled' : 'landfilled'}',
          WasteType.carpet =>
            'waste-type_carpet-disposal_method_landfilled',
          WasteType.metalCans => 
            'waste-type_metal_mixed_cans-disposal_method_${recycled ? 'open_loop' : 'landfill'}',
          WasteType.mixedWaste => 
            recycled ? 'waste-type_mixed_msw-disposal_method_landfilled'
                     : 'waste-type_mixed_recyclables-disposal_method_recycled',
        }
      );
  
  @override 
  String toString() {
    String result = '${super.toString()},\n';
    result += '  type: ${wasteType.toString()}';
    return result;
  }
}