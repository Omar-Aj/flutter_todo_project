import 'package:flutter/material.dart';
import 'todo_list_page.dart';

class CompletedTaskPage extends StatefulWidget {
  final List<String> completedTasks;

  CompletedTaskPage({required this.completedTasks});

  @override
  _CompletedTaskPageState createState() => _CompletedTaskPageState();
}

class _CompletedTaskPageState extends State<CompletedTaskPage> {
  void _deleteTask(int index) {
    setState(() {
      widget.completedTasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Completed Tasks'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Completed Tasks:',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: widget.completedTasks.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(widget.completedTasks[index]),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
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
                  MaterialPageRoute(builder: (context) => TodoListPage()),
                );
              },
              child: Text('Return to To-Do List Page'),
            ),
          ],
        ),
      ),
    );
  }
}
