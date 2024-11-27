import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:go_green/models/activity_history.dart';
import 'package:go_green/models/recycling_center_db.dart';
import 'package:go_green/providers/activity_provider.dart';
import 'package:go_green/views/home_page.dart';
import 'package:provider/provider.dart';
import 'providers/position_provider.dart';
import 'views/map_view.dart';

// Load the recycling center database from the JSON file
Future<RecyclingCentersDB> loadRecyclingDB(String dataPath) async {
  return RecyclingCentersDB.initializeFromJson(await rootBundle.loadString(dataPath));
}

void main() {
  // Path to the JSON file containing the recycling center data
  const dataPath = 'assets/locations.json';
  // Ensure that the WidgetsBinding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Load the recycling center database and run the app
  loadRecyclingDB(dataPath).then((value) {
    runApp(
      MultiProvider(
        providers: [
          // Provide PositionProvider and WeatherProvider
          ChangeNotifierProvider(create: (_) => PositionProvider()),
          ChangeNotifierProvider(create: (_) => ActivityProvider())
        ],
        child: MyApp(recyclingCenters: value),
      ),
    );
  });
}

// MyApp is the main entry point of the app
class MyApp extends StatelessWidget {
  // recyclingCenters is the database of recycling centers
  final RecyclingCentersDB recyclingCenters;

  // MyApp constructor
  const MyApp({super.key, required this.recyclingCenters});

  // Build the app layout
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Go Green App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/location': (context) => MapView(positionProvider: PositionProvider(), recyclingCenters: recyclingCenters), // Register route for MapView
        //'/history': (context) => , // Register route for History Page
      }, // Set HomePage as the home screen
    );
  }
}
