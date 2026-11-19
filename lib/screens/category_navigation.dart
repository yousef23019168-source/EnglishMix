import 'package:flutter/material.dart';

import '../models/category.dart';
import 'categories_screen.dart';

List<CategoryItem> buildCategoryItems<T>({
  required List<T> items,
  required Category Function(T) categoryOf,
  required Subcategory? Function(T) subcategoryOf,
  required Widget Function(String title, List<T> items) listScreen,
  required String itemsName,
}) {
  final result = <CategoryItem>[];

  void open(BuildContext context, String title, List<T> list) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => listScreen(title, list)),
    );
  }

  for (final category in Category.values) {
    final inCategory = items.where((i) => categoryOf(i) == category).toList();
    if (inCategory.isEmpty) continue;

    final subs = category.subcategories
        .where((s) => inCategory.any((i) => subcategoryOf(i) == s))
        .toList();

    result.add(
      CategoryItem(
        label: category.label,
        icon: category.icon,
        subtitle: subs.isEmpty ? '' : '${subs.length} topics',
        count: inCategory.length,
        category: category,
        onTap: (context) {
          if (subs.isEmpty) {
            open(context, category.label, inCategory);
            return;
          }

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CategoriesScreen(
                title: category.label,
                parent: category,
                totalCount: inCategory.length,
                itemsName: itemsName,
                items: [
                  CategoryItem(
                    label: 'All',
                    icon: Icons.apps,
                    count: inCategory.length,
                    category: category,
                    onTap: (ctx) => open(ctx, category.label, inCategory),
                  ),
                  for (final sub in subs)
                    CategoryItem(
                      label: sub.label,
                      icon: sub.icon,
                      count: inCategory
                          .where((i) => subcategoryOf(i) == sub)
                          .length,
                      category: category,
                      onTap: (ctx) => open(
                        ctx,
                        sub.label,
                        inCategory
                            .where((i) => subcategoryOf(i) == sub)
                            .toList(),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  return result;
}
