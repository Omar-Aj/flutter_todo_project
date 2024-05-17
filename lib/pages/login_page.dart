import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_todo_project/provider_auth.dart';
import 'package:flutter_todo_project/components/app_bar.dart';

String loginImageUrl =
    "https://media.istockphoto.com/id/1405349509/vector/3d-task-management-todo-check-list-with-mobile-phone-holding-hand-efficient-work-on-project.jpg?s=612x612&w=0&k=20&c=OJ-0yDm1ApfGS1RqubJtiBGPa3pLx3Ry_qKCahPhKIE=";

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late AuthenticationProvider authProvider;

  String? errorMessage = '';

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;

    authProvider = Provider.of<AuthenticationProvider>(context);

    return Scaffold(
      appBar: appBar(colorScheme, "Login"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 80,
                backgroundImage: NetworkImage(loginImageUrl),
              ),
              const SizedBox(height: 80.0),
              TextFormField(
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Email';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: const Icon(Icons.email),
                  prefixIconColor: colorScheme.primary,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Password';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock),
                  prefixIconColor: colorScheme.primary,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                style: const TextStyle(fontSize: 14),
                obscureText: true,
              ),
              const SizedBox(height: 16.0),
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                      'A password reset email has been sent to your email address.',
                    ),
                  ));
                },
                child: const Align(
                  alignment: Alignment.centerRight,
                  child: Text('Forget Password?', textAlign: TextAlign.left),
                ),
              ),
              const SizedBox(
                height: 9,
              ),
              _errorMessage(),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _handleSignin();
                  }
                },
                child: const Text('Login'),
              ),
              const SizedBox(height: 16.0),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: const Text('Don\'t have an account? Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _errorMessage() {
    return Text(
      errorMessage == '' ? '' : 'Umm! $errorMessage.',
      style: TextStyle(
        color: Theme.of(context).colorScheme.error,
      ),
    );
  }

  void _handleSignin() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    try {
      authProvider.signIn(email: email, password: password);
      Navigator.pushNamed(context, '/home');
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
      });
    }
  }
}
