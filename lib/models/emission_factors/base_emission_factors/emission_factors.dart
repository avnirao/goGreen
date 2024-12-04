import 'package:go_green/models/emission_data/emission_data_enums.dart';

/// Abstract class to represent an Emission Factor with an id, data version, and category
abstract class EmissionFactor {
  /// The activity ID for the emission factor (for the API)
  final String id;
  /// The data version to query from the API
  final String dataVersion;
  /// The overall category for all types of emissions in this class
  final EmissionCategory category;

  /// Constructs an Emission Factor with the ID used to call the API
  /// 
  /// Parameters:
  ///  - id: the activity id for the emission factor
  ///  - dataVersion: the data version to query from the API
  EmissionFactor({
    required this.category,
    required this.id, 
    this.dataVersion = "19"
  });

  /// Returns the info from this Emission Factor as a String.
  @override 
  String toString() {
    return 'category: $category,\n  id: $id';
  }
}