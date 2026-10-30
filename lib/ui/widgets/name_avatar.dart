import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/image_cache.dart';

class NameAvatar extends StatelessWidget {
  const NameAvatar({
    super.key,
    required this.name,
    this.imageUrl,
    this.imageBytes,
    this.size = 40,
    this.radius,
  });

  final String name;
  final String? imageUrl;
  final Uint8List? imageBytes;
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
    final image = imageBytes != null && imageBytes!.isNotEmpty
        ? Image.memory(
            imageBytes!,
            fit: BoxFit.cover,
            width: size,
            height: size,
            gaplessPlayback: true,
          )
        : url == null || url.isEmpty
        ? null
        : _CachedAvatarImage(url: url, size: size);
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

class _CachedAvatarImage extends StatefulWidget {
  const _CachedAvatarImage({required this.url, required this.size});

  final String url;
  final double size;

  @override
  State<_CachedAvatarImage> createState() => _CachedAvatarImageState();
}

class _CachedAvatarImageState extends State<_CachedAvatarImage> {
  late Future<FileInfo?> _fileFuture;

  @override
  void initState() {
    super.initState();
    _fileFuture = _cachedFile();
  }

  @override
  void didUpdateWidget(covariant _CachedAvatarImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.url != widget.url) _fileFuture = _cachedFile();
  }

  Future<FileInfo?> _cachedFile() {
    return FeibaImageCache.managerFor(widget.url).getFileFromCache(widget.url);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FileInfo?>(
      future: _fileFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox.shrink();
        }
        final file = snapshot.data?.file;
        if (file != null && file.existsSync()) {
          return Image.file(
            file,
            fit: BoxFit.cover,
            width: widget.size,
            height: widget.size,
            gaplessPlayback: true,
            cacheWidth: (widget.size * MediaQuery.devicePixelRatioOf(context))
                .round()
                .clamp(1, 1024),
            errorBuilder: (_, _, _) => const SizedBox.shrink(),
          );
        }
        return CachedNetworkImage(
          imageUrl: widget.url,
          cacheManager: FeibaImageCache.managerFor(widget.url),
          fit: BoxFit.cover,
          width: widget.size,
          height: widget.size,
          memCacheWidth: (widget.size * MediaQuery.devicePixelRatioOf(context))
              .round()
              .clamp(1, 1024),
          fadeInDuration: const Duration(milliseconds: 120),
          placeholder: (_, _) => const SizedBox.shrink(),
          errorWidget: (_, _, _) => Image.network(
            widget.url,
            fit: BoxFit.cover,
            width: widget.size,
            height: widget.size,
            errorBuilder: (_, _, _) => const SizedBox.shrink(),
          ),
        );
      },
    );
  }
}