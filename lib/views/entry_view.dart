import 'dart:core';
import 'package:flutter/material.dart';
import 'package:go_green/climatiq_api/emission_checker.dart';
import 'package:go_green/climatiq_api/emission_estimate.dart';
import 'package:go_green/models/emission_data/emission_data_enums.dart';
import 'package:go_green/models/emission_data/emission_subtypes.dart';
import 'package:go_green/models/emission_factors/base_emission_factors/emission_factors.dart';
import 'package:go_green/models/emission_factors/base_emission_factors/money_emission_factor.dart';
import 'package:go_green/models/emission_factors/base_emission_factors/weight_emission_factor.dart';
import 'package:go_green/models/emission_factors/clothing_emissions.dart';
import 'package:go_green/models/emission_factors/electrical_waste_emissions.dart';
import 'package:go_green/models/emission_factors/energy_emissions.dart';
import 'package:go_green/models/emission_factors/food_emissions.dart';
import 'package:go_green/models/emission_factors/food_waste_emissions.dart';
import 'package:go_green/models/emission_factors/furniture_emissions.dart';
import 'package:go_green/models/emission_factors/general_waste.dart';
import 'package:go_green/models/emission_factors/personal_care_emissions.dart';
import 'package:go_green/models/emission_factors/travel_emissions.dart';
import 'package:go_green/models/entry.dart';
import 'package:go_green/views/entry_widgets/amount_input.dart';
import 'package:go_green/views/entry_widgets/emission_info/clothing_info.dart';
import 'package:go_green/views/entry_widgets/custom_dropdown.dart';
import 'package:go_green/views/entry_widgets/emission_dropdown_menu.dart';
import 'package:go_green/views/entry_widgets/emission_info/energy_info.dart';
import 'package:go_green/views/entry_widgets/emission_info/food_info.dart';
import 'package:go_green/views/entry_widgets/emission_info/furniture_info.dart';
import 'package:go_green/views/entry_widgets/emission_info/personal_care_info.dart';
import 'package:go_green/views/entry_widgets/emission_info/travel_info.dart';
import 'package:go_green/views/entry_widgets/emission_info/waste_info.dart';
import 'package:intl/intl.dart';


/// A StatefulWidget that displays and allows editing of a single Entry.
class EntryView extends StatefulWidget{
  //current entry to display
  final Entry curEntry;

  //initialize with current entry
  const EntryView({super.key, required this.curEntry});

  @override
  State<EntryView> createState() => _EntryViewState();
}

class _EntryViewState extends State<EntryView>{

  // menu entries for category 
  List<DropdownMenuEntry<EmissionCategory>> dropdownMenuEntries = EmissionCategory.values.map((category) {
    return DropdownMenuEntry<EmissionCategory>(value: category, label: category.toString(), 
    style: const ButtonStyle(foregroundColor: WidgetStatePropertyAll(Color(0xFF386641)), 
    textStyle: WidgetStatePropertyAll(TextStyle(fontSize: 14))));
  }).toList();

  // menu entries for subtypes
  List<DropdownMenuEntry<String>> subtypeDropdownMenuEntries = [];


  // State variables for storing editable text fields
  String notes = '';
  DateTime updatedAt = DateTime.now();
  DateTime createdAt = DateTime.now();
  DateTime emissionsDate = DateTime.now();
  EmissionCategory category = EmissionCategory.clothing;
  String subtype = 'Leather';
  double co2 = 0;
  EmissionChecker checker = EmissionChecker();
  EmissionEstimate? comparisonEstimate;

  // for clothing
  double? amount; // also for money, weight, distance
  MoneyUnit? moneyUnit;
  WeightUnit? weightUnit;
  String curEst = 'N/A';

  // for energy
  EnergyAmount? energyAmount;

  // for travel
  DistanceUnit? distanceUnit;
  int? passengers;
  PassengerAmount? passengerAmount;
  VehicleSize? size;

