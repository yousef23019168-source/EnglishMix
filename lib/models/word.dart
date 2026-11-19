import 'package:uuid/uuid.dart';

import 'category.dart';

class Word {
  static const Uuid _uuid = Uuid();

  final String id;
  final String english;
  final String arabic;
  final Category category;
  final Subcategory? subcategory;
  final String? imagePath;

  Word({
    String? id,
    required this.english,
    required this.arabic,
    required this.category,
    this.subcategory,
    this.imagePath,
  }) : id = id ?? _uuid.v4();
}
