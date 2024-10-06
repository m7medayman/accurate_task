import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const String _listKey = 'int_list';

  // Method to get the list of integers
  static Future<List<String>> getIdsList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Retrieve the string representation of the list
    final List<String>? stringList = prefs.getStringList(_listKey);

    // If the list does not exist, return an empty list
    if (stringList == null) {
      return [];
    }

    // Convert the list of strings to a list of integers
    return stringList;
  }

  // Method to save a list of integers
  static Future<void> saveIntList(List<int> intList) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Convert the list of integers to a list of strings
    final List<String> stringList =
        intList.map((int e) => e.toString()).toList();

    // Save the string list to SharedPreferences
    await prefs.setStringList(_listKey, stringList);
  }

  static Future<void> addToList(String input) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> newList = prefs.getStringList(_listKey) ?? [];
    newList.add(input);
    prefs.setStringList(_listKey, newList);
  }

  // Method to initialize the list if it doesn't exist
  static Future<void> initializeIntList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Check if the list exists
    if (!prefs.containsKey(_listKey)) {
      // If it doesn't exist, create and save an empty list
      await saveIntList([]);
    }
  }
}
