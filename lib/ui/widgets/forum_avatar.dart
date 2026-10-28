import 'package:material_ui/material_ui.dart';

import '../../data/protocol_browse_repository.dart';
import 'name_avatar.dart';

/// Forum avatar with a shared, lazily resolved protocol lookup.
class ForumAvatar extends StatefulWidget {
  const ForumAvatar({
    super.key,
    required this.name,
    required this.repo,
    this.size = 36,
  });

  final String name;
  final ProtocolBrowseRepository repo;
  final double size;

  @override
  State<ForumAvatar> createState() => _ForumAvatarState();
}

class _ForumAvatarState extends State<ForumAvatar> {
  late final Future<String?> _avatar = widget.repo.forumAvatar(widget.name);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _avatar,
      builder: (context, snapshot) => NameAvatar(
        name: widget.name,
        imageUrl: snapshot.data,
        size: widget.size,
      ),
    );
  }
}
