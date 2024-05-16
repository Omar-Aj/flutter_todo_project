import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/provider_auth.dart';

var photourl="https://media.istockphoto.com/id/1405349509/vector/3d-task-management-todo-check-list-with-mobile-phone-holding-hand-efficient-work-on-project.jpg?s=612x612&w=0&k=20&c=OJ-0yDm1ApfGS1RqubJtiBGPa3pLx3Ry_qKCahPhKIE=";

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String? errorMessage = '';
  Widget _errorMessage() {
    return Text(
      errorMessage == '' ? '' : 'Umm! $errorMessage.',
      style: TextStyle(
        color: Colors.red[400],
      ),
    );
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late AuthProvider_ authProvider;
  @override
  Widget build(BuildContext context) {
     authProvider = Provider.of<AuthProvider_>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[200],
        title: Text("ToDo App"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 80,
                backgroundImage: NetworkImage(photourl),
              ),
              const SizedBox(height: 100.0),
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
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.deepPurple[200],
                  ),
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 20.0),
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
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.deepPurple[200],
                  ),
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(fontSize: 14),
                obscureText: true,
              ),
              const SizedBox(height: 10.0),
              GestureDetector(
                onTap: () {
                },
                child: GestureDetector(
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
              ),
              const SizedBox(
                height: 9,
              ),
              _errorMessage(),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _handleSignin();
                  }
                },
                child: const Text('Log In'),
              ),
              const SizedBox(height: 10.0),
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

  void _handleSignin() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    try {
      authProvider.signIn(email: email, password: password);
      Navigator.pushNamed(context, '/profile');
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
      });
    }
  }
}