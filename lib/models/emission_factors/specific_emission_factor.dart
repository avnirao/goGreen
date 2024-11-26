import 'package:json_annotation/json_annotation.dart';
import 'emission_factors.dart';

part 'specific_emission_factor.g.dart';

@JsonSerializable()
class SpecificEmissionFactor extends EmissionFactor {
  SpecificEmissionFactor({required super.id, super.dataVersion});

  factory SpecificEmissionFactor.fromJson(Map<String, dynamic> json) =>
      _$SpecificEmissionFactorFromJson(json);
  Map<String, dynamic> toJson() => _$SpecificEmissionFactorToJson(this);
}
