import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter_todo_project/firebase_options.dart';
import 'package:flutter_todo_project/provider_auth.dart';
import 'package:flutter_todo_project/pages/login_page.dart';
import 'package:flutter_todo_project/pages/signup_page.dart';
import 'package:flutter_todo_project/pages/home_page.dart';
import 'package:flutter_todo_project/pages/pomodoro_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ChangeNotifierProvider(
    create: (context) => AuthenticationProvider(),
    child: const App(),
  ));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => HomePage(),
        '/signup': (context) => const SignupPage(),
        '/pomodoro': (context) => PomodoroPage(),
      },
      title: 'Todo Project',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
