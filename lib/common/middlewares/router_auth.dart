import 'package:flutter/material.dart';
import 'package:echo/common/routes/routes.dart';
import 'package:echo/common/store/store.dart';

import 'package:get/get.dart';

/// check if user has logged in or not
class RouteAuthMiddleware extends GetMiddleware {
  // priority level, the smaller the better
  @override
  int? priority = 0;

  RouteAuthMiddleware({required this.priority});

  @override
  RouteSettings? redirect(String? route) {
    if (UserStore.to.isLogin ||
        route == AppRoutes.sigin ||
        route == AppRoutes.initial ||
        route == AppRoutes.message) {
      return null;
    } else {
      Future.delayed(const Duration(seconds: 2),
          () => Get.snackbar("Tips", "Login expired, please login again!"));
      return const RouteSettings(name: AppRoutes.sigin);
    }
  }
}
