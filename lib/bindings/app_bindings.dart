import 'package:get/get.dart';

import '../controller/home_screen_controller.dart';
import '../controller/offline_news_controller.dart';
import '../controller/online_news_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<HomeScreenController>(() => HomeScreenController());
    Get.lazyPut<OnlineNewsController>(() => OnlineNewsController());
    Get.lazyPut<OfflineNewsController>(() => OfflineNewsController());
  }
}
