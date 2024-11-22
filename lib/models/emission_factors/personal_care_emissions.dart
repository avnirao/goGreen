import 'package:go_green/models/emission_factors/emission_data_enums.dart';
import 'package:go_green/models/emission_factors/money_emission_factor.dart';

enum PersonalCareType{jewellery, perfume, toiletries, soap, toiletPaper, feminineHygiene, disposableDiaper}

/// Represents emissions from personal care and accessory items
class PersonalCareEmissions extends MoneyEmissionFactor {
  /// The type of personal care or accessory
  final PersonalCareType personalCareType;

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
    id: switch (personalCareType) {
      PersonalCareType.jewellery => 
        'consumer_goods-type_jewellery_and_silverware',
      PersonalCareType.perfume || PersonalCareType.toiletries => 
        'consumer_goods-type_perfumes_and_toiletries',
      PersonalCareType.soap => 
        'consumer_goods-type_soaps_and_cleaning_compounds',
      PersonalCareType.toiletPaper => 
        'consumer_goods-type_sanitary_paper_products',
      PersonalCareType.feminineHygiene || PersonalCareType.disposableDiaper => 
        'consumer_goods-type_disposable_diapers_and_feminine_hygiene_products',
    }
  );
  
  @override 
  String toString() {
    String result = '${super.toString()},\n';
    result += '  type: ${personalCareType.toString()}';
    return result;
  }
}