import 'package:flutter/material.dart';

AppBar appBar(ColorScheme colorScheme, String title) {
  return AppBar(
    title: Text(title),
    backgroundColor: colorScheme.primary,
    foregroundColor: colorScheme.onPrimary,
  );
}
