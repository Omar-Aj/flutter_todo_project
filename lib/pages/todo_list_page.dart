import 'package:flutter/material.dart';
import 'completed_task_page.dart';

class TodoListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
      ),
      body: TodoListBody(),
    );
  }
}

class TodoListBody extends StatefulWidget {
  @override
  _TodoListBodyState createState() => _TodoListBodyState();
}

class _TodoListBodyState extends State<TodoListBody> {
  List<String> tasks = [];
  List<String> completedTasks = [];
  TextEditingController _controller = TextEditingController();

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
                icon: Icon(Icons.add),
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
                      icon: Icon(Icons.delete),
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
              MaterialPageRoute(builder: (context) => CompletedTaskPage(completedTasks: completedTasks)),
            );
          },
          child: Text('Go to Completed Task Page'),
        ),
      ],
    );
  }
}