  // resets traking state
  void _resetTrackingState() {
    setState(() {
      amount = null;
      moneyUnit = null;
      weightUnit = null;
      curEst = 'N/A';
      energyAmount = null;
      distanceUnit = null;
      passengers = null;
      passengerAmount = null;
      size = null;
      co2 = 0;
    });
  }

  @override
  void initState() {
    super.initState();
    // Initialize state variables with values from the provided journal entry
    category = widget.curEntry.category;
    subtype = widget.curEntry.subtype;
    amount = widget.curEntry.amount;
    notes = widget.curEntry.notes;
    updatedAt = widget.curEntry.updatedAt;
    createdAt = widget.curEntry.createdAt;
    emissionsDate = widget.curEntry.emissionsDate;
    co2 = widget.curEntry.co2;
    curEst = EmissionEstimate(co2: co2, unit: 'kg').toString();

    final EmissionFactor curFactor = _getEmissionFactor();

    switch (curFactor) {
      // money emission factors track currency type
      case MoneyEmissionFactor _:
        moneyUnit = widget.curEntry.moneyUnit;
        break;

      // weight emission factors track amount and weight unit
      case WeightEmissionFactor _:
        weightUnit = widget.curEntry.weightUnit;
        break;

      // travel emissions differ depending on type
      case TravelEmissions _:
        // all travel emissions track distance units
        distanceUnit = widget.curEntry.distanceUnit;
        switch (subtype) {
          // hybrid cars don't track anything else
          case 'Hybrid Car': break;
          // other cars track a specific passenger number
          case 'Gas Car' || 'Electric Car':
            passengers = widget.curEntry.passengers;
            break;
          // flights track vehicle size and passenger amount
          case 'Domestic Flight' || 'International Flight':
            size = widget.curEntry.size;
            passengerAmount = widget.curEntry.passengerAmount;
            break;
          // all other travel types track passenger amount
          default: 
            passengerAmount = widget.curEntry.passengerAmount;
            break;
        }

      // clothing emissions track either weight or money units
      case ClothingEmissions _:
        switch (subtype) {
          case 'Used Clothing':
            weightUnit = widget.curEntry.weightUnit;
            break;
          default: 
            moneyUnit = widget.curEntry.moneyUnit;
            break;
        }

      // energy emissions track an energy amount and don't track an amount
      case EnergyEmissions _:
        energyAmount = widget.curEntry.energyAmount;
        amount = null;
      
      default: throw UnsupportedError('Unsupported Emission Factor ${curFactor.runtimeType}');
    }

    // intialize the dropdown menus
    _updateSubtypeDropdown(category);
  }


