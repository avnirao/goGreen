// select type first -> different params -> get CO2
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:go_green/models/emission_factors/emission_factors.dart';
import 'package:go_green/models/entry.dart';
import 'package:intl/intl.dart';

/// A StatefulWidget that displays and allows editing of a single Entry.
class EntryView extends StatefulWidget{
  final Entry curEntry;

  const EntryView({super.key, required this.curEntry});

  @override
  State<EntryView> createState() => _EntryViewState();
}

class _EntryViewState extends State<EntryView>{
  // State variables for storing editable text fields
  late String notes;
  late DateTime updatedAt;
  late DateTime createdAt;
  late DateTime emissionsDate;
  late EmissionFactor emissionType;
  late double co2;

  @override
  void initState() {
    super.initState();
    // Initialize state variables with values from the provided journal entry
    notes = widget.curEntry.notes;
    updatedAt = widget.curEntry.updatedAt;
    createdAt = widget.curEntry.createdAt;
    emissionsDate = widget.curEntry.emissionsDate;
    emissionType = widget.curEntry.emissionType;
    co2 = widget.curEntry.co2;
  }

  // Saves the current state of the entry and returns to the previous screen.
  void _popback(BuildContext context){
    // Create an updated Entry with current state values
    final curEntry = Entry(
      id: widget.curEntry.id,
      notes: widget.curEntry.notes,
      updatedAt: DateTime.now(),
      createdAt: widget.curEntry.createdAt,
      emissionsDate: widget.curEntry.emissionsDate,
      emissionType: widget.curEntry.emissionType,
      co2: widget.curEntry.co2,
    );

    // Pass the updated entry back to the previous screen and close this view
    Navigator.pop(context, curEntry);
  }

  void _onPopInvokedWithResult(bool didPop, dynamic canPop) {
    if (!didPop) {
      _popback(context);
    }
  }

  @override
  Widget build(BuildContext context){
    return PopScope(
      onPopInvokedWithResult: _onPopInvokedWithResult,
      canPop: false,
      child: Scaffold(
        appBar: AppBar(),
        body: Container(

        ),
      ),
    );
  }

  // Helper method to format a DateTime as a readable string.
  String _formatDateTime(DateTime when) {
    return DateFormat.yMd().add_jm().format(when);
  }
}