import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/firebase_functions.dart';
import 'package:todo/models/task_model.dart';

class TasksProvider with ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;
  String language = 'en';
  bool get isEnglish => language == 'en';
  bool get isDark => themeMode == ThemeMode.dark;
  SharedPreferences? prefs;
  List<TaskModel> tasks = [];
  DateTime selectedDate = DateTime.now();

  Future<void> getTasks() async {
    List<TaskModel> allTasks =
        await FirebaseFunctions.getAllTasksFromFireStore();
    tasks = allTasks
        .where(
          (task) =>
              task.date.day == selectedDate.day &&
              task.date.month == selectedDate.month &&
              task.date.year == selectedDate.year,
        )
        .toList();
    notifyListeners();
  }

  void changeMode(ThemeMode mode) {
    themeMode = mode;
    setMode();
    notifyListeners();
  }

  void changeSelectedDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }

  void changeLang(String lang) {
    language = lang;
    setLang();
    notifyListeners();
  }

  Future<void> setMode() async {
    prefs = await SharedPreferences.getInstance();
    prefs!.setBool('isDark', isDark);
  }

  Future<void> getMode() async {
    prefs = await SharedPreferences.getInstance();
    bool mode = prefs!.getBool('isDark') ?? false;
    mode ? themeMode = ThemeMode.dark : themeMode = ThemeMode.light;
    notifyListeners();
  }

  Future<void> setLang() async {
    prefs = await SharedPreferences.getInstance();
    prefs!.setBool('isEnglish', isEnglish);
  }

  Future<void> getLang() async {
    prefs = await SharedPreferences.getInstance();
    bool mode = prefs!.getBool('isEnglish') ?? false;
    mode ? language = 'en' : language = 'ar';
    notifyListeners();
  }
}
