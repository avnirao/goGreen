import 'dart:core';
import 'package:flutter/material.dart';
import 'package:go_green/climatiq_api/emission_checker.dart';
import 'package:go_green/climatiq_api/emission_estimate.dart';
import 'package:go_green/models/emission_data/emission_data_enums.dart';
import 'package:go_green/models/emission_data/emission_subtypes.dart';
import 'package:go_green/models/emission_factors/base_emission_factors/emission_factors.dart';
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
import 'package:intl/intl.dart';


/// A StatefulWidget that displays and allows editing of a single Entry.
class EntryView extends StatefulWidget{
  final Entry curEntry;

  const EntryView({super.key, required this.curEntry});

  @override
  State<EntryView> createState() => _EntryViewState();
}

class _EntryViewState extends State<EntryView>{

  List<DropdownMenuEntry<EmissionCategory>> dropdownMenuEntries = EmissionCategory.values.map((category) {
    return DropdownMenuEntry<EmissionCategory>(value: category, label: category.toString(), );
  }).toList();

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

  // for clothing
  double amount = 0;
  MoneyUnit moneyUnit = MoneyUnit.usd;
  WeightUnit weightUnit = WeightUnit.kg;
  String curEst = 'N/A';

  // for electrical waste

  // for energy
  EnergyAmount energyAmount = EnergyAmount.average;

