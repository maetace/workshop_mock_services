class CommentItem {
  final String id;
  final String ownerName;
  final String ownerImage;
  final String message;
  final String postId;

  CommentItem({
    required this.id,
    required this.ownerName,
    required this.ownerImage,
    required this.message,
    this.postId = '',
  });
}
