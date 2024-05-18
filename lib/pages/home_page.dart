import 'package:flutter/material.dart';
import 'package:flutter_todo_project/pages/completed_tasks_page.dart';
import 'package:flutter_todo_project/pages/pomodoro_page.dart';
import 'package:flutter_todo_project/pages/tasks_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 1;

  final List _pages = [
    const CompletedTaskPage(),
    const TasksPage(),
    const PomodoroPage(),
  ];

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;

    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: colorScheme.secondaryContainer,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.check_box),
            icon: Icon(Icons.check_box_outlined),
            label: 'Completed Tasks',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.timer),
            icon: Icon(Icons.timer_outlined),
            label: 'Pomodoro',
          ),
        ],
      ),
      body: _pages[currentPageIndex],
    );
  }
}