  // for travel
  DistanceUnit distanceUnit = DistanceUnit.km;
  int passengers = 0;
  PassengerAmount passengerAmount = PassengerAmount.average;
  VehicleSize size = VehicleSize.medium;
  bool isDomestic = true;

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
          title: const Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.eco, color: Color(0xFF6A994E)), // Leaf icon for GoGreen theme
              SizedBox(width: 8),
              Text('Emission Tracker', style: TextStyle(color: Color(0xFF386641)),),
            ],
            
          ),
        ),
        body:
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10), 
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // first row of the page, two drop down menus and one date selector
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Dropdown for category selection
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Category:', style: TextStyle(color: Color(0xFF386641), fontSize: 20),),
                            ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 200), // Set uniform width for dropdown and button
                              child: DropdownMenu<EmissionCategory>(
                                initialSelection: category,
                                dropdownMenuEntries: dropdownMenuEntries,
                                onSelected: (EmissionCategory? value) {
                                  setState(() {
                                    category = value ?? EmissionCategory.clothing;
                                  });
                                  _updateSubtypeDropdown(value ?? EmissionCategory.clothing);
                                },
                                inputDecorationTheme: InputDecorationTheme(
                                  filled: true,
                                  fillColor: const Color.fromARGB(255, 234, 224, 198), // Background color
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0), // Rounded corners
                                    borderSide: BorderSide.none, // Remove border
                                  ),
                                ),
                                menuStyle: MenuStyle(
                                  backgroundColor: WidgetStateProperty.all<Color>(const Color.fromARGB(255, 224, 214, 186)), // Menu background color
                                  elevation: WidgetStateProperty.all<double>(5.0), // Elevation for shadow
                                  padding: WidgetStateProperty.all<EdgeInsets>(
                                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      // Dropdown for subtype selection
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Type:', style: TextStyle(color: Color(0xFF386641), fontSize: 20),),
                            ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 200), // Set uniform width for dropdown and button
                              child: DropdownMenu<String>(
                                initialSelection: subtype,
                                dropdownMenuEntries: subtypeDropdownMenuEntries,
                                onSelected: (String? value) {
                                  setState(() {
                                    subtype = value ?? 'Leather';
                                  });
                                },
                                inputDecorationTheme: InputDecorationTheme(
                                  filled: true,
                                  fillColor: const Color.fromARGB(255, 234, 224, 198), // Background color
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0), // Rounded corners
                                    borderSide: BorderSide.none, // Remove border
                                  ),
                                ),
                                menuStyle: MenuStyle(
                                  backgroundColor: WidgetStateProperty.all<Color>(const Color(0xFFF2E8CF)), // Menu background color
                                  elevation: WidgetStateProperty.all<double>(5.0), // Elevation for shadow
                                  padding: WidgetStateProperty.all<EdgeInsets>(
                                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
              
                  // Dropdown for category selection
                  
                  const SizedBox(height: 20),
                  // selections for differenct categories
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 10),
                      if (category == EmissionCategory.clothing)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (subtype == 'Used Clothing')
                              _buildWeightInputSection()
                            else
                              _buildMoneyInputSection(),
                          ],
                        )
                      else if (category == EmissionCategory.electricalWaste)
                        _buildWeightInputSection()
                      else if (category == EmissionCategory.energy)
                        _buildEnergyInputSection()
                      else if (category == EmissionCategory.food)
                        _buildMoneyInputSection()
                      else if (category == EmissionCategory.foodWaste)
                        _buildWeightInputSection()
                      else if (category == EmissionCategory.furniture)
                        _buildMoneyInputSection()
                      else if (category == EmissionCategory.generalWaste)
                        _buildWeightInputSection()
                      else if (category == EmissionCategory.personalCareAndAccessories)
                        _buildMoneyInputSection()
                      else if (category == EmissionCategory.travel)
                        _buildTravelInputSection(subtype),
                    ],
                  ),

                  const SizedBox(height: 30),
                  
                  // Date selector button
                  Row(
                    children: [
                      const Text('Select Date:', style: TextStyle(color: Color(0xFF386641), fontSize: 20),),
                      const SizedBox(width: 10,),
                      ConstrainedBox(
                        constraints: const BoxConstraints(minWidth: 100), // Set uniform width for dropdown and button
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
                            DateFormat.yMd().format(emissionsDate),
                            style: const TextStyle(
                              color: Colors.black, // Font color for added emphasis
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
              
                  const SizedBox(height: 30),
              
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 234, 224, 198), // Button background color
                      foregroundColor: const Color(0xFF386641), // Text color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0), // Rounded corners
                      ),
                    ),
                    onPressed: () async {
                      EmissionEstimate? estimate = await checker.getEmissions(_estimateEmission());
                      if (estimate != null) {
                        setState(() {
                          curEst = estimate.toString();
                          co2 = estimate.co2;
                        });
                      } else {
                        setState(() {
                          curEst = 'failed';
                        });
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(10.0), // Padding for better appearance
                      child: Text(
                        'Estimate Emission',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                
                const SizedBox(height: 30),
              
                // Box to Display Estimated Emission
                Container(
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 224, 214, 186), // Background color
                    borderRadius: BorderRadius.circular(15.0), // Rounded corners
                    border: Border.all(
                      color: const Color(0xFF386641),
                      width: 1.5,
                    ),
                  ),
                  child: Text(
                    'Estimate: $curEst',
                    style: const TextStyle(
                      fontSize: 32,
                      color: Colors.black,
                    ),
                  ),
                ),
              
                const SizedBox(height: 30),
              
                // Save Button
                SizedBox(
                  width: 400,
                  height: 100,
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
                      padding: EdgeInsets.all(10.0), // Padding for better appearance
                      child: Text(
                        'Save',
                        style: TextStyle(fontSize: 32),
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
  EmissionFactor _estimateEmission() {
    print('getting emission estimate: $category, $subtype');
    switch (category) {
      // clothing case
      case EmissionCategory.clothing:
        switch (subtype) {
          case 'Leather':
          print('returning: $category, $subtype');
            return ClothingEmissions.leather(money: amount, moneyUnit: moneyUnit);
          case 'Footwear':
            return ClothingEmissions.footwear(money: amount, moneyUnit: moneyUnit);
          case 'New Clothing':
            return ClothingEmissions.newClothing(money: amount, moneyUnit: moneyUnit);
          case 'Infant Clothing':
            return ClothingEmissions.infantClothing(money: amount, moneyUnit: moneyUnit);
          case 'Used Clothing':
            return ClothingEmissions.usedClothing(weight: amount, weightUnit: weightUnit);
        }
      case EmissionCategory.electricalWaste:
        return ElectricalWasteEmissions(weight: amount, weightUnit: weightUnit, electricalWasteType: subtype);
      case EmissionCategory.energy:
        switch(subtype) {
          case 'Electricity':
            return EnergyEmissions.electricity(energy: energyAmount);
          case 'Natural Gas':
            return EnergyEmissions.naturalGas(volume: energyAmount);
        }
      case EmissionCategory.food:
        return FoodEmissions(foodType: subtype, money: amount, moneyUnit: moneyUnit);
      case EmissionCategory.foodWaste:
        return FoodWasteEmissions(foodWasteType: subtype, weight: amount, weightUnit: weightUnit);
      case EmissionCategory.furniture:
        return FurnitureEmissions(furnitureType: subtype, money: amount, moneyUnit: moneyUnit);
      case EmissionCategory.generalWaste:
        return GeneralWasteEmissions(wasteType: subtype, weight: amount, weightUnit: weightUnit);
      case EmissionCategory.personalCareAndAccessories:
        return PersonalCareEmissions(money: amount, moneyUnit: moneyUnit, personalCareType: subtype);
      case EmissionCategory.travel:
        switch(subtype){
          case 'Gas Car':
            return TravelEmissions.gasCar(distance: amount, distanceUnit: distanceUnit, passengers: passengers);
          case 'Electric Car':
            return TravelEmissions.electricCar(distance: amount, distanceUnit: distanceUnit, passengers: passengers);
          case 'Hybrid Car':
            return TravelEmissions.hybridCar(distance: amount, distanceUnit: distanceUnit);
          case 'Bus':
            return TravelEmissions.bus(distance: amount, distanceUnit: distanceUnit, passengerAmt: passengerAmount);
          case 'Light Rail/Tram':
            return TravelEmissions.lightRailTram(distance: amount, distanceUnit: distanceUnit, passengerAmt: passengerAmount);
          case 'Train':
            return TravelEmissions.train(distance: amount, distanceUnit: distanceUnit, passengerAmt: passengerAmount);
          case 'Ferry: On Foot':
            return TravelEmissions.ferry(distance: amount, distanceUnit: distanceUnit, passengerAmt: passengerAmount, onFoot: true);
          case 'Ferry: With a Car':
            return TravelEmissions.ferry(distance: amount, distanceUnit: distanceUnit, passengerAmt: passengerAmount, onFoot: false);
          case 'International Flight':
            return TravelEmissions.flight(distance: amount, distanceUnit: distanceUnit, size: size, 
              passengerAmt: passengerAmount, isDomestic: false);
          case 'Domestic Flight':
            return TravelEmissions.flight(distance: amount, distanceUnit: distanceUnit, size: size, 
              passengerAmt: passengerAmount, isDomestic: true);
        }

      // Add other category cases for emission estimation here
      default:
        // return ClothingEmissions.usedClothing(weight: amount, weightUnit: weightUnit);
        throw StateError('Unsupported category or subtype: $category, $subtype');
    }
    throw StateError('Unsupported category or subtype: $category, $subtype');
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

  // method for popping back
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
      subtype = subtypeMap.entries.first.key;
    });
  }

  // Weight Input Section
  // Weight Input Section
  Widget _buildWeightInputSection() {
    return Row(
      children: [
        // Weight input field
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Weight:', style: TextStyle(color: Color(0xFF386641), fontSize: 20),),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 200), // Set a uniform width
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Enter Weight...',
                    filled: true,
                    fillColor: const Color.fromARGB(255, 234, 224, 198),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0), // Rounded corners
                      borderSide: BorderSide.none,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      amount = double.tryParse(value) ?? 0;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10), // Increased spacing between fields
        // Weight Unit Dropdown
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Units:', style: TextStyle(color: Color(0xFF386641), fontSize: 20),),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 200),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    canvasColor: const Color.fromARGB(255, 224, 214, 186), // Background color when dropdown is open
                  ),
                  child: DropdownButtonFormField<WeightUnit>(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromARGB(255, 234, 224, 198), // Dropdown button fill color
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0), // Rounded corners
                        borderSide: BorderSide.none,
                      ),
                    ),
                    hint: const Text('Weight Unit'),
                    value: weightUnit,
                    onChanged: (WeightUnit? value) {
                      setState(() {
                        weightUnit = value ?? weightUnit;
                      });
                    },
                    items: WeightUnit.values
                        .map((unit) => DropdownMenuItem<WeightUnit>(
                              value: unit,
                              child: Text(
                                unit.toString().split('.').last,
                                style: const TextStyle(
                                  color: Colors.black, // Set text color for dropdown items
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Money Input Section
  Widget _buildMoneyInputSection() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Money input field
              const Text('Amount Spent:', style: TextStyle(color: Color(0xFF386641), fontSize: 20),),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 200), 
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Enter Amount...',
                    filled: true,
                    fillColor: const Color.fromARGB(255, 234, 224, 198),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0), // Rounded corners
                      borderSide: BorderSide.none,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      amount = double.tryParse(value) ?? 0;
                    });
                  },
                ),
              ),
            ]
          ),
        ),
        const SizedBox(width: 10,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const SizedBox(height: 70), // Increased spacing between fields
              // Money Unit Dropdown
              const Text('Currency:', style: TextStyle(color: Color(0xFF386641), fontSize: 20),),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 200), 
                child: Theme(
                  data: Theme.of(context).copyWith(
                    canvasColor: const Color.fromARGB(255, 224, 214, 186), // Background color when dropdown is open
                  ),
                  child: DropdownButtonFormField<MoneyUnit>(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromARGB(255, 234, 224, 198), // Dropdown button fill color
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0), // Rounded corners
                        borderSide: BorderSide.none,
                      ),
                    ),
                    hint: const Text('Money Unit'),
                    value: moneyUnit,
                    onChanged: (MoneyUnit? value) {
                      setState(() {
                        moneyUnit = value ?? moneyUnit;
                      });
                    },
                    items: MoneyUnit.values
                        .map((unit) => DropdownMenuItem<MoneyUnit>(
                              value: unit,
                              child: Text(
                                unit.name.toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.black, // Set text color for dropdown items
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Energy Input Section
  Widget _buildEnergyInputSection() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('How much energy did you use?', style: TextStyle(color: Color(0xFF386641), fontSize: 20),),
              ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 200),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    canvasColor: const Color.fromARGB(255, 224, 214, 186), // Background color when dropdown is open
                  ),
                  child: DropdownButtonFormField<EnergyAmount>(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromARGB(255, 234, 224, 198), // Dropdown button fill color
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0), // Rounded corners
                        borderSide: BorderSide.none,
                      ),
                    ),
                    hint: const Text('Energy used'),
                    value: energyAmount,
                    onChanged: (EnergyAmount? value) {
                      setState(() {
                        energyAmount = value!;
                      });
                    },
                    items: EnergyAmount.values
                        .map((unit) => DropdownMenuItem<EnergyAmount>(
                              value: unit,
                              child: Text(
                                unit.toString(),
                                style: const TextStyle(
                                  color: Colors.black, // Set text color for dropdown items
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ),
            ],
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
          children: [
            // Distance input field
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Distance Traveled:', style: TextStyle(color: Color(0xFF386641), fontSize: 20),),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 200), // Set a uniform width
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Enter Distance...',
                        filled: true,
                        fillColor: const Color.fromARGB(255, 234, 224, 198),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0), // Rounded corners
                          borderSide: BorderSide.none,
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          amount = double.tryParse(value) ?? 0;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10), // Increased spacing between fields
            // Distance Unit Dropdown
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('\nUnits:', style: TextStyle(color: Color(0xFF386641), fontSize: 20),),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 200),
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        canvasColor: const Color.fromARGB(255, 224, 214, 186), // Background color when dropdown is open
                      ),
                      child: DropdownButtonFormField<DistanceUnit>(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color.fromARGB(255, 234, 224, 198), // Dropdown button fill color
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0), // Rounded corners
                            borderSide: BorderSide.none,
                          ),
                        ),
                        hint: const Text('Distance Unit'),
                        value: distanceUnit,
                        onChanged: (DistanceUnit? value) {
                          setState(() {
                            distanceUnit = value ?? distanceUnit;
                          });
                        },
                        items: DistanceUnit.values
                            .map((unit) => DropdownMenuItem<DistanceUnit>(
                                  value: unit,
                                  child: Text(
                                    unit.toString().split('.').last,
                                    style: const TextStyle(
                                      color: Colors.black, // Set text color for dropdown items
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          children: [
            // If a flight is selected, allow user to choose vehicle size
            switch(subtype) {
              'International Flight' || 'Domestic Flight' => Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Vehicle Size:', style: TextStyle(color: Color(0xFF386641), fontSize: 20),),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 200),
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          canvasColor: const Color.fromARGB(255, 224, 214, 186), // Background color when dropdown is open
                        ),
                        child: DropdownButtonFormField<VehicleSize>(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color.fromARGB(255, 234, 224, 198), // Dropdown button fill color
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0), // Rounded corners
                              borderSide: BorderSide.none,
                            ),
                          ),
                          hint: const Text('Vehicle Size'),
                          value: size,
                          onChanged: (VehicleSize? value) {
                            setState(() {
                              size = value!;
                            });
                          },
                          items: VehicleSize.values
                              .map((unit) => DropdownMenuItem<VehicleSize>(
                                    value: unit,
                                    child: Text(
                                      unit.toString().split('.').last,
                                      style: const TextStyle(
                                        color: Colors.black, // Set text color for dropdown items
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              _ => Container()
            },
            const SizedBox(width: 10),
            // If a car is selected, allow user to chose number of passengers (except hybrid car, which doesn't require a passenger number)
            switch(subtype) {
              'Hybrid Car' => Container(),
              'Gas Car' || 'Electric Car' => Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('# of Passengers:', style: TextStyle(color: Color(0xFF386641), fontSize: 20),),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 200), // Set a uniform width
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Passengers...',
                          filled: true,
                          fillColor: const Color.fromARGB(255, 234, 224, 198),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0), // Rounded corners
                            borderSide: BorderSide.none,
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            passengers = int.tryParse(value) ?? 0;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            // Otherwise, allow them to estimate how full the vehicle was.
              _ => Flexible(
                fit: FlexFit.loose,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('# of passengers:', style: TextStyle(color: Color(0xFF386641), fontSize: 20),),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 200),
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          canvasColor: const Color.fromARGB(255, 224, 214, 186), // Background color when dropdown is open
                        ),
                        child: DropdownButtonFormField<PassengerAmount>(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color.fromARGB(255, 234, 224, 198), // Dropdown button fill color
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0), // Rounded corners
                              borderSide: BorderSide.none,
                            ),
                          ),
                          hint: const Text('# of Passengers'),
                          value: passengerAmount,
                          onChanged: (PassengerAmount? value) {
                            setState(() {
                              passengerAmount = value!;
                            });
                          },
                          items: PassengerAmount.values
                              .map((unit) => DropdownMenuItem<PassengerAmount>(
                                    value: unit,
                                    child: Text(
                                      unit.toString().split('.').last,
                                      style: const TextStyle(
                                        color: Colors.black, // Set text color for dropdown items
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            }
            // Passenger Amount Dropdown
            
          ],
        )
      ],
    );
  }
}