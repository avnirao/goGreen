import 'package:go_green/models/entry.dart';
import 'package:isar/isar.dart';

class ActivityHistory {
  final Isar _isar;
  final List<Entry> _entries;

  ActivityHistory(Isar isar) : _entries = isar.entrys.where().findAllSync().toList(), _isar = isar;

  List<Entry> get entries {
    return List.unmodifiable(_isar.entrys.where().findAllSync());
  }

  /// Internal constructor used to create a clone of the journal, with the same name and a copy of the entries list.
  ActivityHistory._internal({required List<Entry> entries, required Isar isar})
      : _entries = List<Entry>.from(entries), _isar = isar;

  /// Adds a new entry to the journal or updates an existing entry if an entry
  /// with the same ID already exists in the list.
  /// - If an entry with the same ID is found, it replaces that entry.
  /// - Otherwise, the entry is added to the list.
  Future<void> upsertEntry(Entry entry) async {
    await _isar.writeTxn(() async {
      await _isar.entrys.put(entry);
    });
  }

  /// Creates a clone of the current journal, duplicating the name and entries list.
  /// This ensures any modifications to the clone do not affect the original journal.
  ActivityHistory clone() {
    return ActivityHistory._internal(
      entries: List<Entry>.from(_entries),
      isar: _isar
    );
  }
}