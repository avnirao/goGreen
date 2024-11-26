import 'package:go_green/models/emission_factors/emission_factors.dart';
import 'package:isar/isar.dart';
part 'entry.g.dart';

/// Class to represent an emissions entry
@collection
class Entry {
  /// This Entry's identifying number.
  /// invariant: must be unique
  final Id? id;

  ///The user's notes for this entry
  final String notes;

  /// The last time this Journal Entry was updated.
  /// Invariant: must be equal to or later than createdAt.
  final DateTime updatedAt;

  /// The time this Journal Entry was created.
  /// Invariant: must be equal to or earlier than updatedAt.
  final DateTime createdAt;

  /// the date this entry is tracking emissions for
  final DateTime emissionsDate;

  /// the types of emissions for this entry
  final EmissionFactor emissionType;

  final double CO2;

  /// Constructs an Entry using all fields
  Entry({
    required this.id,
    required this.notes,
    required this.updatedAt,
    required this.createdAt,
    required this.emissionsDate,
    required this.emissionType,
    this.CO2 = -1
  });

  /// Constructs a new entry given a list of emission types.
  /// Optionally pass in notes for the day and a date. If no date is passed, sets the date to now.
  factory Entry.fromEmissions({required EmissionFactor emissionType, notes = '', emissionsDate}) {
    final when = DateTime.now();
    return Entry (
      id: Isar.autoIncrement,
      notes: notes,
      updatedAt: when,
      createdAt: when,
      // sets the date for this entry to the given date, or DateTime.now if it's not provided
      emissionsDate: emissionsDate ?? when,
      emissionType: emissionType,
    );
  }

}
