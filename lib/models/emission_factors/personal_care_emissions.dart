import 'package:go_green/models/emission_data/emission_data_enums.dart';
import 'package:go_green/models/emission_data/emission_subtypes.dart';
import 'package:go_green/models/emission_factors/base_emission_factors/money_emission_factor.dart';

enum PersonalCareType{jewelery, perfume, toiletries, soap, toiletPaper, feminineHygiene, disposableDiaper}

/// Represents emissions from personal care and accessory items
class PersonalCareEmissions extends MoneyEmissionFactor {
  /// The type of personal care or accessory
  final String personalCareType;

  /// Creates an Emission Factor for furniture.
  /// 
  /// Parameters:
  ///  - money: the amount of money spent
  ///  - moneyUnit: the type of currency for money
  PersonalCareEmissions({
    required super.money, 
    required super.moneyUnit,
    required this.personalCareType
  }): super(
    category: EmissionCategory.furniture,
    id: EmissionSubtypes().personalCareTypes[personalCareType] ?? 'type not found'
  );
  
  @override 
  String toString() {
    String result = '${super.toString()},\n';
    result += '  type: ${personalCareType.toString()}';
    return result;
  }
}