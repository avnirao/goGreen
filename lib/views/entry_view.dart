/* What I Changed:
 *  - moved & simplified the initialization of dropdownMenuEntries
 *  - moved initialization of subtypeDropdownEntries
 *  - gave moneyUnit and weightUnit fields default values. They should never be null in this file because they're required to make calls to the API
 *  - removed some null checks that became unneccessary because of my other changes
 *  - modified subtype to use the keys of the EmissionSubtypes maps. The keys are the names we display to the user, values are just used for the API. You shouldn't have to use the values :)
 *  - added code to handle ElectricalWasteEmissions
 */

// select type first -> different params -> get CO2
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:go_green/climatiq_api/emission_checker.dart';
import 'package:go_green/climatiq_api/emission_estimate.dart';
import 'package:go_green/models/emission_data/emission_data_enums.dart';
import 'package:go_green/models/emission_data/emission_subtypes.dart';
import 'package:go_green/models/emission_factors/base_emission_factors/emission_factors.dart';
import 'package:go_green/models/emission_factors/clothing_emissions.dart';
import 'package:go_green/models/emission_factors/electrical_waste_emissions.dart';
import 'package:go_green/models/entry.dart';

/// A StatefulWidget that displays and allows editing of a single Entry.
class EntryView extends StatefulWidget{
  final Entry curEntry;

  const EntryView({super.key, required this.curEntry});

  @override
  State<EntryView> createState() => _EntryViewState();
}

class _EntryViewState extends State<EntryView>{
  // State variables for storing editable text fields
  String notes = '';
  DateTime updatedAt = DateTime.now();
  DateTime createdAt = DateTime.now();
  DateTime emissionsDate = DateTime.now();
  EmissionCategory category = EmissionCategory.clothing;
  String subtype = '';
  double co2 = 0;
  EmissionChecker checker = EmissionChecker();
  List<EmissionCategory> categories = EmissionCategory.values;

  // Moved this list here
  List<DropdownMenuEntry<String>> subtypeDropdownMenuEntries = [];  

  // Moved dropdown list for categories here & simplified its initialization
  // I added a toString override to EmissionCategory in my own branch that will make these category names display more cleanly to the user
  List<DropdownMenuEntry<EmissionCategory>> dropdownMenuEntries = EmissionCategory.values.map((category) {
    return DropdownMenuEntry<EmissionCategory>(value: category, label: category.toString());
  }).toList();


  // Input fields for estimation

  // for clothing
  double amount = 0;
  // Gave money and weight unit default values
  MoneyUnit moneyUnit = MoneyUnit.usd;
  WeightUnit weightUnit = WeightUnit.lb;
  String curEst = 'N/A';

  @override
  void initState() {
    super.initState();
    // Initialize state variables with values from the provided journal entry
    notes = widget.curEntry.notes;
    updatedAt = widget.curEntry.updatedAt;
    createdAt = widget.curEntry.createdAt;
    emissionsDate = widget.curEntry.emissionsDate;
    category = widget.curEntry.category;
    co2 = widget.curEntry.co2;
    subtype = widget.curEntry.subtype;

    // intialize the dropdown menus
    // removed null check, category is never null
    _updateSubtypeDropdown(category);
  }


