class PostItem {
  final String id;
  final String ownerName;
  final String ownerImage;
  final List<String> images;
  final int likes;
  final int comments;
  final String description;
  final DateTime createdDate;

  PostItem({
    required this.id,
    required this.ownerName,
    required this.ownerImage,
    required this.images,
    required this.likes,
    required this.comments,
    required this.description,
    required this.createdDate,
  });
}
