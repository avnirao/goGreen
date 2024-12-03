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
              Text('Track your emissions here!', style: TextStyle(color: Color(0xFF386641)),), // app bar title
            ],
          ),
        ),
        body:
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10,),
              // first row of the page, two drop down menus and one date selector
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Dropdown for category selection
                  SizedBox(
                    width: 170, // Set uniform width for dropdown and button
                    child: DropdownMenu<EmissionCategory>(
                      initialSelection: category, // default to be clothing
                      dropdownMenuEntries: dropdownMenuEntries,
                      onSelected: (EmissionCategory? value) {
                        setState(() {
                          String tempValue = value.toString();
                          switch(tempValue){
                            case 'Clothing': 
                              category = EmissionCategory.clothing;
                            case 'Energy':
                              category = EmissionCategory.energy;
                            case 'Furniture':
                              category = EmissionCategory.furniture;
                            case 'Personal Care And Accessories':
                              category = EmissionCategory.personalCareAndAccessories;
                            case 'Travel':
                              category = EmissionCategory.travel;
                            case 'Food Waste':
                              category = EmissionCategory.foodWaste;
                            case 'Genaral Waste':
                              category = EmissionCategory.generalWaste;
                            case 'Electrical Waste':
                              category = EmissionCategory.electricalWaste;
                            case 'Food':
                              category = EmissionCategory.food;
                          }
                        });
                        _updateSubtypeDropdown(value ?? EmissionCategory.clothing); // default subtype leather
                      },
                      textStyle: const TextStyle(color: Color(0xFF386641), fontWeight: FontWeight.bold), // text in the selected box
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
                  // Dropdown for subtype selection
                  SizedBox(
                    width: 170, // Set uniform width for dropdown and button
                    child: DropdownMenu<String>(
                      initialSelection: subtype, //default to be leather here
                      dropdownMenuEntries: subtypeDropdownMenuEntries,
                      onSelected: (String? value) {
                        setState(() {
                          subtype = value ?? 'Leather';
                        });
                      },
                      textStyle: const TextStyle(color: Color(0xFF386641), fontWeight: FontWeight.bold),
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

              
              // notes field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Notes:', style: TextStyle(color: Color(0xFF386641), fontSize: 15), semanticsLabel: 'Enter notes below',),
                  SizedBox(
                    width: 300,
                    height: 100,
                    child: TextFormField(
                      maxLines: 10,
                      initialValue: notes,
                      onChanged: (value) { setState(() => notes = value); },
                      decoration: InputDecoration( // controls input text style
                        labelStyle: TextStyle(color: Colors.grey.shade800),
                        filled: true,
                        fillColor: const Color.fromARGB(52, 193, 185, 102),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // estimate button
              SizedBox(
                width: 160,
                height: 80,
                child: ElevatedButton(
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
                        curEst = 'Please try again later';
                      });
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(10.0), // Padding for better appearance
                    child: Text(
                      'Estimate\nEmission',
                      style: TextStyle(fontSize: 19),
                      semanticsLabel: 'Estimate Emission Button',
                    ),
                  ),
                ),
              ),
            
            const SizedBox(height: 20),

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
                semanticsLabel: 'Estimate: $curEst',
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                ),
              ),
            ),
            
            const SizedBox(height: 20),

            // Save Button
            SizedBox(
              width: 200,
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
                  padding: EdgeInsets.all(10.0), // Padding for better appearance
                  child: Text(
                    'Save',
                    semanticsLabel: 'Save',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
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
            return ClothingEmissions.leather(money: amount ?? 0, moneyUnit: moneyUnit ?? MoneyUnit.usd);
          case 'Footwear':
            return ClothingEmissions.footwear(money: amount ?? 0, moneyUnit: moneyUnit ?? MoneyUnit.usd);
          case 'New Clothing':
            return ClothingEmissions.newClothing(money: amount ?? 0, moneyUnit: moneyUnit ?? MoneyUnit.usd);
          case 'Infant Clothing':
            return ClothingEmissions.infantClothing(money: amount ?? 0, moneyUnit: moneyUnit ?? MoneyUnit.usd);
          case 'Used Clothing':
            return ClothingEmissions.usedClothing(weight: amount ?? 0, weightUnit: weightUnit ?? WeightUnit.kg);
        }
      case EmissionCategory.electricalWaste:
        return ElectricalWasteEmissions(weight: amount ?? 0, weightUnit: WeightUnit.kg, electricalWasteType: subtype);
      case EmissionCategory.energy:
        switch(subtype) {
          case 'Electricity':
            return EnergyEmissions.electricity(energy: energyAmount ?? EnergyAmount.average);
          case 'Natural Gas':
            return EnergyEmissions.naturalGas(volume: energyAmount ?? EnergyAmount.average);
        }
      case EmissionCategory.food:
        return FoodEmissions(foodType: subtype, money: amount ?? 0, moneyUnit: moneyUnit ?? MoneyUnit.usd);
      case EmissionCategory.foodWaste:
        return FoodWasteEmissions(foodWasteType: subtype, weight: amount ?? 0, weightUnit: weightUnit ?? WeightUnit.kg);
      case EmissionCategory.furniture:
        return FurnitureEmissions(furnitureType: subtype, money: amount ?? 0, moneyUnit: moneyUnit ?? MoneyUnit.usd);
      case EmissionCategory.generalWaste:
        return GeneralWasteEmissions(wasteType: subtype, weight: amount ?? 0, weightUnit: weightUnit ?? WeightUnit.kg);
      case EmissionCategory.personalCareAndAccessories:
        return PersonalCareEmissions(money: amount ?? 0, moneyUnit: moneyUnit ?? MoneyUnit.usd, personalCareType: subtype);
      case EmissionCategory.travel:
        switch(subtype){
          case 'Gas Car':
            return TravelEmissions.gasCar(distance: amount ?? 0, distanceUnit: distanceUnit ?? DistanceUnit.km, passengers: passengers);
          case 'Electric Car':
            return TravelEmissions.electricCar(distance: amount ?? 0, distanceUnit: distanceUnit ?? DistanceUnit.km, passengers: passengers);
          case 'Hybrid Car':
            return TravelEmissions.hybridCar(distance: amount ?? 0, distanceUnit: distanceUnit ?? DistanceUnit.km);
          case 'Bus':
            return TravelEmissions.bus(distance: amount ?? 0, distanceUnit: distanceUnit ?? DistanceUnit.km, 
            passengerAmt: passengerAmount ?? PassengerAmount.average);
          case 'Light Rail/Tram':
            return TravelEmissions.lightRailTram(distance: amount ?? 0, distanceUnit: distanceUnit ?? DistanceUnit.km, 
            passengerAmt: passengerAmount ?? PassengerAmount.average);
          case 'Train':
            return TravelEmissions.train(distance: amount ?? 0, distanceUnit: distanceUnit ?? DistanceUnit.km, 
            passengerAmt: passengerAmount ?? PassengerAmount.average);
          case 'Ferry: On Foot':
            return TravelEmissions.ferry(distance: amount ?? 0, distanceUnit: distanceUnit ?? DistanceUnit.km, 
            passengerAmt: passengerAmount ?? PassengerAmount.average, onFoot: true);
          case 'Ferry: With a Car':
            return TravelEmissions.ferry(distance: amount ?? 0, distanceUnit: distanceUnit ?? DistanceUnit.km, 
            passengerAmt: passengerAmount ?? PassengerAmount.average, onFoot: false);
          case 'International Flight':
            return TravelEmissions.flight(distance: amount ?? 0, distanceUnit: distanceUnit ?? DistanceUnit.km, 
            size: size ?? VehicleSize.medium, 
              passengerAmt: passengerAmount ?? PassengerAmount.average, isDomestic: false);
          case 'Domestic Flight':
            return TravelEmissions.flight(distance: amount ?? 0, distanceUnit: distanceUnit ?? DistanceUnit.km, 
            size: size ?? VehicleSize.medium, passengerAmt: passengerAmount ?? PassengerAmount.average, isDomestic: true);
        }

      // Add other category cases for emission estimation here
      default:
        return ClothingEmissions.leather(money: amount ?? 0, moneyUnit: moneyUnit ?? MoneyUnit.usd);
    }
    //throw StateError('Unsupported category or subtype: $category, $subtype');
    return ClothingEmissions.leather(money: amount ?? 0, moneyUnit: moneyUnit ?? MoneyUnit.usd);
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Weight input field
          SizedBox(
            width: 140,
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Weight',
                labelStyle: const TextStyle(color: Color(0xFF386641),fontWeight: FontWeight.bold),
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
          const SizedBox(width: 20), // Increased spacing between fields
          // Weight Unit Dropdown
          SizedBox(
            width: 144,
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
                hint: const Text('Weight Unit', style: TextStyle(color: Color(0xFF386641),fontWeight: FontWeight.bold)),
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
                              color: Color(0xFF386641), // Set text color for dropdown items
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Money Input Section
  Widget _buildMoneyInputSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0), // Increased vertical padding
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Money input field
          SizedBox(
            width: 140, 
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Enter amount',
                labelStyle: const TextStyle(color: Color(0xFF386641),fontWeight: FontWeight.bold),
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
          const SizedBox(width: 20), // Increased spacing between fields
          // Money Unit Dropdown
          SizedBox(
            width: 180,
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
                hint: const Text('Select Currency', style: TextStyle(color: Color(0xFF386641),fontWeight: FontWeight.bold),),
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
                            unit.toString().split('.').last,
                            style: const TextStyle(
                              color: Color(0xFF386641), // Set text color for dropdown items
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
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
              child:
                  SizedBox(
                    width: 300,
                    // energy dropdown
                    child: DropdownButtonFormField<EnergyAmount>(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color.fromARGB(255, 234, 224, 198), // Dropdown button fill color
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0), // Rounded corners
                          borderSide: BorderSide.none,
                        ),
                      ),
                      hint: const Text('Energy used', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF386641)), ),
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
                                  unit.toString().split('.').last,
                                  style: const TextStyle(
                                    color: Color(0xFF386641), // Set text color for dropdown items
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
              ),
          ],
    );
  }

  // Travel Input Section
  Widget _buildTravelInputSection(String subtype) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0), // Increased vertical padding
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 140, // Set a uniform width
                //distance enter box
                child: TextField(
                  style: const TextStyle(color: Color(0xFF386641)),
                  decoration: InputDecoration(
                    labelText: 'Distance',
                    labelStyle: const TextStyle(color: Color(0xFF386641),fontWeight: FontWeight.bold),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 234, 224, 198),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0), 
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
              const SizedBox(width: 20),
              // Distance Unit Dropdown
              SizedBox(
                width: 159,
                child: Theme(
                  data: Theme.of(context).copyWith(
                    canvasColor: const Color.fromARGB(255, 224, 214, 186), // Background color when dropdown is open
                  ),
                  child: DropdownButtonFormField<DistanceUnit>(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromARGB(255, 234, 224, 198), // Dropdown button fill color
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    hint: const Text('Distance Unit', style: TextStyle(color: Color(0xFF386641),fontWeight: FontWeight.bold)),
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
                                  color: Color(0xFF386641), // Set text color for dropdown items
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20,),
          // Distance input field
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (subtype == 'Gas Car' || subtype == 'Electric Car' || subtype == 'Bus' ||
              subtype == 'Light Rail/Tram' || subtype == 'Train' ||
              subtype == 'Ferry: On Foot' || subtype == 'Ferry: With a Car' 
              || subtype == 'International Flight' || subtype == 'Domestic Flight')
            ...[
              const SizedBox(height: 20), // Increased spacing between dropdowns
              // Passenger Amount Dropdown
              SizedBox(
                width: 150,
                child: Theme(
                  data: Theme.of(context).copyWith(
                    canvasColor: const Color.fromARGB(255, 224, 214, 186), // Background color when dropdown is open
                  ),
                  child: DropdownButtonFormField<PassengerAmount>(
                    style: const TextStyle(color: Color(0xFF386641)),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromARGB(255, 234, 224, 198), // Dropdown button fill color
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0), // Rounded corners
                        borderSide: BorderSide.none,
                      ),
                    ),
                    hint: const Text('Passenger\nAmount',  style: TextStyle(color: Color(0xFF386641), fontSize: 10, fontWeight: FontWeight.bold)),
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
                                  color: Color(0xFF386641), // Set text color for dropdown items
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ),
            ],
          const SizedBox(width: 20,),
          if (subtype == 'International Flight' || subtype == 'Domestic Flight')
            SizedBox(
                width: 170,
                child: Theme(
                  data: Theme.of(context).copyWith(
                    canvasColor: const Color.fromARGB(255, 224, 214, 186), // Background color when dropdown is open
                  ),
                  //dropdown for vehicle size
                  child: DropdownButtonFormField<VehicleSize>(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromARGB(255, 234, 224, 198), // Dropdown button fill color
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0), // Rounded corners
                        borderSide: BorderSide.none,
                      ),
                    ),
                    hint: const Text('Vehicle Size',  style: TextStyle(color: Color(0xFF386641), fontSize: 13, fontWeight: FontWeight.bold)),
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
                                  color: Color(0xFF386641), // Set text color for dropdown items
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}