import 'package:go_green/models/emission_factors/emission_data_enums.dart';
import 'package:go_green/models/emission_factors/emission_factors.dart';

/// Abstract class to represent Emissions Factors that are calculated based on money spent.
abstract class MoneyEmissionFactor extends EmissionFactor{
  /// The amount of money spent
  final double money;
  /// The units for money
  final MoneyUnit moneyUnit;

  /// Creates an emission factor based on money spent.
  /// 
  /// Parameters: 
  ///  - money: the amount of money spent
  ///  - moneyUnit: the type of currency for money
  ///  - category: the overall category for all types of emissions in this class
  ///  - id: the activity id for the emission factor
  MoneyEmissionFactor({
    required this.money,
    required this.moneyUnit,
    required super.category,
    required super.id,
  });

  @override 
  String toString() {
    String result = '  ${super.toString()},\n';
    result += '  money: $money,\n';
    result += '  money unit: ${moneyUnit.toString()}';
    return result;
  }
}