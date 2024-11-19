abstract class EmissionFactor {
  /// The activity ID for the emission factor (for the API)
  final String id;
  /// The data version to query from the API
  final String dataVersion;

  /// Constructs an Emission Factor with an id. 
  /// 
  /// Parameters:
  ///  - id: the activity id for the emission factor
  ///  - dataVersion: the data version to query from the API
  EmissionFactor({required this.id, this.dataVersion = "^0"});
}