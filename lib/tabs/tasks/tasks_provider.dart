import 'package:flutter/material.dart';
import 'package:todo/firebase_functions.dart';
import 'package:todo/models/task_model.dart';

class TasksProvider with ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;
  String language = 'en';
  bool get isDark => themeMode == ThemeMode.dark;
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
    notifyListeners();
  }

  void changeSelectedDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }

  void changeLang(String lang) {
    language = lang;
    notifyListeners();
  }
}
