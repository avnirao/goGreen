// TODO(Mason): Finish
import 'package:flutter/material.dart';
import 'package:go_green/models/activity_history.dart';
import 'package:go_green/models/entry.dart';
import 'package:isar/isar.dart';

class ActivityProvider extends ChangeNotifier{
  final ActivityHistory _activityHistory;

  ActivityProvider(Isar isar,) : _activityHistory = ActivityHistory(isar,);

  // Provide access to a clone of the journal to avoid direct modification
  ActivityHistory get activityHistory => _activityHistory.clone();

  // Proxy method for upserting a journal entry and notifying listeners
  Future<void> upsertEntry(Entry entry) async {
    await _activityHistory.upsertEntry(entry);
    notifyListeners();
  }
}