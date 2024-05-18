import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_todo_project/components/app_bar.dart';
import 'package:flutter_todo_project/provider_tasks.dart';

class CompletedTaskPage extends StatefulWidget {
  const CompletedTaskPage({super.key});

  @override
  State<CompletedTaskPage> createState() => _CompletedTaskPageState();
}

class _CompletedTaskPageState extends State<CompletedTaskPage> {
  late TasksProvider tasksProvider;
  late List<String> completedTasks = tasksProvider.completedTasks;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;

    tasksProvider = Provider.of<TasksProvider>(context);

    return Scaffold(
      appBar: appBar(colorScheme, "Completed Tasks"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: completedTasks.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(completedTasks[index]),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        _deleteTaskFromCompleted(index);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _deleteTaskFromCompleted(int index) {
    tasksProvider.deleteTaskFromCompleted(index);
  }
}
