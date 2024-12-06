import 'package:go_green/models/entry.dart';
import 'package:isar/isar.dart';

// represents an ActivityHistory
class ActivityHistory {
  // the Isar instance
  final Isar _isar;
  // the list of entries
  final List<Entry> _entries;

  ActivityHistory(Isar isar) : _entries = [], _isar = isar; // default constructor

  List<Entry> get entries => _isar.entrys.where().findAllSync(); //gets entries

  double get totalCo2 => _entries.fold(0.0, (sum, entry) => sum + entry.co2); // gets total co2
  // gets today co2 emissioned
  double get todayCo2 {
    DateTime now = DateTime.now();
    return _entries
        .where((entry) =>
            entry.emissionsDate.year == now.year &&
            entry.emissionsDate.month == now.month &&
            entry.emissionsDate.day == now.day)
        .fold(0.0, (sum, entry) => sum + entry.co2);
  }

  ActivityHistory._internal({required List<Entry> entries, required Isar isar}) 
  : _entries = isar.entrys.where().findAllSync().toList(), _isar = isar;

  // gets a clone of ActivityHistory
  ActivityHistory clone() {
    return ActivityHistory._internal(entries: List<Entry>.from(_entries), isar: _isar);
  }

  // upsert an entry into _entries
  Future<void> upsertEntry(Entry entry) async {
    await _isar.writeTxn(() async {
      await _isar.entrys.put(entry);
    });
  }
}