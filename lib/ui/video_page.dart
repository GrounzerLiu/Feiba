import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:material_ui/material_ui.dart';

/// Full-screen Tieba video player backed by media_kit (Windows/Android/macOS).
class VideoPage extends StatefulWidget {
  const VideoPage({
    super.key,
    required this.url,
    this.title,
    this.coverUrl,
  });

  final String url;
  final String? title;
  final String? coverUrl;

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late final Player _player = Player();
  late final VideoController _controller = VideoController(_player);
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _open();
  }

  Future<void> _open() async {
    try {
      await _player.open(Media(widget.url), play: true);
      if (mounted) setState(() => _loading = false);
    } catch (error) {
      if (mounted) {
        setState(() {
          _loading = false;
          _error = error.toString();
        });
      }
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(
          widget.title?.trim().isNotEmpty == true ? widget.title! : '视频',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: Center(
        child: _error != null
            ? Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Icon(
                      Icons.videocam_off_outlined,
                      color: Colors.white70,
                      size: 42,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      '视频播放失败',
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _error!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white54),
                    ),
                  ],
                ),
              )
            : Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Video(controller: _controller),
                  ),
                  if (_loading)
                    const CircularProgressIndicator(color: Colors.white),
                ],
              ),
      ),
    );
  }
}
