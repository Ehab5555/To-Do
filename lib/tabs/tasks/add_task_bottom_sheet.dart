import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/firebase_functions.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/tabs/tasks/default_elevated_button.dart';
import 'package:todo/tabs/tasks/default_text_form_field.dart';
import 'package:todo/tabs/tasks/tasks_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  DateFormat selectedDateFormat = DateFormat('dd/MM/yyyy');
  GlobalKey<FormState> keyState = GlobalKey<FormState>();
  late AppLocalizations localizations;
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TasksProvider provider = Provider.of<TasksProvider>(context);
    localizations = AppLocalizations.of(context)!;
    return Container(
      height: MediaQuery.of(context).size.height * 0.55,
      padding: const EdgeInsets.all(20),
      color: provider.isDark ? AppTheme.bottomNavBarBackground : AppTheme.white,
      child: Form(
        key: keyState,
        child: Column(
          children: [
            Text(
              localizations.newtask,
              style: theme.textTheme.titleMedium?.copyWith(
                color: provider.isDark ? AppTheme.white : AppTheme.black,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            DefaultTextFormField(
              controller: titleController,
              hintText: localizations.tasktitle,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return localizations.titleerror;
                }
                return null;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            DefaultTextFormField(
              controller: descriptionController,
              hintText: localizations.taskdesc,
              maxLines: 3,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return localizations.deserror;
                }
                return null;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              localizations.selecteddate,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w400,
                color: provider.isDark ? AppTheme.white : AppTheme.black,
              ),
            ),
            const SizedBox(
              height: 16,
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
                style: theme.textTheme.titleMedium?.copyWith(
                  color: provider.isDark ? AppTheme.white : AppTheme.black,
                ),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            DefaultElevatedButton(
              label: localizations.submit,
              onPressed: () {
                if (keyState.currentState!.validate()) {
                  addTask();
                }
              },
            )
          ],
        ),
      ),
    );
  }

  void addTask() {
    FirebaseFunctions.addTaskToFireStore(
      TaskModel(
        title: titleController.text,
        description: descriptionController.text,
        date: selectedDate,
      ),
    ).timeout(
      const Duration(microseconds: 100),
      onTimeout: () {
        // ignore: use_build_context_synchronously
        Provider.of<TasksProvider>(context, listen: false).getTasks;
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();
        Fluttertoast.showToast(
          msg: localizations.taskadded,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: AppTheme.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      },
    ).catchError(
      (_) => Fluttertoast.showToast(
        msg: localizations.error,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: AppTheme.red,
        textColor: Colors.white,
        fontSize: 16.0,
      ),
    );
  }
}
