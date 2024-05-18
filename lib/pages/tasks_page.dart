import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_todo_project/provider_tasks.dart';
import 'package:flutter_todo_project/components/app_bar.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: appBar(colorScheme, "Home"),
      body: const TodoListBody(),
    );
  }
}

class TodoListBody extends StatefulWidget {
  const TodoListBody({super.key});

  @override
  State<TodoListBody> createState() => _TodoListBodyState();
}

class _TodoListBodyState extends State<TodoListBody> {
  final TextEditingController _controller = TextEditingController();

  late TasksProvider tasksProvider;
  late List<String> tasks = tasksProvider.tasks;

  @override
  Widget build(BuildContext context) {
    tasksProvider = Provider.of<TasksProvider>(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Enter your task',
              suffixIcon: IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  tasksProvider.addTask(_controller.text);
                  _controller.clear();
                },
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(tasks[index]),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        tasksProvider.deleteTask(index);
                      },
                    ),
                    Checkbox(
                      value: false,
                      onChanged: (isChecked) {
                        if (isChecked!) {
                          tasksProvider.addTaskToCompleted(tasks[index]);
                          tasksProvider.deleteTask(index);
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
