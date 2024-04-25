import 'package:echo/common/routes/names.dart';
import 'package:echo/pages/frame/message/state.dart';
import 'package:get/get.dart';

class MessageController extends GetxController {
  MessageController();
  final state = MessageState();

  //functiom
  void goProfile() async {
    await Get.toNamed(AppRoutes.profile);
  }
}
