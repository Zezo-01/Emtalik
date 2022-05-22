// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

Widget button({
  required String title,
  required IconData icon,
  required VoidCallback onPress,
}) =>
    ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(56),
        primary: Colors.blue,
        onPrimary: Colors.orange,
        textStyle: TextStyle(fontSize: 30),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 28,
          ),
          const SizedBox(
            width: 16,
          ),
          Text(title),
        ],
      ),
      onPressed: onPress,
    );
