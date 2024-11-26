import 'package:flutter/material.dart';
import 'package:go_green/models/activity_history.dart';
import 'package:go_green/models/entry.dart';

class ActivityProvider extends ChangeNotifier {
  final ActivityHistory _activityHistory;

  // initializes the provider with an empty entries
  ActivityProvider() : _activityHistory = ActivityHistory();

  // gives access to the activityHistory avoiding modifications
  ActivityHistory get activityHistory => _activityHistory.clone();

  // upserting an entry and notifying listeners
  void upsertEntry(Entry entry) {
    _activityHistory.upsertEntry(entry);
    notifyListeners();
  }
}