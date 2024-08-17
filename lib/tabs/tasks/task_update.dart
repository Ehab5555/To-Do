import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/tabs/tasks/default_elevated_button.dart';
import 'package:todo/tabs/tasks/default_text_form_field.dart';
import 'package:todo/tabs/tasks/tasks_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskUpdate extends StatefulWidget {
  static const String routeName = "task_update";
  @override
  State<TaskUpdate> createState() => _TaskUpdateState();
}

class _TaskUpdateState extends State<TaskUpdate> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey();
  late DateTime selectedDate = task.date;
  DateFormat selectedDateFormat = DateFormat('dd/MM/yyyy');
  late TaskModel task;

  @override
  Widget build(BuildContext context) {
    task = ModalRoute.of(context)?.settings.arguments as TaskModel;
    TasksProvider provider = Provider.of<TasksProvider>(context);
    AppLocalizations? localizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: provider.isDark
            ? AppTheme.backgroundDark
            : AppTheme.backgroundLight,
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(30),
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
                        color:
                            provider.isDark ? AppTheme.white : AppTheme.black,
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
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                DefaultTextFormField(
                  controller: descriptionController,
                  hintText: task.description,
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      descriptionController.text = task.description;
                    }
                  },
                ),
                const SizedBox(
                  height: 32,
                ),
                Text(
                  localizations.selecteddate,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color:
                            provider.isDark ? AppTheme.white : AppTheme.black,
                      ),
                ),
                const SizedBox(
                  height: 8,
                ),
                InkWell(
                  onTap: () async {
                    DateTime? dateTime = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime.now().subtract(
                        const Duration(days: 365),
                      ),
                      lastDate: DateTime.now().add(
                        const Duration(days: 365),
                      ),
                      initialEntryMode: DatePickerEntryMode.calendarOnly,
                    );
                    if (dateTime != null) {
                      selectedDate = dateTime;
                      setState(() {});
                    }
                  },
                  child: Text(
                    selectedDateFormat.format(selectedDate),
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
                      provider.updateTasks(
                          id: task.id,
                          title: titleController.text,
                          description: descriptionController.text,
                          date: selectedDate);
                      Navigator.pop(context);
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
