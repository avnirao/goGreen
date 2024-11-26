// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recycling_center.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecyclingCenter _$RecyclingCenterFromJson(Map<String, dynamic> json) =>
    RecyclingCenter(
      name: json['name'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      url: json['url'] as String,
    );

Map<String, dynamic> _$RecyclingCenterToJson(RecyclingCenter instance) =>
    <String, dynamic>{
      'name': instance.name,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'url': instance.url,
    };
