import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/firebase_functions.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/tabs/tasks/tasks_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskItem extends StatelessWidget {
  final TaskModel task;
  final Color color = AppTheme.green;
  late final AppLocalizations localizations;
  TaskItem(this.task, {super.key});
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TasksProvider provider = Provider.of<TasksProvider>(context);
    localizations = AppLocalizations.of(context)!;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Slidable(
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                FirebaseFunctions.deleteTaskFromFireStore(task.id)
                    .timeout(
                      const Duration(microseconds: 100),
                      onTimeout: () =>
                          // ignore: use_build_context_synchronously
                          Provider.of<TasksProvider>(context, listen: false)
                              .getTasks,
                    )
                    .catchError(
                      (_) => Fluttertoast.showToast(
                        msg: localizations.error,
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                      ),
                    );
              },
              backgroundColor: AppTheme.red,
              foregroundColor: AppTheme.white,
              icon: Icons.delete,
              label: 'Delete',
              borderRadius: BorderRadius.circular(15),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: provider.isDark
                ? AppTheme.bottomNavBarBackground
                : AppTheme.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Container(
                height: 62,
                width: 4,
                color: task.isDone ? color : theme.primaryColor,
                margin: const EdgeInsetsDirectional.only(end: 8),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: task.isDone ? color : AppTheme.primary,
                    ),
                  ),
                  Text(
                    task.description,
                    style: theme.textTheme.titleSmall?.copyWith(
                        color: provider.isDark
                            ? AppTheme.white.withOpacity(0.6)
                            : AppTheme.black),
                  ),
                ],
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  FirebaseFunctions.updateTasks(
                    task: task,
                    isDone: true,
                  );
                },
                child: task.isDone
                    ? Text(
                        'Done',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: AppTheme.green,
                        ),
                      )
                    : Container(
                        height: 34,
                        width: 69,
                        decoration: BoxDecoration(
                          color: theme.primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.check,
                          size: 32,
                          color: AppTheme.white,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
