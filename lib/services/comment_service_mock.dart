import 'package:get/get.dart';
import 'package:workshop_0/services/comment_service.dart';
import 'package:workshop_0/services/models/comment_item.dart';
import 'package:workshop_0/utils.dart';

class CommentServiceMock extends GetxService implements CommentService {
  late List<CommentItem> _items;

  @override
  void onInit() {
    _items = [
      CommentItem(
        id: 'comment.${randomString(30)}',
        ownerName: 'demouser',
        ownerImage: 'assets/images/avatar.webp',
        message: 'I love it',
      ),
      CommentItem(
        id: 'comment.${randomString(30)}',
        ownerName: 'demouser',
        ownerImage: 'assets/images/avatar.webp',
        message: 'It\'s OK',
      ),
      CommentItem(
        id: 'comment.${randomString(30)}',
        ownerName: 'demouser',
        ownerImage: 'assets/images/avatar.webp',
        message: 'Hahaha',
      ),
      CommentItem(
        id: 'comment.${randomString(30)}',
        ownerName: 'demouser',
        ownerImage: 'assets/images/avatar.webp',
        message: 'Wow',
      ),
      CommentItem(
        id: 'comment.${randomString(30)}',
        ownerName: 'demouser',
        ownerImage: 'assets/images/avatar.webp',
        message: 'Hello',
      ),
      CommentItem(
        id: 'comment.${randomString(30)}',
        ownerName: 'demouser',
        ownerImage: 'assets/images/avatar.webp',
        message: 'That\'s right',
      ),
      CommentItem(
        id: 'comment.${randomString(30)}',
        ownerName: 'demouser',
        ownerImage: 'assets/images/avatar.webp',
        message: 'Hehehe',
      ),
    ];
    super.onInit();
  }

  @override
  Future<List<CommentItem>> getComments(
    String postId, {
    int pageIndex = 1,
    int pageSize = 3,
  }) async {
    // simulate api calling
    await 3.delay();
    var items = <CommentItem>[];
    var index = (pageIndex - 1) * pageSize;
    while (index < _items.length) {
      items.add(_items[index]);
      if (items.length == pageSize) {
        break;
      }
      index++;
    }
    return items;
  }

  @override
  Future<CommentItem> createCommentItem(String message) async {
    // simulate api calling
    await 3.delay();
    var item = CommentItem(
      id: 'comment.${randomString(30)}',
      ownerName: 'demouser',
      ownerImage: 'assets/images/avatar.webp',
      message: message,
    );
    _items.insert(0, item);
    return item;
  }
}
