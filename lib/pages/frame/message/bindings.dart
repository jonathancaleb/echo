import 'package:echo/pages/frame/message/controller.dart';
import 'package:get/get.dart';

class MessageBinding implements Bindings {
  //dependency injection
  @override
  void dependencies() {
    Get.lazyPut<MessageController>(() => MessageController());
  }
}
