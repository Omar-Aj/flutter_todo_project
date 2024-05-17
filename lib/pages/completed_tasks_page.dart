import 'package:flutter/material.dart';
import 'package:flutter_todo_project/components/app_bar.dart';
import 'package:flutter_todo_project/pages/home_page.dart';

class CompletedTaskPage extends StatefulWidget {
  final List<String> completedTasks;

  const CompletedTaskPage({super.key, required this.completedTasks});

  @override
  State<CompletedTaskPage> createState() => _CompletedTaskPageState();
}

class _CompletedTaskPageState extends State<CompletedTaskPage> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: appBar(colorScheme, "Completed Tasks"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: widget.completedTasks.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(widget.completedTasks[index]),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        _deleteTask(index);
                      },
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
              child: const Text('Return to To-Do List Page'),
            ),
          ],
        ),
      ),
    );
  }

  void _deleteTask(int index) {
    setState(() {
      widget.completedTasks.removeAt(index);
    });
  }
}
