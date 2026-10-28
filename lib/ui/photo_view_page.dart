import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../core/image_cache.dart';

import 'package:flutter/services.dart';

import '../core/image_saver.dart';

/// Full-screen image viewer with pinch zoom and swipe between images.
class PhotoViewPage extends StatefulWidget {
  const PhotoViewPage({super.key, required this.urls, this.initialIndex = 0});

  final List<String> urls;
  final int initialIndex;

  @override
  State<PhotoViewPage> createState() => _PhotoViewPageState();
}

class _PhotoViewPageState extends State<PhotoViewPage> {
  late final PageController _controller = PageController(
    initialPage: widget.initialIndex,
  );
  late int _index = widget.initialIndex;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          PageView.builder(
            controller: _controller,
            itemCount: widget.urls.length,
            onPageChanged: (i) => setState(() => _index = i),
            itemBuilder: (context, index) {
              return InteractiveViewer(
                minScale: 1,
                maxScale: 4,
                child: Center(
                  child: CachedNetworkImage(
                    imageUrl: widget.urls[index],
                    cacheManager: FeibaImageCache.managerFor(
                      widget.urls[index],
                    ),
                    fit: BoxFit.contain,
                    fadeInDuration: const Duration(milliseconds: 120),
                    placeholder: (_, _) => const Center(
                      child: CircularProgressIndicator(color: Colors.white70),
                    ),
                    errorWidget: (_, _, _) => const Icon(
                      Icons.broken_image_outlined,
                      color: Colors.white54,
                      size: 48,
                    ),
                  ),
                ),
              );
            },
          ),
          SafeArea(
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
                      final file = await ImageSaver.save(widget.urls[_index]);
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
                    ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(content: Text('已复制图片链接')));
                  },
                  icon: const Icon(Icons.link, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
