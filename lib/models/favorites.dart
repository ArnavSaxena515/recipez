//Model class for managing the local storage and retrieval of meals that were marked as favorites by the user

import 'package:shared_preferences/shared_preferences.dart';

class Favorites {
  static const localStorageKey = 'favorites'; //key to access the favorite meal IDs stored as Map<String, List<String>> where the String (favorites) is
  // the key and List<String> is the list of the ID of meals saved as favorites

  final List<String> mealIDs = []; //List to store the IDs of favorite meals
  final SharedPreferences prefs; //gets a shared preference from user's memory as a parameter

  Favorites({required this.prefs});
  // SharedPreferences prefs = SharedPreferences(); //gets a shared preference from user's memory

  void fetchFavoritesFromMemory() {
    final data = prefs.getStringList(localStorageKey); //get the data as a list of strings from local storage via preferences

    for (var i = 0; i < data!.length; i++) {
      if (!mealIDs.contains(data[i])) {
        mealIDs.add(data[i]);
      }
    } //loop through the List of strings and add them to mealIDs if the element is not already present in the mealIDs list
  } //Function to fetch the list of string containing favorite meal IDs and stores it in mealIDs so that it can be accessed in the app

  void storeFavoritesToMemory(List<String> updatedFavorites) {
    prefs.setStringList(localStorageKey, updatedFavorites); // receives a list of strings containing an updated list of favorites and writes them to user memory
    fetchFavoritesFromMemory(); //updates the mealIDs list so it can be used elsewhere in the app
  }

  // bool isFavorite(String id) {
  //   return mealIDs.contains(id);
  // } //function to check if a particular meal's ID is stored as a user favorite
  //
  // void addFRemoveFavorite(String mealID) {
  //   if (!mealIDs.contains(mealID)) {
  //     mealIDs.add(mealID);
  //   } else {
  //     mealIDs.remove(mealID);
  //   }
  //   print("Updated meals list");
  //   for (var element in mealIDs) {
  //     print(element);
  //   }
  //   // storeFavoritesToMemory();
  //   fetchFavoritesFromMemory();
  // }

  // function to get the mealIDs list to access IDs of user's favorite meals
  List<String> getFavoriteIDs() {
    fetchFavoritesFromMemory();
    return mealIDs;
  }
}
