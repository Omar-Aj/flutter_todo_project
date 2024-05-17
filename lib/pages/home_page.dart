import 'package:flutter/material.dart';
import 'package:flutter_todo_project/components/app_bar.dart';
import 'package:flutter_todo_project/pages/completed_tasks_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
  List<String> tasks = [];
  List<String> completedTasks = [];
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                  setState(() {
                    tasks.add(_controller.text);
                    _controller.clear();
                  });
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
                        setState(() {
                          tasks.removeAt(index);
                        });
                      },
                    ),
                    Checkbox(
                      value: false,
                      onChanged: (isChecked) {
                        if (isChecked!) {
                          setState(() {
                            completedTasks.add(tasks[index]);
                            tasks.removeAt(index);
                          });
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      CompletedTaskPage(completedTasks: completedTasks)),
            );
          },
          child: const Text('Go to Completed Task Page'),
        ),
      ],
    );
  }
}
