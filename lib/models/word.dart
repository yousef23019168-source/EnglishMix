import 'package:uuid/uuid.dart';

import 'category.dart';

class Word {
  static const Uuid _uuid = Uuid();

  final String id;
  final String english;
  final String arabic;
  final Category category;
  final Subcategory? subcategory;

  Word({
    String? id,
    required this.english,
    required this.arabic,
    required this.category,
    this.subcategory,
  }) : id = id ?? _uuid.v4();
}
