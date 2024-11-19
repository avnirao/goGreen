import 'package:go_green/models/emission_factors/emission_factors.dart';

/// Class to represent an emissions entry
class Entry {
  /// This Entry's identifying number.
  /// invariant: must be unique
  final int id;

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
  final List<EmissionFactor> emissionTypes;

  /// Constructs an Entry using all fields
  Entry({
    required this.id,
    required this.notes,
    required this.updatedAt,
    required this.createdAt,
    required this.emissionsDate,
    required this.emissionTypes
  });

  /// Constructs a new entry given a list of emission types.
  /// Optionally pass in notes for the day and a date. If no date is passed, sets the date to now.
  factory Entry.fromEmissions({required List<EmissionFactor> emissionTypes, notes = '', emissionsDate}) {
    final when = DateTime.now();
    return Entry (
      id: SequentialIDMaker.nextID(),
      notes: notes,
      updatedAt: when,
      createdAt: when,
      // sets the date for this entry to the given date, or DateTime.now if it's not provided
      emissionsDate: emissionsDate ?? when,
      emissionTypes: emissionTypes
    );
  }

}

/// Creates unique, incrementing IDs for the journal entries starting at 1
class SequentialIDMaker {
  // Represents the previous ID number
  static int _lastID = 0;

  /// Returns the next ID number
  static int nextID() {
    _lastID += 1;
    return _lastID;
  }
}