  @override
  Widget build(BuildContext context){
    return PopScope(
      onPopInvokedWithResult: _onPopInvokedWithResult,
      canPop: false,
      child: Scaffold(
        backgroundColor: const Color(0xFFF2E8CF),
        appBar: AppBar(
          backgroundColor: const Color(0xFFF2E8CF),
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Semantics(child: const Icon(Icons.eco, color: Color(0xFF6A994E), semanticLabel: 'Leaf icon',)), // Leaf icon for GoGreen theme
              const SizedBox(width: 8),
              Flexible(
                child: Semantics(
                  child: const Text(
                    'Track Here', 
                    style: TextStyle(
                      color: Color(0xFF386641), 
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.fade
                    ),
                    semanticsLabel: 'Go Green: Track your emissions here.',
                  ),
                ),
              ),
            ],
          ),
        ),
        body:
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10,),
                  // first row of the page, two drop down menus and one date selector
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Dropdown for category selection
                      EmissionDropdownMenu(
                        label: 'Emission Category:',
                        semanticsLabel: 'Select Emission Category below.',
                        initialSelection: category, 
                        options: dropdownMenuEntries,
                        onSelected: (EmissionCategory? value) {
                          setState(() {
                            category = value ?? category;
                          });
                          _updateSubtypeDropdown(category);
                          _resetTrackingState();
                        },
                      ),
                      // Dropdown for subtype selection
                      EmissionDropdownMenu(
                        label: 'Emission Type:',
                        semanticsLabel: 'Select Emission Type below.',
                        onSelected: (String? value) {
                          setState(() {
                            subtype = value ?? subtype;

                            // set these to null for cars so that the estimate info screen displays accurate information
                            if (subtype == 'Electric Car' || subtype == 'Gas Car' || subtype == 'Hybrid Car') {
                              comparisonEstimate = null;
                              passengerAmount = null;
                            }
                          });
                          _estimateEmission();
                        },
                        initialSelection: subtype, 
                        options: subtypeDropdownMenuEntries,
                      ),
                    ],
                  ),
              
                  const SizedBox(height: 10),
              
                  // Date selector button
                  SizedBox(
                    width: 150, // Set uniform width for dropdown and button
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 234, 224, 198), // Button background color
                        foregroundColor: const Color(0xFF386641), // Text color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0), // Rounded corners matching dropdown
                        ),
                      ),
                      onPressed: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: emissionsDate,
                          firstDate: DateTime(2000),
                          lastDate: DateTime.now(),
                          builder: (BuildContext context, Widget? child) {
                            return Theme(
                              data: ThemeData.light().copyWith(
                                primaryColor: const Color(0xFF6A994E), // Header background color (e.g., calendar title)
                                colorScheme: const ColorScheme.light(
                                  primary: Color(0xFF6A994E), // Color for selected date and confirm button
                                  onPrimary: Color(0xFFF2E8CF), // Text color on the confirm button
                                  surface: Color(0xFFF2E8CF), // Background color of the calendar
                                  onSurface: Color(0xFF386641), // Color for the date text
                                ),
                                dialogBackgroundColor: const Color(0xFFF2E8CF), // Background color of the date picker dialog
                              ),
                              child: child!,
                            );
                          },
                        );
                        if (pickedDate != null && pickedDate != emissionsDate) {
                          setState(() {
                            emissionsDate = pickedDate;
                          });
                        }
                      },
                      child: Text(
                        'Choose Date: ${DateFormat.yMd().format(emissionsDate)}',
                        style: const TextStyle(
                          color: Color(0xFF386641),
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 10),
              
                  // selections for differenct categories
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (category == EmissionCategory.clothing)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            if (subtype == 'Used Clothing')
                              _buildWeightInputSection()
                            else
                              _buildMoneyInputSection(),
                          ],
                        )
                      else if (category == EmissionCategory.electricalWaste || category == EmissionCategory.foodWaste 
                      || category == EmissionCategory.personalCareAndAccessories || category == EmissionCategory.generalWaste)
                        _buildWeightInputSection()
                      else if (category == EmissionCategory.energy)
                        _buildEnergyInputSection()
                      else if (category == EmissionCategory.food || category == EmissionCategory.furniture
                      || category == EmissionCategory.personalCareAndAccessories)
                        _buildMoneyInputSection()
                      else if (category == EmissionCategory.travel)
                        _buildTravelInputSection(subtype),
                    ],
                  ),
                  
                  // notes field
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Semantics(
                        child: const Text(
                          'Notes:', 
                          style: TextStyle(color: Color(0xFF386641), fontSize: 16),
                          semanticsLabel: 'Enter any additional notes below.',
                        ),
                      ),
                      // notes box to enter notes
                      SizedBox(
                        width: 250,
                        height: 100,
                        child: TextFormField(
                          maxLines: 10,
                          initialValue: notes,
                          onChanged: (value) { setState(() => notes = value); },
                          decoration: InputDecoration(
                            labelStyle: TextStyle(color: Colors.grey.shade800),
                            filled: true,
                            fillColor: const Color.fromARGB(52, 193, 185, 102),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onTapOutside: (event) => FocusScope.of(context).unfocus()
                        ),
                      ),
                    ],
                  ),
                
                const SizedBox(height: 20),
              
                // Box to Display Estimated Emission
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                    padding: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 224, 214, 186), // Background color
                      borderRadius: BorderRadius.circular(15.0), // Rounded corners
                      border: Border.all(
                        color: const Color(0xFF386641),
                        width: 1.5,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Flexible(
                            child: Semantics(
                              child: Text(
                                'Estimate: $curEst',
                                semanticsLabel: 'Estimate: $curEst',
                                style: const TextStyle(
                                  fontSize: 22,
                                  color: Colors.black,
                                ),
                                
                              ),
                            ),
                          ),
                        ),
                        Semantics(
                          child: IconButton(
                            icon: const Icon(
                              Icons.info_outline, 
                              color: Color(0xFF386641),
                              semanticLabel: 'More info',
                            ),
                            onPressed: () {
                              _showInfoDialog(context, _getEmissionFactor());
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 20),
              
                // Save Button
                SizedBox(
                  width: 130,
                  height: 70,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 234, 224, 198), // Button background color
                      foregroundColor: const Color(0xFF386641), // Text color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0), // Rounded corners
                      ),
                    ),
                    onPressed: () {
                      _popback(context);
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(0), // Padding for better appearance
                      child: Text(
                        'Save',
                        semanticsLabel: 'Save',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
                        ),
            ),
        ),
      ),
    );
  }


  // dynamic estimation 
  EmissionFactor _getEmissionFactor() {
    switch (category) {
      // clothing case
      case EmissionCategory.clothing:
        switch (subtype) {
          case 'Leather':
            return ClothingEmissions.leather(money: amount ?? 0, moneyUnit: moneyUnit);
          case 'Footwear':
            return ClothingEmissions.footwear(money: amount ?? 0, moneyUnit: moneyUnit);
          case 'New Clothing':
            return ClothingEmissions.newClothing(money: amount ?? 0, moneyUnit: moneyUnit);
          case 'Infant Clothing':
            return ClothingEmissions.infantClothing(money: amount ?? 0, moneyUnit: moneyUnit);
          case 'Used Clothing':
            return ClothingEmissions.usedClothing(weight: amount ?? 0, weightUnit: weightUnit);
        }
      case EmissionCategory.electricalWaste:
        return ElectricalWasteEmissions(weight: amount ?? 0, weightUnit: WeightUnit.kg, electricalWasteType: subtype);
      case EmissionCategory.energy:
        switch(subtype) {
          case 'Electricity':
            return EnergyEmissions.electricity(energy: energyAmount);
          case 'Natural Gas':
            return EnergyEmissions.naturalGas(volume: energyAmount);
        }
      case EmissionCategory.food:
        return FoodEmissions(foodType: subtype, money: amount ?? 0, moneyUnit: moneyUnit);
      case EmissionCategory.foodWaste:
        return FoodWasteEmissions(foodWasteType: subtype, weight: amount ?? 0, weightUnit: weightUnit);
      case EmissionCategory.furniture:
        return FurnitureEmissions(furnitureType: subtype, money: amount ?? 0, moneyUnit: moneyUnit);
      case EmissionCategory.generalWaste:
        return GeneralWasteEmissions(wasteType: subtype, weight: amount ?? 0, weightUnit: weightUnit);
      case EmissionCategory.personalCareAndAccessories:
        return PersonalCareEmissions(money: amount ?? 0, moneyUnit: moneyUnit, personalCareType: subtype);
      case EmissionCategory.travel:
        switch(subtype){
          case 'Gas Car':
            return TravelEmissions.gasCar(distance: amount ?? 0, distanceUnit: distanceUnit, passengers: passengers);
          case 'Electric Car':
            return TravelEmissions.electricCar(distance: amount ?? 0, distanceUnit: distanceUnit, passengers: passengers);
          case 'Hybrid Car':
            return TravelEmissions.hybridCar(distance: amount ?? 0, distanceUnit: distanceUnit);
          case 'Bus':
            return TravelEmissions.bus(distance: amount ?? 0, distanceUnit: distanceUnit, 
            passengerAmt: passengerAmount);
          case 'Light Rail/Tram':
            return TravelEmissions.lightRailTram(distance: amount ?? 0, distanceUnit: distanceUnit, 
            passengerAmt: passengerAmount);
          case 'Train':
            return TravelEmissions.train(distance: amount ?? 0, distanceUnit: distanceUnit, 
            passengerAmt: passengerAmount);
          case 'Ferry: On Foot':
            return TravelEmissions.ferry(distance: amount ?? 0, distanceUnit: distanceUnit, 
            passengerAmt: passengerAmount, onFoot: true);
          case 'Ferry: With a Car':
            return TravelEmissions.ferry(distance: amount ?? 0, distanceUnit: distanceUnit, 
            passengerAmt: passengerAmount, onFoot: false);
          case 'International Flight':
            return TravelEmissions.flight(distance: amount ?? 0, distanceUnit: distanceUnit, 
            size: size, 
              passengerAmt: passengerAmount, isDomestic: false);
          case 'Domestic Flight':
            return TravelEmissions.flight(distance: amount ?? 0, distanceUnit: distanceUnit, 
            size: size, passengerAmt: passengerAmount, isDomestic: true);
        }

      // Add other category cases for emission estimation here
      default:
        return ClothingEmissions.leather(money: amount ?? 0, moneyUnit: moneyUnit);
    }
    //throw StateError('Unsupported category or subtype: $category, $subtype');
    return ClothingEmissions.leather(money: amount ?? 0, moneyUnit: moneyUnit);
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
      amount: amount,
      energyAmount: energyAmount ?? EnergyAmount.average,
      distanceUnit: distanceUnit ?? DistanceUnit.km,
      size: size ?? VehicleSize.medium,
      moneyUnit: moneyUnit ?? MoneyUnit.usd,
      weightUnit: weightUnit ?? WeightUnit.kg,
      passengerAmount: passengerAmount ?? PassengerAmount.average,
      passengers: passengers,
    );

    // Pass the updated entry back to the previous screen and close this view
    Navigator.pop(context, curEntry);
  }

  // method for popping back
  void _onPopInvokedWithResult(bool didPop, dynamic canPop) {
    if (!didPop) {
      Navigator.pop(context);
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
        subtypeMap = EmissionSubtypes().clothingTypes;
    }

    // Update the dropdown menu entries for subtypes
    setState(() {
      subtypeDropdownMenuEntries = subtypeMap.entries
          .map((e) => DropdownMenuEntry<String>(
                value: e.key,
                label: e.key,
                style: const ButtonStyle(foregroundColor: WidgetStatePropertyAll(Color(0xFF386641)))
              ))
          .toList();
        subtype = subtypeMap.entries.first.key;
    });
  }

  // Weight Input Section
  Widget _buildWeightInputSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0), // Increased vertical padding
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Weight input field
              AmountInput(
                initialAmount: amount,
                label: 'Weight:',
                semanticsLabel: 'Enter weight of $subtype below.',
                onChanged: (value) {
                  setState(() {
                    amount = double.tryParse(value) ?? 0;
                    _estimateEmission();
                  });
                }, 
                description: 'Enter weight'
              ),
              const SizedBox(width: 20), // Increased spacing between fields
              // Weight Unit Dropdown
              CustomDropdown<WeightUnit>(
                label: 'Units',
                semanticsLabel: 'Select units of measurement for weight below.',
                onChanged: (WeightUnit? value) {
                  setState(() {
                    weightUnit = value ?? weightUnit;
                    _estimateEmission();
                  });
                },
                value: weightUnit,
                options: WeightUnit.values,
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Checks if an emission estimate can be queried with the currently entered info.
  /// 
  /// Returns true if enough info has been entered. Returns false otherwise.
  bool _canQueryAPI() {
    final EmissionFactor factor = _getEmissionFactor();
    // check if the current emission factor has enough data to send to the API
    return switch (factor) {
      // money emission factors need an amount and currency type
      MoneyEmissionFactor _ => (amount != null && moneyUnit != null),
      
      // weight emission factors need an amount and unit of measurement
      WeightEmissionFactor _ => (amount != null && weightUnit != null),

      // travel emissions differ depending on the subtype
      TravelEmissions _ =>
        // all travel emissions have an amount and distance unit
        switch (amount != null && distanceUnit != null) {
          true => switch (subtype) {
            // hybrid car has no extra parameters
            'Hybrid Car' => true,
            'Gas Car' || 'Electric Car' => (passengers != null),
            'Domestic Flight' || 'International Flight' => (size != null && passengerAmount != null),
            _ => (passengerAmount != null)
          },
          false => false,
        },
      
      // clothing emissions differ depending on the subtype
      ClothingEmissions _ => 
        // all clothing emissions have an amount
        switch (amount != null) {
          // used clothing uses weight, other clothing uses money
          true => (subtype == 'Used Clothing')? (weightUnit != null) : (moneyUnit != null),
          false => false
        },

      // Energy Emissions need an energy amount
      EnergyEmissions _ => (energyAmount != null),

      // unrecognized emission factor
      _ => throw UnsupportedError('Unsupported Emission Factor ${factor.runtimeType}')
    };
  }

  /// Estimates emissions based on the currently inputted information, as long as enough information is provided.
  void _estimateEmission() async {
    EmissionFactor factor = _getEmissionFactor();
    if (_canQueryAPI()) {
      setState(() {
        curEst = 'Getting Estimate...';
      });
      EmissionEstimate? estimate = await checker.getEmissions(factor);

      // Make sure a valid response is returned
      if (estimate != null) {
        // if passengerAmount is set, calculate personal contribution to emissions
        if (passengerAmount != null) {
          final double totalCo2 = estimate.co2;
          final int totalPassengers = (factor as TravelEmissions).passengers ?? 1;
          final double personalEmissions = totalCo2 / totalPassengers;
          estimate = EmissionEstimate(co2: personalEmissions, unit: 'kg');

          comparisonEstimate = await checker.getEmissions(
            TravelEmissions.gasCar(
              distance: factor.distance, 
              distanceUnit: factor.distanceUnit, 
              passengers: 1
            )
          );

        }
        final double roundedCo2 = (estimate.co2 * 1000).round() / 1000;
        final String estimateUnit = estimate.unit;
        setState(() {
          curEst = '$roundedCo2 $estimateUnit emitted';
          co2 = roundedCo2;
        });
      } else {
        setState(() {
          curEst = 'Please try again later';
        });
      }
    } else {
      setState(() {
        curEst = 'N/A';
        co2 = 0;
      });
    }
  }

  // Money Input Section
  Widget _buildMoneyInputSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0), // Increased vertical padding
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Money input field
          AmountInput(
            initialAmount: amount ?? 0,
            label: 'Amount spent:',
            semanticsLabel: 'Enter amount spent on $subtype below.',
            onChanged: (value) {
              setState(() {
                amount = double.tryParse(value) ?? 0;
                _estimateEmission();
              });
            }, 
            description: 'Enter amount'
          ),
          const SizedBox(width: 20), // Increased spacing between fields
          // Money Unit Dropdown
          CustomDropdown<MoneyUnit>(
            label: 'Currency:',
            semanticsLabel: 'Select type of currency below',
            onChanged: (MoneyUnit? value) {
              setState(() {
                moneyUnit = value ?? moneyUnit;
                _estimateEmission();
              });
            }, 
            value: moneyUnit, 
            options: MoneyUnit.values,
          ),
        ],
      ),
    );
  }

  // Energy Input Section
  Widget _buildEnergyInputSection() {
    return Column(
      children: [
        Theme(
          data: Theme.of(context).copyWith(
            canvasColor: const Color.fromARGB(255, 224, 214, 186), // Background color when dropdown is open
          ),
          child: CustomDropdown<EnergyAmount>(
            label: 'How much energy did you use?',
            semanticsLabel: 'Select how much energy you used below.',
            onChanged: (EnergyAmount? value) {
              setState(() {
                energyAmount = value!;
                _estimateEmission();
              });
            }, 
            value: energyAmount, 
            options: EnergyAmount.values,
            width: 300
          ),
        ),
      ],
    );
  }

  // Travel Input Section
  Widget _buildTravelInputSection(String subtype) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AmountInput(
              initialAmount: amount ?? 0,
              label: 'Distance:',
              semanticsLabel: 'Enter distance travelled by $subtype below.',
              onChanged: (value) {
                setState(() {
                  amount = double.tryParse(value) ?? 0;
                  _estimateEmission();
                });
              }, 
              description: 'Distance'
            ),
            const SizedBox(width: 20),
            // Distance Unit Dropdown
            CustomDropdown<DistanceUnit>(
              label: 'Units',
              onChanged: (DistanceUnit? value) {
                setState(() {
                  distanceUnit = value ?? distanceUnit;
                  _estimateEmission();
                });
              },
              value: distanceUnit, 
              options: DistanceUnit.values
            ),
          ],
        ),
        const SizedBox(height: 20,),
        // Distance input field
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(height: 20), // Increased spacing between dropdowns
            // Passenger Amount Dropdown
            if (subtype == 'Gas Car' || subtype == 'Electric Car') ...[
              AmountInput(
                initialAmount: double.tryParse('$passengers') ?? 0,
                label: '# of Passengers:',
                semanticsLabel: 'Enter number of passengers below.',
                description: 'Passengers',
                onChanged: (value) {
                  setState(() {
                    passengers = int.tryParse(value) ?? 0;
                    // set passenger amount ot null
                    passengerAmount = null;
                  });
                  _estimateEmission();
                },
              ),
            ] else if (subtype == 'Hybrid Car') ...[
              // Hybrid car displays nothing here
              // It requries no additional passenger information
            ] else ...[
              CustomDropdown<PassengerAmount>(
                label: 'How full was\nthe ride?',
                semanticsLabel: 'Select approximately how full the vehicle was below.',
                width: 156,
                onChanged: (PassengerAmount? value) {
                  setState(() {
                    passengerAmount = value!;
                  });
                  _estimateEmission();
                }, 
                // hintFontSize: 10,
                value: passengerAmount, 
                options: PassengerAmount.values,
              ),
            ],
    
            const SizedBox(width: 20,),
    
            if (subtype == 'International Flight' || subtype == 'Domestic Flight') ...[
              CustomDropdown<VehicleSize>(
                label: 'Plane size:',
                width: 150,
                semanticsLabel: 'Select the size of your plane below',
                onChanged: (VehicleSize? value) {
                  setState(() {
                    size = value!;
                    _estimateEmission();
                  });
                }, 
                value: size, 
                options: VehicleSize.values
              ),
            ]
          ],
        )
      ],
    );
  }

  /// Shows Info Dialog that tells users more info about their emission estimate.
  void _showInfoDialog(BuildContext context, EmissionFactor factor) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFF2E8CF), // Same background as the app
          title: const Text(
            'About Your Emission Estimate',
            style: TextStyle(color: Colors.black), // Black title text
          ),
          content: SingleChildScrollView(
            child: switch (category) {
              EmissionCategory.clothing => const ClothingInfo(),
              EmissionCategory.energy => const EnergyInfo(),
              EmissionCategory.food => const FoodInfo(),
              EmissionCategory.furniture => const FurnitureInfo(),
              EmissionCategory.personalCareAndAccessories => const PersonalCareInfo(),
              EmissionCategory.travel => TravelInfo(comparison: comparisonEstimate, subtype: subtype,),
              EmissionCategory.foodWaste || EmissionCategory.generalWaste || EmissionCategory.electricalWaste => const WasteInfo(),
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Close',
                style: TextStyle(color: Color(0xFF386641)), // Green for "Close"
              ),
            ),
          ],
        );
      },
    );
  }
}