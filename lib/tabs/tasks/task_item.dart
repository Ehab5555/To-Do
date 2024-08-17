import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/tabs/tasks/tasks_provider.dart';

class TaskItem extends StatelessWidget {
  TaskModel task;
  Color color = AppTheme.green;
  TaskItem(this.task);
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TasksProvider provider = Provider.of<TasksProvider>(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color:
            provider.isDark ? AppTheme.bottomNavBarBackground : AppTheme.white,
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
              provider.updateTasks(
                id: task.id,
                title: task.title,
                description: task.description,
                date: task.date,
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
    );
  }
}
