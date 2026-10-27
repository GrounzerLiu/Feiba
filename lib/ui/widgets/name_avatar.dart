import 'package:flutter/material.dart';

class NameAvatar extends StatelessWidget {
  const NameAvatar({
    super.key,
    required this.name,
    this.imageUrl,
    this.size = 40,
    this.radius,
  });

  final String name;
  final String? imageUrl;
  final double size;
  final double? radius;

  static const List<Color> _colors = <Color>[
    Color(0xFF5B8DEF),
    Color(0xFF7C6CF2),
    Color(0xFF3FAE8F),
    Color(0xFFE38B4D),
    Color(0xFFD9647A),
    Color(0xFF4C9DBD),
    Color(0xFF8F7A5C),
  ];

  Color get _fallbackColor {
    if (name.isEmpty) return _colors.first;
    var hash = 0;
    for (final unit in name.codeUnits) {
      hash = (hash * 31 + unit) & 0x7fffffff;
    }
    return _colors[hash % _colors.length];
  }

  String get _initial {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return '?';
    return String.fromCharCode(trimmed.runes.first).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final fallback = Container(
      color: _fallbackColor,
      alignment: Alignment.center,
      child: Text(
        _initial,
        style: TextStyle(
          color: Colors.white,
          fontSize: size * 0.4,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
    final url = imageUrl;
    final child = url == null || url.isEmpty
        ? fallback
        : Image.network(
            url,
            fit: BoxFit.cover,
            width: size,
            height: size,
            errorBuilder: (_, _, _) => fallback,
          );
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Theme.of(context).colorScheme.surface,
          width: 1.5,
        ),
      ),
      // Do not rely on the parent Container's decoration clipping here:
      // explicitly clip the image so every avatar is a true circle.
      child: ClipOval(child: child),
    );
  }
}
