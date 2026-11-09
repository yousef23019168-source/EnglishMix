import 'package:flutter/material.dart';

import '../data/sentences_data.dart';
import '../data/words_data.dart';
import '../models/sentence.dart';
import '../models/word.dart';
import 'categories_screen.dart';
import 'category_navigation.dart';
import 'sentences_screen.dart';
import 'words_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    CategoriesScreen(
      title: 'Sentences',
      items: buildCategoryItems<Sentence>(
        items: sentences,
        categoryOf: (s) => s.category,
        subcategoryOf: (s) => s.subcategory,
        itemsName: 'sentences',
        listScreen: (title, list) => SentencesScreen(title: title, items: list),
      ),
    ),
    CategoriesScreen(
      title: 'Words',
      items: buildCategoryItems<Word>(
        items: words,
        categoryOf: (w) => w.category,
        subcategoryOf: (w) => w.subcategory,
        itemsName: 'words',
        listScreen: (title, list) => WordsScreen(title: title, items: list),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.chat_bubble_outline),
            selectedIcon: Icon(Icons.chat_bubble),
            label: 'Sentences',
          ),
          NavigationDestination(
            icon: Icon(Icons.abc),
            selectedIcon: Icon(Icons.abc),
            label: 'Words',
          ),
        ],
      ),
    );
  }
}
