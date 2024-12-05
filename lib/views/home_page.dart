import 'package:flutter/material.dart';
import 'package:go_green/models/emission_data/emission_data_enums.dart';
import 'package:go_green/models/entry.dart';
import 'package:go_green/providers/activity_provider.dart';
import 'package:go_green/views/entry_view.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  HomePageState createState() => HomePageState();
}

// HomePageState is the state of HomePage
// It contains the current tab index and the build method
// The build method returns the layout of the HomePage
class HomePageState extends State<HomePage> {
  // _currentIndex is the index of the selected tab
  int _currentIndex = 0; // Tracks the selected tab

  @override
  Widget build(BuildContext context) {
    // Scaffold is the main layout structure of the app
    return Scaffold(
      backgroundColor: const Color(0xFFF2E8CF),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title and Info Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'GoGreen',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF386641), // Dark green
                    ),
                  ),
                  Semantics(
                    label: 'More info on what your emission plus its color means',
                    child: IconButton(
                      icon: const Icon(Icons.info_outline, color: Color(0xFF386641)),
                      onPressed: () {
                        _showInfoDialog(context);
                      },
                    ),
                  )
                ],
              ),
            ),

        
            // Total Emissions - under GoGreen title
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Consumer<ActivityProvider>(
                  builder: (context, activityProvider, child) {
                    double co2 = activityProvider.activityHistory.todayCo2;
                    Color emissionColor; 
                    double roundedCo2 = (co2 * 100).round() / 100;
                    double width = MediaQuery.of(context).size.width - 40;
                    String semanticLabel = '';
                    
                     if (co2 > 43.8) {
                  emissionColor = const Color(0xFFBC4749);
                  semanticLabel = "Today's Emissions: $roundedCo2 kg CO₂ in Red zone";
                    } else if (co2 >= 20 && co2 <= 43.8) {
                  emissionColor = const Color(0xFF6A994E); // Light green
                  semanticLabel = "Today's Emissions: $roundedCo2 kg CO₂ in Light Green zone";
                    } else {
                  emissionColor = const Color(0xFF386641); // Dark green
                  semanticLabel = "Today's Emissions: $roundedCo2 kg CO₂ in Dark Green zone";
                  }
                     return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: width),
                        child: Semantics(
                          label: semanticLabel, // Dynamically set label
                          child: RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black, // Default color for non-CO₂ text
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                const TextSpan(
                                  text: "Today's Emissions: ",
                                ),
                                TextSpan(
                                  text: '$roundedCo2 kg CO₂',
                                  style: TextStyle(color: emissionColor),
                                ),
                              ],
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ),
    );
                  }
                ),
              ],
            ),

            const Spacer(),

            // Globe animation
            ConstrainedBox(
              // width: 300,
              // height: 500,
              constraints: const BoxConstraints(maxHeight: 1000),
              child: Semantics(
                label: 'Globe Animation of the Earth',
                child: Lottie.asset(
                  // Load the globe animation
                  'assets/globe.json',
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),

            const SizedBox(height: 50,),

            // Track button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  final Entry newEntry = Entry.fromEmissions(category: EmissionCategory.clothing);
                  _navigateToEntry(context, newEntry);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFBC4749),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  'Track',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 150,)
        
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF2E8CF), // Same as background
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1), // Subtle shadow
              blurRadius: 8,
              offset: const Offset(0, -2), // Elevation effect
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) { // When an item is tapped, the index of that item is passed here
            setState(() {
              _currentIndex = index; // Update currentIndex to the tapped index
            });

            if (index == 2) {
              // Navigate to MapView when the Map icon is tapped
              Navigator.pushNamed(context, '/location');
            } else if (index == 1) {
              // Navigate to EntryView when the History icon is tapped
              Navigator.pushNamed(context, '/history');
            }
          },
          backgroundColor: const Color(0xFFF2E8CF), // Matches the app background
          selectedItemColor: const Color(0xFFBC4749), // Red accent
          unselectedItemColor: const Color(0xFF386641),  // Light green
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          elevation: 0, // Disable built-in elevation
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: 'Map',
            ),
          ],
        ),
      ),
    );
  }

  // Navigates to EntryView to edit or add a journal entry. After returning, it upserts the entry into the provider.
  Future<void> _navigateToEntry(BuildContext context, Entry entry) async {
    // Navigate to EntryView, where user can edit the entry
    final newEntry = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EntryView(curEntry: entry))
    );

    // Ensure that context is still valid after the navigation
    if (!context.mounted) return;

    // If an updated entry is returned, upsert it into the journal provider
    final activityProvider = Provider.of<ActivityProvider>(context, listen: false);
    if (newEntry != null) {
      activityProvider.upsertEntry(newEntry);
    }

  }
  // Show Info Dialog that tells users about what their emission means (changes the color and explains why)
  void _showInfoDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: const Color(0xFFF2E8CF), // Same background as the app
        title: const Text(
          'Emission Levels Information',
          style: TextStyle(color: Colors.black), // Black title text
        ),
        content: RichText(
          text: const TextSpan(
            style: TextStyle(color: Colors.black, fontSize: 16), 
            children: [
              TextSpan(text: 'Here is what the colors mean:\n\n'),
              TextSpan(
                text: 'Red: ',
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: 'Emissions are above 43.8 kg, the average daily CO2 footprint for an American.\n',
              ),
              TextSpan(
                text: 'Light Green: ',
                style: TextStyle(color: Color(0xFF6A994E), fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: 'Emissions are between 20 and 43.8 kg.\n',
              ),
              TextSpan(
                text: 'Dark Green: ',
                style: TextStyle(color: Color(0xFF386641), fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: 'Emissions are less than 20 kg. Great job!\n\n',
              ),
              TextSpan(text: 'Tips to reduce emissions:\n'),
              TextSpan(text: '- Use public transportation or carpool.\n'),
              TextSpan(text: '- Opt for energy-efficient appliances.\n'),
              TextSpan(text: '- Reduce meat consumption.\n'),
              TextSpan(text: '- Use reusable bags, bottles, and containers.\n'),
            ],
          ),
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