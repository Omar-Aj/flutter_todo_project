import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: appBar(context),
      body: Container(
        margin: EdgeInsets.only(top: 96),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            profileDetails(colorScheme),
          ],
        ),
      ),
    );
  }

  Container profileDetails(ColorScheme colorScheme) {
    TextEditingController emailController = TextEditingController();
    emailController.text = "test";
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 4),
            alignment: Alignment.centerLeft,
            child: Text("Email"),
          ),
          SizedBox(height: 4),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: colorScheme.surfaceContainer,
                borderRadius: BorderRadius.circular(8)),
            child: Column(
              children: [
                Text(
                  "example@example.com",
                  style: TextStyle(color: colorScheme.onSurface),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Container(
            margin: EdgeInsets.only(left: 4),
            alignment: Alignment.centerLeft,
            child: Text("Password"),
          ),
          SizedBox(height: 4),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: colorScheme.surfaceContainer,
                borderRadius: BorderRadius.circular(8)),
            child: Column(
              children: [
                Text(
                  "••••••••••••",
                  style: TextStyle(color: colorScheme.onSurface),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      title: const Text("Profile"),
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
    );
  }
}
