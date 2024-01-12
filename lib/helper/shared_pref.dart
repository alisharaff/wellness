import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static Future<Map<String, dynamic>?> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Retrieve data from shared preferences
    String? firstName = prefs.getString('firstName');
    String? lastName = prefs.getString('lastName');
    String? doctorId = prefs.getString('doctorId');
    String? specialty = prefs.getString('specialty');
    String? phoneNumber = prefs.getString('phoneNumber');
    String? role = prefs.getString('role');
        String? id = prefs.getString('Id');


    // Check if any data is missing
    if (firstName == null ||
        lastName == null ||
        doctorId == null ||
        phoneNumber == null ||
        role == null||id == null) {
      return null; // Return null if any required data is missing
    }

    // Create and return a map with user data
    return {
      'firstName': firstName,
      'lastName': lastName,
      'doctorId': doctorId,
      'specialty': specialty,
      'phoneNumber': phoneNumber,
      'role': role,
       'Id': id,
    };
  }
}