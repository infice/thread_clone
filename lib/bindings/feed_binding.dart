import 'package:get/get.dart';
import '../controllers/feed_controller.dart';
import '../services/post_service.dart';

class FeedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IPostService>(() => MockPostService());
    Get.lazyPut<FeedController>(() => FeedController(Get.find<IPostService>()));
  }
} 