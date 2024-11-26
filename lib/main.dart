import 'package:flutter/material.dart';
import 'package:go_green/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
Future<dynamic> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open([EntrySchema], directory: dir.path);
  // Need to call this before using isar, if we haven't yet called runApp
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Go Green App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const HomePage(), // Set HomePage as the home screen
    );
  }
}
