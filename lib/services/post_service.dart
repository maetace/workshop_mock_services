import 'package:workshop_0/services/models/post_item.dart';

abstract class PostService {
  Future<List<PostItem>> getPostItems({int pageIndex = 1, int pageSize = 3});

  Future<PostItem> createPostItem({
    required String description,
    required List<String> images,
  });
}
