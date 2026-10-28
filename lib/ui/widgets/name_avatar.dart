import 'package:cached_network_image/cached_network_image.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/image_cache.dart';

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
    final image = url == null || url.isEmpty
        ? null
        : CachedNetworkImage(
            imageUrl: url,
            cacheManager: FeibaImageCache.managerFor(url),
            fit: BoxFit.cover,
            width: size,
            height: size,
            memCacheWidth: (size * MediaQuery.devicePixelRatioOf(context))
                .round()
                .clamp(1, 1024),
            fadeInDuration: const Duration(milliseconds: 120),
            placeholder: (_, _) => const SizedBox.shrink(),
            errorWidget: (_, _, _) => const SizedBox.shrink(),
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
      child: ClipOval(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[fallback, image ?? const SizedBox.shrink()],
        ),
      ),
    );
  }
}
