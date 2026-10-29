import 'package:cached_network_image/cached_network_image.dart';
import 'package:material_ui/material_ui.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../core/image_cache.dart';

import 'package:flutter/services.dart';

import '../core/image_saver.dart';

/// Route that animates the tapped thumbnail itself into the viewer.
Route<T> imageViewerRoute<T>({
  required Rect sourceRect,
  required String imageUrl,
  required Widget page,
}) {
  return PageRouteBuilder<T>(
    opaque: false,
    barrierColor: Colors.transparent,
    transitionDuration: const Duration(milliseconds: 300),
    reverseTransitionDuration: const Duration(milliseconds: 260),
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
        reverseCurve: Curves.easeInCubic,
      );
      return AnimatedBuilder(
        animation: curved,
        builder: (context, _) {
          final t = curved.value;
          final screen = MediaQuery.sizeOf(context);
          final aspect = sourceRect.width / sourceRect.height;
          var targetWidth = screen.width;
          var targetHeight = targetWidth / aspect;
          if (targetHeight > screen.height) {
            targetHeight = screen.height;
            targetWidth = targetHeight * aspect;
          }
          final targetRect = Rect.fromCenter(
            center: screen.center(Offset.zero),
            width: targetWidth,
            height: targetHeight,
          );
          final rect = Rect.lerp(sourceRect, targetRect, t)!;
          return Stack(
            children: <Widget>[
              Positioned.fill(
                child: Opacity(opacity: t, child: child),
              ),
              if (t < 1)
                Positioned.fromRect(
                  rect: rect,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10 * (1 - t)),
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      cacheManager: FeibaImageCache.managerFor(imageUrl),
                      fit: BoxFit.cover,
                      fadeInDuration: const Duration(milliseconds: 80),
                    ),
                  ),
                ),
            ],
          );
        },
      );
    },
  );
}

/// Full-screen image viewer with pinch zoom, swipe between images and a
/// WeChat-like drag-down-to-dismiss gesture.
class PhotoViewPage extends StatefulWidget {
  const PhotoViewPage({super.key, required this.urls, this.initialIndex = 0});

  final List<String> urls;
  final int initialIndex;

  @override
  State<PhotoViewPage> createState() => _PhotoViewPageState();
}

class _PhotoViewPageState extends State<PhotoViewPage>
    with SingleTickerProviderStateMixin {
  late final PageController _controller = PageController(
    initialPage: widget.initialIndex,
  );
  late final AnimationController _settle = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 220),
  );
  Animation<double>? _settleAnimation;
  late int _index = widget.initialIndex;
  double _dragOffset = 0;

  @override
  void initState() {
    super.initState();
    _settle.addListener(() {
      final animation = _settleAnimation;
      if (animation == null || !mounted) return;
      setState(() => _dragOffset = animation.value);
    });
  }

  @override
  void dispose() {
    _settle.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _resetSettle() {
    _settle.stop();
    _settleAnimation = null;
  }

  void _onDragStart(DragStartDetails details) => _resetSettle();

  void _onDragUpdate(DragUpdateDetails details) {
    setState(() => _dragOffset += details.delta.dy);
  }

  void _onDragEnd(DragEndDetails details) {
    final velocity = details.primaryVelocity ?? 0;
    if (_dragOffset.abs() > 120 || velocity.abs() > 700) {
      Navigator.of(context).maybePop();
      return;
    }
    _settleAnimation = Tween<double>(
      begin: _dragOffset,
      end: 0,
    ).animate(CurvedAnimation(parent: _settle, curve: Curves.easeOutCubic));
    _settle.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    final progress = (_dragOffset.abs() / 320).clamp(0.0, 1.0);
    final background = (1 - progress * 0.72).clamp(0.28, 1.0);
    return Scaffold(
      backgroundColor: Colors.black.withValues(alpha: background),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onVerticalDragStart: _onDragStart,
        onVerticalDragUpdate: _onDragUpdate,
        onVerticalDragEnd: _onDragEnd,
        child: Transform.translate(
          offset: Offset(0, _dragOffset),
          child: Stack(
            children: <Widget>[
              PhotoViewGallery.builder(
                pageController: _controller,
                itemCount: widget.urls.length,
                onPageChanged: (i) {
                  _resetSettle();
                  setState(() {
                    _index = i;
                    _dragOffset = 0;
                  });
                },
                backgroundDecoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                builder: (context, index) {
                  final url = widget.urls[index];
                  return PhotoViewGalleryPageOptions(
                    imageProvider: CachedNetworkImageProvider(
                      url,
                      cacheManager: FeibaImageCache.managerFor(url),
                    ),
                    initialScale: PhotoViewComputedScale.contained,
                    minScale: PhotoViewComputedScale.contained,
                    maxScale: PhotoViewComputedScale.covered * 4,
                  );
                },
                loadingBuilder: (context, event) => const Center(
                  child: CircularProgressIndicator(color: Colors.white70),
                ),
              ),
              SafeArea(
                child: Opacity(
                  opacity: (1 - progress).clamp(0.0, 1.0),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: () => Navigator.of(context).maybePop(),
                        icon: const Icon(Icons.close, color: Colors.white),
                      ),
                      const Spacer(),
                      Text(
                        '${_index + 1} / ${widget.urls.length}',
                        style: const TextStyle(color: Colors.white70),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        tooltip: '保存图片',
                        onPressed: () async {
                          final messenger = ScaffoldMessenger.of(context);
                          messenger.showSnackBar(
                            const SnackBar(content: Text('正在保存…')),
                          );
                          try {
                            final file = await ImageSaver.save(
                              widget.urls[_index],
                            );
                            messenger.showSnackBar(
                              SnackBar(content: Text('已保存到 ${file.path}')),
                            );
                          } catch (e) {
                            messenger.showSnackBar(
                              SnackBar(content: Text('保存失败：$e')),
                            );
                          }
                        },
                        icon: const Icon(Icons.download, color: Colors.white),
                      ),
                      IconButton(
                        tooltip: '复制图片链接',
                        onPressed: () async {
                          await Clipboard.setData(
                            ClipboardData(text: widget.urls[_index]),
                          );
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('已复制图片链接')),
                          );
                        },
                        icon: const Icon(Icons.link, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}