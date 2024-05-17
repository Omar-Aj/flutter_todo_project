import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:provider/provider.dart';
import 'package:flutter_todo_project/provider_auth.dart';
import 'package:flutter_todo_project/components/app_bar.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  String? errorMessage = '';
  Text _errorMessage() {
    return Text(
      errorMessage == '' ? '' : 'Umm! $errorMessage.',
      style: TextStyle(
        color: Colors.red[400],
      ),
    );
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();

  late AuthenticationProvider authProvider;

  @override
  Widget build(BuildContext context) {
    authProvider = Provider.of<AuthenticationProvider>(context);

    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: appBar(colorScheme, "Sign Up"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  prefixIcon: const Icon(Icons.email),
                  prefixIconColor: colorScheme.primary,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: const Icon(Icons.password),
                  prefixIconColor: colorScheme.primary,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "Name",
                  prefixIcon: const Icon(Icons.person),
                  prefixIconColor: colorScheme.primary,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: _mobileController,
                decoration: InputDecoration(
                  labelText: "Enter Mobile Number",
                  prefixIcon: const Icon(Icons.mobile_friendly),
                  prefixIconColor: colorScheme.primary,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 80),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _handleSignUp();
                  }
                },
                child: const Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final DatabaseReference userRef =
      FirebaseDatabase.instance.ref().child("User");
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _handleSignUp() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final name = _nameController.text.trim();
    final mobileNumber = _mobileController.text.trim();
    if (email.isNotEmpty &&
        password.isNotEmpty &&
        name.isNotEmpty &&
        mobileNumber.isNotEmpty) {
      authProvider.signUp(
        email: email,
        password: password,
        name: name,
        mobileNumber: mobileNumber,
      );

      try {
        Map<dynamic, dynamic> user = {
          "email": email,
          "password": password,
          "name": name,
          "phonenumber": mobileNumber
        };
        userRef.child(_auth.currentUser!.uid).set(user).then((value) {
          print("Add");
          Navigator.pushNamed(context, '/profile');
        }).catchError((error) {
          print("Faild");
        });
      } on FirebaseException catch (error) {
        print("Error");
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields.'),
        ),
      );
    }
  }
}
