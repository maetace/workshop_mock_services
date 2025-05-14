import 'package:get/get.dart';
import 'package:workshop_0/services/models/post_item.dart';
import 'package:workshop_0/services/post_service.dart';
import 'package:workshop_0/utils.dart';

class PostServiceMock extends GetxService implements PostService {
  late List<PostItem> _items;

  @override
  void onInit() {
    _items = [
      PostItem(
        id: 'post.${randomString(30)}',
        ownerName: 'demouser',
        ownerImage: 'assets/images/avatar.webp',
        images: [
          'assets/images/facebook.webp',
          'assets/images/instagram.webp',
          'assets/images/tiktok.webp',
          'assets/images/x.webp',
          'assets/images/threads.webp',
        ],
        likes: 100,
        comments: 10,
        description: 'What is your fav app?',
        createdDate: DateTime.now().subtract(Duration(days: 150)),
      ),
      PostItem(
        id: 'post.${randomString(30)}',
        ownerName: 'demouser',
        ownerImage: 'assets/images/avatar.webp',
        images: ['assets/images/instagram.webp', 'assets/images/facebook.webp'],
        likes: 100,
        comments: 10,
        description: 'My 2 fav apps from META',
        createdDate: DateTime.now().subtract(Duration(days: 100)),
      ),
      PostItem(
        id: 'post.${randomString(30)}',
        ownerName: 'demouser',
        ownerImage: 'assets/images/avatar.webp',
        images: ['assets/images/tiktok.webp'],
        likes: 50,
        comments: 100,
        description: 'Who loved this app like me!',
        createdDate: DateTime.now().subtract(Duration(days: 50)),
      ),
      PostItem(
        id: 'post.${randomString(30)}',
        ownerName: 'demouser',
        ownerImage: 'assets/images/avatar.webp',
        images: ['assets/images/threads.webp', 'assets/images/x.webp'],
        likes: 1010,
        comments: 101,
        description: 'Threads or X?',
        createdDate: DateTime.now().subtract(Duration(days: 10)),
      ),
      PostItem(
        id: 'post.${randomString(30)}',
        ownerName: 'demouser',
        ownerImage: 'assets/images/avatar.webp',
        images: ['assets/images/x.webp'],
        likes: 150,
        comments: 110,
        description: 'I away from this app now!',
        createdDate: DateTime.now(),
      ),
    ];

    super.onInit();
  }

  @override
  Future<List<PostItem>> getPostItems({
    int pageIndex = 1,
    int pageSize = 3,
  }) async {
    // simulate api calling
    await 3.delay();
    var items = <PostItem>[];
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
  Future<PostItem> createPostItem({
    required String description,
    required List<String> images,
  }) async {
    // simulate api calling
    await 3.delay();
    var item = PostItem(
      id: 'post.${randomString(30)}',
      ownerName: 'demouser',
      ownerImage: 'assets/images/avatar.webp',
      images: images,
      likes: 0,
      comments: 0,
      description: description,
      createdDate: DateTime.now(),
    );
    _items.insert(0, item);
    return item;
  }
}
