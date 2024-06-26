import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:echo/common/routes/routes.dart';
import 'package:echo/common/store/store.dart';

import 'package:get/get.dart';

/// 第一次欢迎页面
class RouteWelcomeMiddleware extends GetMiddleware {
  // priority 数字小优先级高
  @override
  int? priority = 0;

  RouteWelcomeMiddleware({required this.priority});

  @override
  RouteSettings? redirect(String? route) {
    if (kDebugMode) {
      print(ConfigStore.to.isFirstOpen);
    }
    if (ConfigStore.to.isFirstOpen == false) {
      return null;
    } else if (UserStore.to.isLogin == true) {
      return const RouteSettings(name: AppRoutes.message);
    } else {
      return const RouteSettings(name: AppRoutes.sigin);
    }
  }
}
