import 'package:flutter/material.dart';
import '../theme/theme_controller.dart';

class CategoryItem {
  final String label;
  final IconData icon;
  final String subtitle;
  final void Function(BuildContext context) onTap;

  const CategoryItem({
    required this.label,
    required this.icon,
    required this.subtitle,
    required this.onTap,
  });
}

class CategoriesScreen extends StatelessWidget {
  final String title;
  final List<CategoryItem> items;

  const CategoriesScreen({super.key, required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Theme.of(context).brightness == Brightness.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: () => ThemeController.set(
              Theme.of(context).brightness == Brightness.dark
                  ? ThemeMode.light
                  : ThemeMode.dark,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final CategoryItem item = items[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            elevation: 2,
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              leading: CircleAvatar(
                backgroundColor: colors.primaryContainer,
                child: Icon(item.icon, color: colors.onPrimaryContainer),
              ),
              title: Text(
                item.label,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(item.subtitle),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => item.onTap(context),
            ),
          );
        },
      ),
    );
  }
}
