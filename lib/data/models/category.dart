import 'package:flutter/material.dart';

class Category {
  final int id;
  final String title;
  final IconData icon;
  final Color colorBg;
  final Color colorIcon;

  Category({
    required this.id,
    required this.title,
    required this.icon,
    required this.colorBg,
    required this.colorIcon,
  });
}