  @override
  Widget build(BuildContext context){
    return PopScope(
      onPopInvokedWithResult: _onPopInvokedWithResult,
      canPop: false,
      child: Scaffold(
        appBar: AppBar(),
        body:
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Dropdown for category selection
              DropdownMenu(
                initialSelection: category,
                dropdownMenuEntries: dropdownMenuEntries,
                onSelected: (EmissionCategory? value) {
                  setState(() {
                    category = value ?? EmissionCategory.clothing;
                  });
                  _updateSubtypeDropdown(value ?? EmissionCategory.clothing);
                },
              ),
              const SizedBox(height: 20),

              // Dropdown for subtype selection
              DropdownMenu(
                initialSelection: subtype,
                dropdownMenuEntries: subtypeDropdownMenuEntries,
                onSelected: (String? value) {
                  setState(() {
                    subtype = value ?? 'Leather';
                  });
                },
              ),
              const SizedBox(height: 20),

              // pumping the user to give parameters
              if (category == EmissionCategory.clothing)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (subtype == 'consumer_goods-type_clothing_reused')
                      Column(
                        children: [
                          TextField(
                            decoration: const InputDecoration(
                              labelText: 'Weight',
                              suffixText: 'kg',
                            ),
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              setState(() {
                                amount = double.tryParse(value) ?? 0;
                              });
                            },
                          ),
                          DropdownButton<WeightUnit>(
                            value: weightUnit,
                            onChanged: (WeightUnit? value) {
                              setState(() {
                                // no change if value is null
                                weightUnit = value ?? weightUnit;
                              });
                            },
                            items: WeightUnit.values
                                .map((unit) => DropdownMenuItem<WeightUnit>(
                                      value: unit,
                                      child: Text(unit.toString().split('.').last),
                                    ))
                                .toList(),
                          ),
                        ],
                      )
                    else
                      Column(
                        children: [
                          TextField(
                            decoration: const InputDecoration(
                              labelText: 'Money',
                              suffixText: 'currency',
                            ),
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              setState(() {
                                amount = double.tryParse(value) ?? 0;
                              });
                            },
                          ),
                          DropdownButton<MoneyUnit>(
                            value: moneyUnit,
                            onChanged: (MoneyUnit? value) {
                              setState(() {
                                // no change if value is null
                                moneyUnit = value ?? moneyUnit;
                              });
                            },
                            items: MoneyUnit.values
                                .map((unit) => DropdownMenuItem<MoneyUnit>(
                                      value: unit,
                                      child: Text(unit.toString().split('.').last),
                                    ))
                                .toList(),
                          ),
                        ],
                      ),
                  ],
                ),

              ElevatedButton(
                onPressed: () async {
                  EmissionEstimate? estimate = await checker.getEmissions(_estimateEmission());
                  if (estimate != null) {
                    print('example estimate: $estimate');
                    setState(() {
                      // If you want to get this as a double, you can also call estimate.co2
                      curEst = estimate.toString();
                    });
                  } else {
                    setState(() {
                      curEst = 'failed';
                    });
                    print('failed');
                  }
                }, 
                child: const Column(
                  children: [
                    Text('Estimate emission'),
                  ]
                )
              ),

              Text(curEst+'$amount $weightUnit $moneyUnit'),

              // Save button
              ElevatedButton(
                onPressed: () {
                  _popback(context);
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
    );
  }


  // dynamic estimation 
  EmissionFactor _estimateEmission() {
    switch (category) {
      // clothing case
      case EmissionCategory.clothing:
        switch (subtype) {
          case 'Leather':
            return ClothingEmissions.leather(money: amount, moneyUnit: moneyUnit);
          case 'Footwear':
            return ClothingEmissions.footwear(money: amount, moneyUnit: moneyUnit);
          case 'New Clothing':
            return ClothingEmissions.newClothing(money: amount, moneyUnit: moneyUnit);
          case 'Infant Clothing':
            return ClothingEmissions.infantClothing(money: amount, moneyUnit: moneyUnit);
          case 'Used Clothing':
            return ClothingEmissions.usedClothing(weight: amount, weightUnit: weightUnit);
          default:
            return ClothingEmissions.usedClothing(weight: amount, weightUnit: weightUnit);
        }
      case EmissionCategory.electricalWaste: 
        return ElectricalWasteEmissions(weight: amount, weightUnit: weightUnit, electricalWasteType: subtype);
      // Add other category cases for emission estimation here
      default:
        return ClothingEmissions.usedClothing(weight: amount, weightUnit: weightUnit);
    }
  }

  // Saves the current state of the entry and returns to the previous screen.
  void _popback(BuildContext context){
    // Create an updated Entry with current state values
    final curEntry = Entry(
      id: widget.curEntry.id,
      notes: notes,
      updatedAt: DateTime.now(),
      createdAt: createdAt,
      emissionsDate: emissionsDate,
      category: category,
      co2: co2,
      subtype: subtype,
    );

    // Pass the updated entry back to the previous screen and close this view
    Navigator.pop(context, curEntry);
  }


  void _onPopInvokedWithResult(bool didPop, dynamic canPop) {
    if (!didPop) {
      _popback(context);
    }
  }

  // Update the subtype dropdown menu based on the selected category
  void _updateSubtypeDropdown(EmissionCategory selectedCategory) {
    Map<String, String> subtypeMap;

    switch (selectedCategory) {
      case EmissionCategory.clothing:
        subtypeMap = EmissionSubtypes().clothingTypes;
        break;
      case EmissionCategory.electricalWaste:
        subtypeMap = EmissionSubtypes().electricalWasteTypes;
        break;
      case EmissionCategory.energy:
        subtypeMap = EmissionSubtypes().energyTypes;
        break;
      case EmissionCategory.food:
        subtypeMap = EmissionSubtypes().foodTypes;
        break;
      case EmissionCategory.foodWaste:
        subtypeMap = EmissionSubtypes().foodWasteTypes;
        break;
      case EmissionCategory.furniture:
        subtypeMap = EmissionSubtypes().furnitureTypes;
        break;
      case EmissionCategory.generalWaste:
        subtypeMap = EmissionSubtypes().generalWasteTypes;
        break;
      case EmissionCategory.personalCareAndAccessories:
        subtypeMap = EmissionSubtypes().personalCareTypes;
        break;
      case EmissionCategory.travel:
        subtypeMap = EmissionSubtypes().travelTypes;
        break;
      default:
        subtypeMap = {};
    }

    // Update the dropdown menu entries for subtypes
    setState(() {
      subtypeDropdownMenuEntries = subtypeMap.entries
          .map((e) => DropdownMenuEntry<String>(
                value: e.key,
                label: e.key,
              ))
          .toList();
      // Use keys instead of values with these maps - the values are just for the API to use
      subtype = subtypeMap.keys.first;
    });
  }

  // // Helper method to format a DateTime as a readable string.
  // String _formatDateTime(DateTime when) {
  //   return DateFormat.yMd().add_jm().format(when);
  // }
}