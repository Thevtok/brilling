import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveAuthentication(bool isAuthenticated) async {
  final sharedPreferences = await SharedPreferences.getInstance();
  await sharedPreferences.setBool('isAuthenticated', isAuthenticated);
}

Future<bool> getAuthentication() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  final isAuthenticated = sharedPreferences.getBool('isAuthenticated');
  return isAuthenticated ?? false; 
}
Future<void> saveUserIdToSharedPreferences(String userid) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('userid', userid);
}
Future<String?> getUserIdFromSharedPreferences() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('userid');
}

Future<void> saveUsernameToSharedPreferences(String username) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('username', username);
}
Future<String?> getUsernameFromSharedPreferences() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('username');
}

