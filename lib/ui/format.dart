String compactCount(int value) {
  if (value >= 100000000) {
    final n = value / 100000000;
    return '${n.toStringAsFixed(n >= 10 ? 0 : 1)}亿';
  }
  if (value >= 10000) {
    final n = value / 10000;
    return '${n.toStringAsFixed(n >= 10 ? 0 : 1)}万';
  }
  if (value >= 1000) {
    final n = value / 1000;
    return '${n.toStringAsFixed(n >= 10 ? 0 : 1)}k';
  }
  return '$value';
}

String relativeTime(int seconds) {
  if (seconds <= 0) return '';
  final then = DateTime.fromMillisecondsSinceEpoch(seconds * 1000);
  final diff = DateTime.now().difference(then);
  if (diff.inMinutes < 1) return '刚刚';
  if (diff.inMinutes < 60) return '${diff.inMinutes} 分钟前';
  if (diff.inHours < 24) return '${diff.inHours} 小时前';
  if (diff.inDays < 7) return '${diff.inDays} 天前';
  if (diff.inDays < 30) return '${(diff.inDays / 7).floor()} 周前';
  return '${then.year}-${then.month.toString().padLeft(2, '0')}-${then.day.toString().padLeft(2, '0')}';
}
