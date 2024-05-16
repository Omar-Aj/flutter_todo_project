import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  late AuthProvider_ authProvider;

  @override
  Widget build(BuildContext context) {
    authProvider = Provider.of<AuthProvider_>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[200],
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 80.0),
              TextFormField(
                decoration: InputDecoration(
                    icon: Icon(Icons.email_outlined,
                      color: Colors.deepPurple[200],
                    ),
                    labelText: "Enter Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    )
                ),
                controller: _emailController,
              ),
              SizedBox(
                height: 10,
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                decoration: InputDecoration(
                    icon: Icon(Icons.password_outlined,
                      color: Colors.deepPurple[200],
                    ),
                    labelText: "Enter Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    )
                ),
                controller: _passwordController,
              ),
              SizedBox(
                height: 10,
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                decoration: InputDecoration(
                    icon: Icon(Icons.person,
                      color: Colors.deepPurple[200],
                    ),
                    labelText: "Enter Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    )
                ),
                controller: _nameController,
              ),
              SizedBox(
                height: 10,
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                decoration: InputDecoration(
                    icon: Icon(Icons.mobile_friendly,
                      color: Colors.deepPurple[200],
                    ),
                    labelText: "Enter Mobile Number",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    )
                ),
                controller: _mobileController,
              ),
              SizedBox(height: 30.0),
              const SizedBox(height: 30.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _handleSignUp();
                  }
                },
                child: Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final DatabaseReference userRef=FirebaseDatabase.instance.ref().child("User");
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

      try{
        Map<dynamic,dynamic> user={
          "email":email,
          "password":password,
          "name":name,
          "phonenumber":mobileNumber
        };
        userRef.child(_auth.currentUser!.uid).set(user).then(
                (value) {
              print("Add");
              Navigator.pushNamed(context, '/profile');
            }

        ).catchError((error){
          print("Faild");
        });
      } on FirebaseException catch(error){
        print("Error");
      }

    }else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all fields.'),
        ),
      );
    }
  }
}