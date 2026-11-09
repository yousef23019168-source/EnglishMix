import '../models/category.dart';
import '../models/sentence.dart';

final List<Sentence> sentences = [
  Sentence(
    english: 'Good morning!',
    arabic: 'صباح الخير!',
    category: Category.greetings,
    subcategory: Subcategory.greetings,
  ),
  Sentence(
    english: 'See you later.',
    arabic: 'أشوفك بعدين.',
    category: Category.greetings,
    subcategory: Subcategory.goodbyes,
  ),
  Sentence(
    english: 'Where are you going?',
    arabic: 'رايح فين؟',
    category: Category.daily,
    subcategory: Subcategory.atHome,
  ),
];
