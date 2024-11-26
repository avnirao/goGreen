import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:go_green/models/recycling_center_db.dart';
import 'package:go_green/views/home_page.dart';
import 'package:provider/provider.dart';
import 'providers/position_provider.dart';
import 'views/map_view.dart';

Future<RecyclingCentersDB> loadRecyclingDB(String dataPath) async {
  return RecyclingCentersDB.initializeFromJson(await rootBundle.loadString(dataPath));
}

void main() {
  const dataPath = 'assets/locations.json';
  WidgetsFlutterBinding.ensureInitialized();
  
  loadRecyclingDB(dataPath).then((value) {
    runApp(
      MultiProvider(
        providers: [
          // Provide PositionProvider and WeatherProvider
          ChangeNotifierProvider(create: (_) => PositionProvider()),
        ],
        child: MyApp(recyclingCenters: value),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  final RecyclingCentersDB recyclingCenters;

  const MyApp({super.key, required this.recyclingCenters});

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
