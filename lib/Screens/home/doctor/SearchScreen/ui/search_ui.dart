import 'package:flutter/material.dart';

import '../../../../../theme/light_color.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  void _searchPatient(String searchTerm) {
    // if (searchTerm!= ) {
    //   print('Searching for patient with name: $searchTerm');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightColor.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: LightColor.background,
        title: Row(
          children: [
            Image.asset(
              'assets/logo.png',
              height: 150,
            ),
            const SizedBox(width: 8),
            const Text(
              'App Name',
              style: TextStyle(color: LightColor.grey),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            //#12A299
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search for patient name',
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color(0xFF12A299)), // Border color when focused
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Color(0xFF12A299),
                ),
              ),
            ),

            const SizedBox(height: 16),
            SizedBox(
              width: MediaQuery.of(context).size.width - 20,
              height: 50.0, // Set the desired height
              child: ElevatedButton(
                onPressed: () {
                  String searchTerm = _searchController.text;
                  _searchPatient(searchTerm);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(0xFF12A299), // Use the specified color
                ),
                child: const Text('Search'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
