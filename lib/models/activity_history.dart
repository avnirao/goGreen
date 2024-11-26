import 'package:go_green/models/entry.dart';

// represents an ActivityHistory
class ActivityHistory {
  final List<Entry> _entries;

  ActivityHistory() : _entries = [];

  List<Entry> get entries => List.unmodifiable(_entries);

  double get totalCo2 => _entries.fold(0.0, (sum, entry) => sum + entry.co2);

  ActivityHistory._internal({required List<Entry> entries}) 
  : _entries = List<Entry>.from(entries);

  // gets a clone of ActivityHistory
  ActivityHistory clone() {
    return ActivityHistory._internal(entries: List<Entry>.from(_entries));
  }

  // upsert an entry into _entries, replace if id already exists
  void upsertEntry(Entry entry) {
    final index = _entries.indexWhere((entry1) => entry1.id == entry.id);
    if (index != -1) {
        _entries[index] = entry;
    } else {
      _entries.add(entry);
    }
  }
}