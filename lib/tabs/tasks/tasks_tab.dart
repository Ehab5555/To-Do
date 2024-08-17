import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/tabs/tasks/task_item.dart';
import 'package:todo/tabs/tasks/task_update.dart';
import 'package:todo/tabs/tasks/tasks_provider.dart';

class TasksTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TasksProvider tasksProvider = Provider.of<TasksProvider>(context);

    return SafeArea(
      child: Column(
        children: [
          EasyInfiniteDateTimeLine(
              firstDate: DateTime.now().subtract(
                const Duration(
                  days: 365,
                ),
              ),
              focusDate: tasksProvider.selectedDate,
              lastDate: DateTime.now().add(
                const Duration(
                  days: 365,
                ),
              ),
              showTimelineHeader: false,
              dayProps: EasyDayProps(
                inactiveDayStyle: DayStyle(
                  dayNumStyle: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(
                          color: tasksProvider.isDark
                              ? AppTheme.white
                              : AppTheme.black),
                ),
                todayStyle: DayStyle(
                  dayNumStyle: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(
                          color: tasksProvider.isDark
                              ? AppTheme.white
                              : AppTheme.black),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppTheme.primary,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              activeColor:
                  tasksProvider.isDark ? AppTheme.white : AppTheme.primary,
              onDateChange: (selectedDate) {
                tasksProvider.changeSelectedDate(selectedDate);
                tasksProvider.getTasks();
              }),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 20),
              itemBuilder: (_, index) => GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    TaskUpdate.routeName,
                    arguments: tasksProvider.tasks[index],
                  );
                },
                child: TaskItem(
                  tasksProvider.tasks[index],
                ),
              ),
              itemCount: tasksProvider.tasks.length,
            ),
          ),
        ],
      ),
    );
  }
}
