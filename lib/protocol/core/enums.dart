/// Enumerations mirrored from aiotieba.
library;

enum Gender {
  unknown(0),
  male(1),
  female(2);

  const Gender(this.value);
  final int value;

  static Gender fromValue(int value) => Gender.values.firstWhere(
    (e) => e.value == value,
    orElse: () => Gender.unknown,
  );
}

enum PrivLike {
  unknown(0),
  visible(1),
  friend(2),
  hidden(3);

  const PrivLike(this.value);
  final int value;

  static PrivLike fromValue(int value) => PrivLike.values.firstWhere(
    (e) => e.value == value,
    orElse: () => PrivLike.unknown,
  );
}

enum PrivReply {
  unknown(0),
  all(1),
  fans(5),
  follow(6);

  const PrivReply(this.value);
  final int value;

  static PrivReply fromValue(int value) => PrivReply.values.firstWhere(
    (e) => e.value == value,
    orElse: () => PrivReply.unknown,
  );
}

enum ThreadType {
  unknown(-1),
  article(0),
  album(1),
  externalShare(6),
  voice(11),
  netdisk(14),
  story(31),
  video(40),
  live(50),
  help(71),
  vote(75),
  lottery(76);

  const ThreadType(this.value);
  final int value;

  static ThreadType fromValue(int value) => ThreadType.values.firstWhere(
    (e) => e.value == value,
    orElse: () => ThreadType.unknown,
  );
}

enum ThreadSortType {
  reply(6),
  create(1),
  hot(3),
  follow(2);

  const ThreadSortType(this.value);
  final int value;
}

enum PostSortType {
  asc(0),
  desc(1),
  hot(2);

  const PostSortType(this.value);
  final int value;
}

enum CommentSortType {
  asc(0),
  desc(1),
  hot(2);

  const CommentSortType(this.value);
  final int value;
}

enum ContentType {
  unknown(0),
  thread(1),
  post(2),
  comment(3);

  const ContentType(this.value);
  final int value;

  static ContentType fromValue(int value) => ContentType.values.firstWhere(
    (e) => e.value == value,
    orElse: () => ContentType.unknown,
  );
}

enum SearchInForumType {
  all(0),
  time(1),
  relation(2);

  const SearchInForumType(this.value);
  final int value;
}

enum SearchGlobalType {
  asc(0),
  relation(2),
  desc(5);

  const SearchGlobalType(this.value);
  final int value;
}

enum BlacklistType {
  none(0),
  follow(1),
  interact(2),
  chat(4),
  all(7);

  const BlacklistType(this.value);
  final int value;
}
