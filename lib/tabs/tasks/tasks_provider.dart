import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/firebase_functions.dart';
import 'package:todo/models/task_model.dart';

class TasksProvider with ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;
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

  void updateTasks(
      {required String id,
      required String title,
      required String description,
      required DateTime date,
      bool isDone = false}) {
    FirebaseFirestore.instance.collection('tasks').doc(id).update({
      'title': title,
      "description": description,
      'isDone': isDone,
      'date': date,
    });
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
