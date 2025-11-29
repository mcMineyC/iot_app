import 'package:flutter/material.dart';
extension Snackbarable on BuildContext {
  void showSnackbar(String text) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(text),));
  }
}