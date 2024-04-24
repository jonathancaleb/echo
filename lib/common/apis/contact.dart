import 'package:echo/common/entities/entities.dart';
import 'package:echo/common/utils/utils.dart';

class ContactAPI {
  /// 翻页
  /// refresh 是否刷新
  static Future<ContactResponseEntity> postcontact() async {
    var response = await HttpUtil().post(
      'api/contact',
    );
    return ContactResponseEntity.fromJson(response);
  }
}
