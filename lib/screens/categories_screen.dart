import 'package:flutter/material.dart';

import '../models/category.dart';
import '../theme/app_colors.dart';
import '../theme/theme_controller.dart';

class CategoryItem {
  final String label;
  final IconData icon;
  final String subtitle; // سطر صغير تحت الاسم (ممكن يبقى فاضي)
  final int? count; // العدد اللي بيظهر في الـ pill
  final Category? category; // بيحدد لون الكارت
  final void Function(BuildContext context) onTap;

  const CategoryItem({
    required this.label,
    required this.icon,
    required this.onTap,
    this.subtitle = '',
    this.count,
    this.category,
  });
}

/// شاشة التصنيفات (شبكة + بحث).
/// - من غير [parent]: الشاشة الرئيسية (Sentences / Words) بكروت ملونة.
/// - مع [parent]: شاشة التصنيفات الفرعية بهيدر ملون وكروت بيضاء.
class CategoriesScreen extends StatefulWidget {
  final String title;
  final List<CategoryItem> items;
  final Category? parent;
  final int? totalCount;
  final String itemsName;

  const CategoriesScreen({
    super.key,
    required this.title,
    required this.items,
    this.parent,
    this.totalCount,
    this.itemsName = '',
  });

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  String _query = '';

  bool get _isSub => widget.parent != null;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = Theme.of(context).extension<AppColors>()!;
    final q = _query.trim().toLowerCase();
    final shown = q.isEmpty
        ? widget.items
        : widget.items.where((i) => i.label.toLowerCase().contains(q)).toList();

    return Scaffold(
      body: Column(
        children: [
          if (_isSub)
            _HeroHeader(
              title: widget.title,
              icon: widget.parent!.icon,
              gradient: colors.gradientFor(widget.parent),
              pills: [
                if (widget.totalCount != null)
                  '${widget.totalCount} ${widget.itemsName}',
                '${widget.items.length - 1} topics',
              ],
            )
          else
            _RootHeader(title: widget.title),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
            child: TextField(
              onChanged: (v) => setState(() => _query = v),
              decoration: InputDecoration(
                hintText: _isSub ? 'Search in ${widget.title}…' : 'Search…',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: scheme.surfaceContainerLow,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(26),
                  borderSide: BorderSide(color: scheme.outlineVariant),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(26),
                  borderSide: BorderSide(color: scheme.primary, width: 1.5),
                ),
              ),
            ),
          ),
          Expanded(
            child: shown.isEmpty
                ? Center(
                    child: Text(
                      'No results',
                      style: TextStyle(color: scheme.onSurfaceVariant),
                    ),
                  )
                : LayoutBuilder(
                    builder: (context, c) => GridView.builder(
                      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: (c.maxWidth / 180).floor().clamp(2, 6),
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        mainAxisExtent: 148,
                      ),
                      itemCount: shown.length,
                      itemBuilder: (context, i) {
                        final item = shown[i];
                        final g = colors.gradientFor(item.category);
                        return _isSub
                            ? _TopicCard(item: item, accent: g.last)
                            : _GradientTile(item: item, gradient: g);
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class _RootHeader extends StatelessWidget {
  final String title;
  const _RootHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = Theme.of(context).extension<AppColors>()!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        20,
        MediaQuery.of(context).padding.top + 14,
        20,
        0,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w800,
                color: scheme.onSurface,
              ),
            ),
          ),
          Material(
            color: colors.chipBg,
            shape: const CircleBorder(),
            child: IconButton(
              icon: Icon(
                isDark ? Icons.light_mode : Icons.dark_mode,
                color: scheme.primary,
              ),
              onPressed: () => ThemeController.set(
                isDark ? ThemeMode.light : ThemeMode.dark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroHeader extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Color> gradient;
  final List<String> pills;

  const _HeroHeader({
    required this.title,
    required this.icon,
    required this.gradient,
    required this.pills,
  });

  @override
  Widget build(BuildContext context) {
    final white24 = Colors.white.withValues(alpha: .25);

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(34)),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradient,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -60,
              right: -40,
              child: _Circle(
                size: 180,
                color: Colors.white.withValues(alpha: .14),
              ),
            ),
            Positioned(
              bottom: -30,
              left: -30,
              child: _Circle(
                size: 110,
                color: Colors.white.withValues(alpha: .10),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                20,
                MediaQuery.of(context).padding.top + 14,
                20,
                24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Material(
                        color: white24,
                        shape: const CircleBorder(),
                        child: IconButton(
                          icon: const Icon(
                            Icons.chevron_left,
                            color: Colors.white,
                          ),
                          onPressed: () => Navigator.maybePop(context),
                        ),
                      ),
                      const Spacer(),
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: white24,
                        child: Icon(icon, color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 28,
                      height: 1.2,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: [
                      for (final p in pills)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: .22),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            p,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Circle extends StatelessWidget {
  final double size;
  final Color color;
  const _Circle({required this.size, required this.color});

  @override
  Widget build(BuildContext context) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(shape: BoxShape.circle, color: color),
  );
}

/// كارت ملون للتصنيفات الرئيسية
class _GradientTile extends StatelessWidget {
  final CategoryItem item;
  final List<Color> gradient;

  const _GradientTile({required this.item, required this.gradient});

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(26);

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: radius,
        boxShadow: [
          BoxShadow(
            color: gradient.last.withValues(alpha: .28),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: radius,
        child: Material(
          color: Colors.transparent,
          child: Ink(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: gradient,
              ),
            ),
            child: InkWell(
              onTap: () => item.onTap(context),
              child: Stack(
                children: [
                  Positioned(
                    top: -30,
                    right: -30,
                    child: _Circle(
                      size: 100,
                      color: Colors.white.withValues(alpha: .14),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 21,
                              backgroundColor: Colors.white.withValues(
                                alpha: .22,
                              ),
                              child: Icon(item.icon, color: Colors.white),
                            ),
                            const Spacer(),
                            if (item.count != null)
                              _Pill(
                                text: '${item.count}',
                                bg: Colors.white.withValues(alpha: .24),
                                fg: Colors.white,
                              ),
                          ],
                        ),
                        const Spacer(),
                        Text(
                          item.label,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                            height: 1.25,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                        if (item.subtitle.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Text(
                              item.subtitle,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withValues(alpha: .85),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// كارت أبيض للتصنيفات الفرعية (بلون التصنيف الأب)
class _TopicCard extends StatelessWidget {
  final CategoryItem item;
  final Color accent;

  const _TopicCard({required this.item, required this.accent});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = Theme.of(context).extension<AppColors>()!;

    return Card(
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: () => item.onTap(context),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: accent.withValues(alpha: .15),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(item.icon, color: accent, size: 22),
                  ),
                  const Spacer(),
                  if (item.count != null)
                    _Pill(
                      text: '${item.count}',
                      bg: colors.chipBg,
                      fg: scheme.primary,
                    ),
                ],
              ),
              const Spacer(),
              Text(
                item.label,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.3,
                  fontWeight: FontWeight.w700,
                  color: scheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  final String text;
  final Color bg, fg;
  const _Pill({required this.text, required this.bg, required this.fg});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(
      text,
      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: fg),
    ),
  );
}
