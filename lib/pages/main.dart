import 'package:flutter/material.dart';
import 'todo_list_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List App',
      theme: ThemeData(
        primarySwatch: Colors.purple, // Set primary color to purple
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.purple, // Set primary color to purple
          accentColor: Colors.purpleAccent, // Set accent color to purple accent
        ),
        scaffoldBackgroundColor: Colors.white, // Set background color to white
        visualDensity: VisualDensity.adaptivePlatformDensity, // Adjust density for different screen sizes
      ),
      home: TodoListPage(),
    );
  }
}