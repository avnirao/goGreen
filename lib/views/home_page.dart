import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _currentIndex = 0; // Tracks the selected tab

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2E8CF), // Background color
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
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

            // Weekly Goal - under GoGreen title
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Weekly Goal: 52 Co2g',
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF6A994E),
                  fontWeight: FontWeight.bold
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Center Section
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Go Green Text (centralized)
                   const Icon(Icons.eco, size: 100, color: Color(0xFF6A994E)),

                    const SizedBox(height: 30),

                    // Track Button
                    ElevatedButton(
                      onPressed: () {
                        // Navigate to the Track Page
                        Navigator.pushNamed(context,'/Users/avnirao/gogreen/lib/views/activity_log.dart');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFBC4749), // Red accent
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
                  ],
                ),
              ),
            ),
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
}
