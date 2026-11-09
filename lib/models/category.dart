import 'package:flutter/material.dart';

enum Category {
  greetings('Greetings and Goodbyes', Icons.waving_hand),
  daily('Daily Conversations', Icons.chat_bubble_outline),
  education('Education', Icons.school),
  food('Food and Drinks', Icons.restaurant);

  const Category(this.label, this.icon);

  final String label;
  final IconData icon;

  List<Subcategory> get subcategories =>
      Subcategory.values.where((s) => s.parent == this).toList();
}

enum Subcategory {
  greetings('Greetings', Icons.waving_hand, Category.greetings),
  goodbyes('Goodbyes', Icons.logout, Category.greetings),
  atHome('At Home', Icons.home, Category.daily),
  shopping('Shopping', Icons.shopping_bag, Category.daily);

  const Subcategory(this.label, this.icon, this.parent);

  final String label;
  final IconData icon;
  final Category parent;
}
