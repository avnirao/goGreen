import 'dart:convert';
import 'recycling_center.dart';

class RecyclingCentersDB {
  final List<RecyclingCenter> _centers;

  List<RecyclingCenter> get all {
    return List<RecyclingCenter>.from(_centers, growable: false);
  }

  // Constructor to initialize RecyclingCentersDB from JSON
  RecyclingCentersDB.initializeFromJson(String jsonString)
      : _centers = _decodeRecyclingCenterListJson(jsonString);

  static List<RecyclingCenter> _decodeRecyclingCenterListJson(String jsonString) {
    final listMap = jsonDecode(jsonString);
    final theList = (listMap as List).map((element) {
      return RecyclingCenter.fromJson(element);
    }).toList();
    return theList;
  }
}
