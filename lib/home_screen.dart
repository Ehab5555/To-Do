import 'package:flutter/material.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/tabs/settings/settings_tab.dart';
import 'package:todo/tabs/tasks/add_task_bottom_sheet.dart';
import 'package:todo/tabs/tasks/tasks_tab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentTabIndex = 0;
  List<Widget> tabs = [
    const TasksTab(),
    const SettingsTab(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[currentTabIndex],
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        padding: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: AppTheme.white,
        child: BottomNavigationBar(
          currentIndex: currentTabIndex,
          onTap: (value) {
            setState(() {
              currentTabIndex = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.list,
                  size: 32,
                ),
                label: 'Tasks'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings_outlined,
                  size: 32,
                ),
                label: 'Settings'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet(
          context: context,
          builder: (_) => const AddTaskBottomSheet(),
        ),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
