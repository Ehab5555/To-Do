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
    double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: screenHeight * 0.2,
              width: double.infinity,
              color: AppTheme.primary,
            ),
            Positioned.directional(
              top: screenHeight * 0.05,
              start: screenHeight * 0.05,
              textDirection: tasksProvider.language == 'ar'
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              child: Text(
                "To Do List",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 22,
                      color: tasksProvider.isDark
                          ? AppTheme.black
                          : AppTheme.white,
                    ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.15),
              child: EasyInfiniteDateTimeLine(
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
                    height: 90,
                    width: 60,
                    activeDayStyle: DayStyle(
                      decoration: BoxDecoration(
                          color: tasksProvider.isDark
                              ? AppTheme.bottomNavBarBackground
                              : AppTheme.white,
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    inactiveDayStyle: DayStyle(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(5),
                        color: tasksProvider.isDark
                            ? AppTheme.bottomNavBarBackground
                            : AppTheme.white,
                      ),
                      dayNumStyle:
                          Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: tasksProvider.isDark
                                    ? AppTheme.white
                                    : AppTheme.black,
                              ),
                    ),
                    todayStyle: DayStyle(
                      dayStrStyle: const TextStyle(
                        color: AppTheme.primary,
                      ),
                      decoration: BoxDecoration(
                        color: tasksProvider.isDark
                            ? AppTheme.bottomNavBarBackground
                            : AppTheme.white,
                        borderRadius: BorderRadius.circular(
                          5,
                        ),
                      ),
                      dayNumStyle: const TextStyle(
                        color: AppTheme.primary,
                      ),
                    ),
                    dayStructure: DayStructure.dayStrDayNum),
                activeColor: tasksProvider.isDark
                    ? AppTheme.bottomNavBarBackground
                    : AppTheme.white,
                onDateChange: (selectedDate) {
                  tasksProvider.changeSelectedDate(selectedDate);
                  tasksProvider.getTasks();
                },
              ),
            ),
          ],
        ),
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
    );
  }
}
