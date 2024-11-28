import 'package:flutter/material.dart';
import 'package:go_green/providers/activity_provider.dart';
import 'package:go_green/views/entry_view.dart';
import 'package:go_green/models/entry.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

/// A stateless widget that displays a list of activity log entries.
/// Allows navigation to view or edit entries.
class ActivityLogView extends StatefulWidget {
  const ActivityLogView({super.key});

  @override
  _ActivityLogViewState createState() => _ActivityLogViewState();
}

class _ActivityLogViewState extends State<ActivityLogView> {
  String _sortOption = 'Most Recent';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2E8CF),
        title: const Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.eco, color: Color(0xFF6A994E)),
            SizedBox(width: 8),
            Text(
              'Activity Log',
              style: TextStyle(color: Color(0xFF386641)),
            ),
          ],
        ),
      ),
      body: Container(
        // Background gradient decoration for the entire screen
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [const Color.fromARGB(255, 242, 232, 207), const Color.fromARGB(255, 106, 153, 78)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: <Widget>[
            // Sorting Dropdown
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: DropdownButton<String>(
                value: _sortOption,
                items: [
                  'Most Recent',
                  'Least Recent',
                  'Most CO2',
                  'Least CO2',
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _sortOption = newValue ?? 'Most Recent';
                  });
                },
                dropdownColor: const Color.fromARGB(255, 224, 214, 186),
                style: const TextStyle(color: Color(0xFF386641)),
              ),
            ),
            Expanded(
              // Listens to changes in ActivityProvider and rebuilds the list of entries
              child: Consumer<ActivityProvider>(
                builder: (context, activityProvider, child) {
                  List<Entry> entries = activityProvider.activityHistory.entries;

                  // Sorting entries based on selected option
                  if (_sortOption == 'Most Recent') {
                    entries.sort((a, b) => b.emissionsDate.compareTo(a.emissionsDate));
                  } else if (_sortOption == 'Least Recent') {
                    entries.sort((a, b) => a.emissionsDate.compareTo(b.emissionsDate));
                  } else if (_sortOption == 'Most CO2') {
                    entries.sort((a, b) => b.co2.compareTo(a.co2));
                  } else if (_sortOption == 'Least CO2') {
                    entries.sort((a, b) => a.co2.compareTo(b.co2));
                  }

                  return ListView.builder(
                    itemCount: entries.length,
                    itemBuilder: (context, index) {
                      // Builds each list item with activity entry data
                      return _createListElementForEntry(context, entries[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Creates a styled ListTile widget to display individual activity entry details.
  Widget _createListElementForEntry(BuildContext context, Entry entry) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 5,
        shadowColor: Colors.black,
        child: ListTile(
          tileColor: const Color.fromARGB(255, 234, 224, 198),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Text(
            '${entry.category} - ${entry.subtype}',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.purple.shade900,
            ),
            semanticsLabel: entry.category.toString(),
          ),
          subtitle: Text(
            _formatDateTime(entry.emissionsDate),
            style: const TextStyle(color: Color(0xFF2B2B2B)),
            semanticsLabel: _formatDateTime(entry.emissionsDate),
          ),
          trailing: Text(
            'CO2: ${entry.co2.toStringAsFixed(2)} kg',
            style: const TextStyle(
              color: Color(0xFF064B8F),
              fontStyle: FontStyle.italic,
            ),
            semanticsLabel: 'CO2 emissions: ${entry.co2.toStringAsFixed(2)} kg',
          ),
          onTap: () => _navigateToEntry(context, entry), // Navigates to EntryView for editing
        ),
      ),
    );
  }

  /// Navigates to EntryView to edit or add an activity entry. After returning, it upserts the entry into the provider.
  Future<void> _navigateToEntry(BuildContext context, Entry entry) async {
    // Navigate to EntryView, where user can edit the entry
    final newEntry = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EntryView(curEntry: entry)),
    );

    // Ensure that context is still valid after the navigation
    if (!context.mounted) return;

    // If an updated entry is returned, upsert it into the activity provider
    if (newEntry != null) {
      Provider.of<ActivityProvider>(context, listen: false).upsertEntry(newEntry);
    }
  }

  /// Helper method to format a DateTime as a readable string for display.
  String _formatDateTime(DateTime when) {
    return DateFormat.yMd().add_jm().format(when);
  }
}