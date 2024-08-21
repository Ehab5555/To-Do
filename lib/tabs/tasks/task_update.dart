import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/firebase_functions.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/tabs/tasks/default_elevated_button.dart';
import 'package:todo/tabs/tasks/default_text_form_field.dart';
import 'package:todo/tabs/tasks/tasks_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskUpdate extends StatelessWidget {
  static const String routeName = "task_update";
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey();
  late final DateTime selectedDate = task.date;
  final DateFormat selectedDateFormat = DateFormat('dd/MM/yyyy');
  late final TaskModel task;
  TaskUpdate({super.key});

  @override
  Widget build(BuildContext context) {
    task = ModalRoute.of(context)?.settings.arguments as TaskModel;
    TasksProvider provider = Provider.of<TasksProvider>(context);
    AppLocalizations? localizations = AppLocalizations.of(context);
    double screenHeight = MediaQuery.of(context).size.height;
    ThemeData theme = Theme.of(context);
    return Scaffold(
        body: Stack(children: [
      Container(
        height: screenHeight * 0.2,
        width: double.infinity,
        color: AppTheme.primary,
      ),
      Positioned.directional(
          top: screenHeight * 0.05,
          start: screenHeight * 0.02,
          textDirection: provider.language == 'ar'
              ? ui.TextDirection.rtl
              : ui.TextDirection.ltr,
          child: Row(
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(Icons.arrow_back)),
              const SizedBox(
                width: 15,
              ),
              Text(
                'To Do List',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontSize: 22,
                  color: provider.isDark ? AppTheme.black : AppTheme.white,
                ),
              ),
            ],
          )),
      Container(
        margin:
            EdgeInsets.symmetric(vertical: screenHeight * 0.15, horizontal: 20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: provider.isDark
                ? AppTheme.bottomNavBarBackground
                : AppTheme.white),
        child: Form(
          key: formkey,
          child: Column(
            children: [
              Text(
                localizations!.edittask,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: provider.isDark ? AppTheme.white : AppTheme.black,
                    ),
              ),
              const SizedBox(
                height: 32,
              ),
              DefaultTextFormField(
                controller: titleController,
                hintText: task.title,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    titleController.text = task.title;
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              DefaultTextFormField(
                controller: descriptionController,
                hintText: task.description,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    descriptionController.text = task.description;
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 32,
              ),
              Text(
                localizations.selecteddate,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: provider.isDark ? AppTheme.white : AppTheme.black,
                    ),
              ),
              const SizedBox(
                height: 8,
              ),
              InkWell(
                onTap: () async {
                  DateTime? dateTime = await showDatePicker(
                    context: context,
                    initialDate: provider.selectedDate,
                    firstDate: DateTime.now().subtract(
                      const Duration(days: 365),
                    ),
                    lastDate: DateTime.now().add(
                      const Duration(days: 365),
                    ),
                    initialEntryMode: DatePickerEntryMode.calendarOnly,
                  );
                  if (dateTime != null) {
                    provider.changeSelectedDate(dateTime);
                  }
                },
                child: Text(
                  selectedDateFormat.format(provider.selectedDate),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color:
                            provider.isDark ? AppTheme.white : AppTheme.black,
                      ),
                ),
              ),
              const SizedBox(
                height: 64,
              ),
              DefaultElevatedButton(
                label: localizations.savechang,
                onPressed: () {
                  if (formkey.currentState!.validate()) {
                    task.title = titleController.text;
                    task.description = descriptionController.text;
                    task.date = provider.selectedDate;
                    FirebaseFunctions.updateTasks(task: task);
                    Navigator.pop(context);
                  }
                },
              )
            ],
          ),
        ),
      ),
    ]));
  }
}
