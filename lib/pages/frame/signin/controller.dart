import 'package:echo/common/entities/entities.dart';
import 'package:echo/pages/frame/signin/state.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInController extends GetxController {
  SignInController();
  final state = SignInState();

  //google
  final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['openid']);

  Future<void> handleSigin(String type) async {
    //1.google

    //2.facebook

    //3.apple

    //4.phone number
    try {
      if (type == "phone number") {
        if (kDebugMode) {
          print("..you are logging in wth phone number");
        }
      } else if (type == "google") {
        var user = await googleSignIn.signIn();
        if (user != null) {
          String? displayName = user.displayName;
          String email = user.email;
          String id = user.id;
          String photoUrl = user.photoUrl ?? "assets/icons/google.png";
          LoginRequestEntity loginPanelListRequestEntity = LoginRequestEntity();
          loginPanelListRequestEntity.avatar = photoUrl;
          loginPanelListRequestEntity.name = displayName;
          loginPanelListRequestEntity.email = email;
          loginPanelListRequestEntity.openid = id;
          loginPanelListRequestEntity.type = 2;
        }
      } else {
        if (kDebugMode) {
          print("..login type not sure");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('..error with login $e');
      }
    }
  }
}
