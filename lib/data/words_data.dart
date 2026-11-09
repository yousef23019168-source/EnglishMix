import '../models/category.dart';
import '../models/word.dart';

final List<Word> words = [
  // Greetings and Goodbyes
  Word(
    english: 'Hello',
    arabic: 'مرحبا',
    category: Category.greetings,
    subcategory: Subcategory.greetings,
  ),
  Word(
    english: 'Goodbye',
    arabic: 'مع السلامة',
    category: Category.greetings,
    subcategory: Subcategory.goodbyes,
  ),
  Word(
    english: 'Welcome',
    arabic: 'أهلاً بيك',
    category: Category.greetings,
    subcategory: Subcategory.greetings,
  ),
  Word(english: 'Thanks', arabic: 'شكراً', category: Category.greetings),

  // Food and Drinks
  Word(english: 'Water', arabic: 'مياه', category: Category.food),
  Word(english: 'Bread', arabic: 'عيش', category: Category.food),
  Word(english: 'Milk', arabic: 'لبن', category: Category.food),
  Word(english: 'Tea', arabic: 'شاي', category: Category.food),

  // Education
  Word(english: 'Book', arabic: 'كتاب', category: Category.education),
  Word(english: 'Pen', arabic: 'قلم', category: Category.education),
  Word(english: 'Teacher', arabic: 'مدرس', category: Category.education),

  // Daily Conversations
  Word(english: 'Friend', arabic: 'صاحب', category: Category.daily),
  Word(english: 'House', arabic: 'بيت', category: Category.daily),
  Word(english: 'Time', arabic: 'وقت', category: Category.daily),
];
