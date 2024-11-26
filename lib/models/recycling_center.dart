import 'package:json_annotation/json_annotation.dart';

part 'recycling_center.g.dart';

@JsonSerializable()
class RecyclingCenter {
  RecyclingCenter({
    // Required parameters
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.url,
  });

  // The name of the recycling center
  final String name;

  // The latitude of the recycling center
  final double latitude;

  // The longitude of the recycling center
  final double longitude;

  // The URL of the recycling center
  final String url;

 
  // JSON serialization methods
  factory RecyclingCenter.fromJson(Map<String, dynamic> json) =>
      _$RecyclingCenterFromJson(json);

  Map<String, dynamic> toJson() => _$RecyclingCenterToJson(this);

}
