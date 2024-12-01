class Publication {
  final User currentUser;
  final String title;
  final DateTime createdAt;
  final String imageUrl;
  final int commentsCount;
  final int sharesCount;
  final Reaction currenReaction;

  Publication({
    required this.currentUser,
    required this.title,
    required this.createdAt,
    required this.imageUrl,
    required this.commentsCount,
    required this.sharesCount,
    required this.currenReaction,
  });
}

class User {
  final String avatar;
  final String username;

  User({required this.avatar, required this.username});
}

enum Reaction {
  like,
  love,
  laughing,
  sad,
  shocking,
  angry;
}
