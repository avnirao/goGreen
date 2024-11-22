import 'package:go_green/models/emission_factors/emission_data_enums.dart';
import 'package:go_green/models/emission_factors/emission_factors.dart';

/// Abstract class to represent Emissions Factors that are calculated based on weight.
abstract class WeightEmissionFactor extends EmissionFactor{
  /// The weight of the emission factor
  final double weight;
  /// The units for weight
  final WeightUnit weightUnit;

  /// Creates an emission factor based on weight.
  /// 
  /// Parameters: 
  ///  - weight: the weight of the emission factor
  ///  - weightUnit: the units of measurement for the weight
  ///  - category: the overall category for all types of emissions in this class
  ///  - id: the activity id for the emission factor
  WeightEmissionFactor({
    required this.weight,
    required this.weightUnit,
    required super.category,
    required super.id,
  });

  @override 
  String toString() {
    String result = '  ${super.toString()},\n';
    result += '  weight: $weight,\n';
    result += '  weight unit: ${weightUnit.toString()}';
    return result;
  }
}