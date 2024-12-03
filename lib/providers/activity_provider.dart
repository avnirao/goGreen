import 'package:flutter/material.dart';
import 'package:go_green/models/activity_history.dart';
import 'package:go_green/models/entry.dart';
import 'package:isar/isar.dart';

class ActivityProvider extends ChangeNotifier {
  final ActivityHistory _activityHistory;

  // initializes the provider with an empty entries
  ActivityProvider(Isar isar) : _activityHistory = ActivityHistory(isar);

  // gives access to the activityHistory avoiding modifications
  ActivityHistory get activityHistory => _activityHistory.clone();

  // Proxy method for upserting an entry and notifying listeners
  Future<void> upsertEntry(Entry entry) async {
    await _activityHistory.upsertEntry(entry);
    notifyListeners();
  }
}