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
      backgroundColor: const Color(0xFFF2E8CF), // Background color
      body: SafeArea(
        child: Column(
          children: [
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  child: Text(
                    'GoGreen',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF386641), // Dark green
                    ),
                  ),
                ),
              ],
            ),
        
            // Total Emissions - under GoGreen title
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Consumer<ActivityProvider>(
                  builder: (context, activityProvider, child) {
                    double co2 = activityProvider.activityHistory.totalCo2;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Total Emissioned: $co2 kg Co2',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Color(0xFF6A994E),
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    );
                  }
                ),
              ],
            ),
          
        
            // const SizedBox(height: 30, width: double.infinity,),
            const Spacer(),

            // Globe animation
            ConstrainedBox(
              // width: 300,
              // height: 500,
              constraints: const BoxConstraints(maxHeight: 1000),
              child: Lottie.asset(
                // Load the leaf animation
                'assets/globe.json',
                fit: BoxFit.fitHeight,
              ),
            ),

            const SizedBox(height: 50,),

            // Track button
            ElevatedButton(
              onPressed: () {
                final Entry newEntry = Entry.fromEmissions(category: EmissionCategory.clothing);
                _navigateToEntry(context, newEntry);
              },
              // Style the button
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFBC4749),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text(
                // Button text
                'Track',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
    activityProvider.upsertEntry(newEntry);

  }
}
