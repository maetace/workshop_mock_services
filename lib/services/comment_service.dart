import 'package:workshop_0/services/models/comment_item.dart';

abstract class CommentService {
  Future<List<CommentItem>> getComments(
    String postId, {
    int pageIndex = 1,
    int pageSize = 3,
  });

  Future<CommentItem> createCommentItem(String message);
}
