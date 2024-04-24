import 'package:echo/common/apis/apis.dart';
import 'package:echo/common/entities/entities.dart';
import 'package:echo/common/routes/names.dart';
import 'package:echo/common/store/store.dart';
import 'package:echo/common/values/values.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseMassagingHandler {
  FirebaseMassagingHandler._();
  static AndroidNotificationChannel channelcall =
      const AndroidNotificationChannel(
    'com.dbestech.echo.call', // id
    'echo_call', // title
    importance: Importance.max,
    enableLights: true,
    playSound: true,
    sound: RawResourceAndroidNotificationSound('alert'),
  );
  static AndroidNotificationChannel channelmessage =
      const AndroidNotificationChannel(
    'com.dbestech.echo.message', // id
    'echo_message', // title
    importance: Importance.defaultImportance,
    enableLights: true,
    playSound: true,
    // sound: RawResourceAndroidNotificationSound('alert'),
  );

  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> config() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    try {
      RemoteMessage newMessage = const RemoteMessage();
      await messaging.requestPermission(
        sound: true,
        badge: true,
        alert: true,
        announcement: false,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
      );

      RemoteMessage? initialMessage =
          await FirebaseMessaging.instance.getInitialMessage();
      if (initialMessage != null) {
        if (kDebugMode) {
          print("initialMessage------");
        }
        if (kDebugMode) {
          print(initialMessage);
        }
      }
      var initializationSettingsAndroid =
          const AndroidInitializationSettings("ic_launcher");
      var darwinInitializationSettings = const DarwinInitializationSettings();
      var initializationSettings = InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: darwinInitializationSettings);
      flutterLocalNotificationsPlugin.initialize(initializationSettings,
          onDidReceiveNotificationResponse: (value) {
        if (kDebugMode) {
          print("----------onDidReceiveNotificationResponse");
        }
      });

      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
              alert: true, badge: true, sound: true);

      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        if (kDebugMode) {
          print("\n notification on onMessage function \n");
        }
        if (kDebugMode) {
          print(message);
        }
        _receiveNotification(message);
      });
    } on Exception catch (e) {
      if (kDebugMode) {
        print("$e");
      }
    }
  }

  static Future<void> _receiveNotification(RemoteMessage message) async {
    if (message.data["call_type"] != null) {
      //  ////1. voice 2. video 3. text, 4.cancel
      if (message.data["call_type"] == "voice") {
        //  FirebaseMassagingHandler.flutterLocalNotificationsPlugin.cancelAll();
        var data = message.data;
        var totoken = data["token"];
        var toname = data["name"];
        var toavatar = data["avatar"];
        var docid = data["docid"] ?? "";
        // var callrole= data["calltype"];
        if (totoken != null && toname != null && toavatar != null) {
          Get.snackbar(
              icon: Container(
                width: 40.w,
                height: 40.w,
                padding: EdgeInsets.all(0.w),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill, image: NetworkImage(toavatar)),
                  borderRadius: BorderRadius.all(Radius.circular(20.w)),
                ),
              ),
              "$toname",
              "Voice call",
              duration: const Duration(seconds: 30),
              isDismissible: false,
              mainButton: TextButton(
                  onPressed: () {},
                  child: SizedBox(
                      width: 90.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (Get.isSnackbarOpen) {
                                Get.closeAllSnackbars();
                              }
                              FirebaseMassagingHandler.sendNotifications(
                                  "cancel", totoken, toavatar, toname, docid);
                            },
                            child: Container(
                              width: 40.w,
                              height: 40.w,
                              padding: EdgeInsets.all(10.w),
                              decoration: BoxDecoration(
                                color: AppColors.primaryElementBg,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.w)),
                              ),
                              child: Image.asset("assets/icons/a_phone.png"),
                            ),
                          ),
                          GestureDetector(
                              onTap: () {
                                if (Get.isSnackbarOpen) {
                                  Get.closeAllSnackbars();
                                }
                                Get.toNamed(AppRoutes.voiceCall, parameters: {
                                  "totoken": totoken,
                                  "toname": toname,
                                  "toavatar": toavatar,
                                  "docid": docid,
                                  "callrole": "audience"
                                });
                              },
                              child: Container(
                                width: 40.w,
                                height: 40.w,
                                padding: EdgeInsets.all(10.w),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryElementStatus,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.w)),
                                ),
                                child:
                                    Image.asset("assets/icons/a_telephone.png"),
                              ))
                        ],
                      ))));
        }
      } else if (message.data["call_type"] == "video") {
        //    FirebaseMassagingHandler.flutterLocalNotificationsPlugin.cancelAll();
        //  ////1. voice 2. video 3. text, 4.cancel
        var data = message.data;
        var totoken = data["token"];
        var toname = data["name"];
        var toavatar = data["avatar"];
        var docid = data["docid"] ?? "";
        // var callrole= data["calltype"];
        if (totoken != null && toname != null && toavatar != null) {
          ConfigStore.to.isCallVocie = true;
          Get.snackbar(
              icon: Container(
                width: 40.w,
                height: 40.w,
                padding: EdgeInsets.all(0.w),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill, image: NetworkImage(toavatar)),
                  borderRadius: BorderRadius.all(Radius.circular(20.w)),
                ),
              ),
              "$toname",
              "Video call",
              duration: const Duration(seconds: 30),
              isDismissible: false,
              mainButton: TextButton(
                  onPressed: () {},
                  child: SizedBox(
                      width: 90.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (Get.isSnackbarOpen) {
                                Get.closeAllSnackbars();
                              }
                              FirebaseMassagingHandler.sendNotifications(
                                  "cancel", totoken, toavatar, toname, docid);
                            },
                            child: Container(
                              width: 40.w,
                              height: 40.w,
                              padding: EdgeInsets.all(10.w),
                              decoration: BoxDecoration(
                                color: AppColors.primaryElementBg,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.w)),
                              ),
                              child: Image.asset("assets/icons/a_phone.png"),
                            ),
                          ),
                          GestureDetector(
                              onTap: () {
                                if (Get.isSnackbarOpen) {
                                  Get.closeAllSnackbars();
                                }
                                Get.toNamed(AppRoutes.videoCall, parameters: {
                                  "totoken": totoken,
                                  "toname": toname,
                                  "toavatar": toavatar,
                                  "docid": docid,
                                  "callrole": "audience"
                                });
                              },
                              child: Container(
                                width: 40.w,
                                height: 40.w,
                                padding: EdgeInsets.all(10.w),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryElementStatus,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.w)),
                                ),
                                child:
                                    Image.asset("assets/icons/a_telephone.png"),
                              ))
                        ],
                      ))));
        }
      } else if (message.data["calltype"] == "cancel") {
        FirebaseMassagingHandler.flutterLocalNotificationsPlugin.cancelAll();

        if (Get.isSnackbarOpen) {
          Get.closeAllSnackbars();
        }

        if (Get.currentRoute.contains(AppRoutes.voiceCall) ||
            Get.currentRoute.contains(AppRoutes.videoCall)) {
          Get.back();
        }

        var prefs = await SharedPreferences.getInstance();
        await prefs.setString("CallVocieOrVideo", "");
      }
    }
  }

  static Future<void> sendNotifications(String calltype, String totoken,
      String toavatar, String toname, String docid) async {
    CallRequestEntity callRequestEntity = CallRequestEntity();
    callRequestEntity.calltype = calltype;
    callRequestEntity.totoken = totoken;
    callRequestEntity.toavatar = toavatar;
    callRequestEntity.docid = docid;
    callRequestEntity.toname = toname;
    var res = await ChatAPI.callnotifications(params: callRequestEntity);
    if (kDebugMode) {
      print("sendNotifications");
    }
    if (kDebugMode) {
      print(res);
    }
    if (res.code == 0) {
      if (kDebugMode) {
        print("sendNotifications success");
      }
    } else {
      // Get.snackbar("Tips", "Notification error!");
      // Get.offAllNamed(AppRoutes.Message);
    }
  }

  static Future<void> showNotification({RemoteMessage? message}) async {
    RemoteNotification? notification = message!.notification;
    AndroidNotification? androidNotification = message.notification!.android;
    AppleNotification? appleNotification = message.notification!.apple;

    if (notification != null &&
        (androidNotification != null || appleNotification != null)) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channelmessage.id,
            channelmessage.name,
            icon: "@mipmap/ic_launcher",
            playSound: true,
            enableVibration: true,
            priority: Priority.defaultPriority,
            // channelShowBadge: true,
            importance: Importance.defaultImportance,
            // sound: RawResourceAndroidNotificationSound('alert'),
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        payload: message.data.toString(),
      );
    }
    // PlascoRequests().initReport();
  }
/*
  @pragma('vm:entry-point')
  static Future<void> firebaseMessagingBackground(RemoteMessage message) async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
    print("message data: ${message.data}");
    print("message data: ${message}");
    print("message data: ${message.notification}");

    if(message!=null){
      if(message.data!=null && message.data["call_type"]!=null) {

        if(message.data["call_type"]=="cancel"){
            FirebaseMassagingHandler.flutterLocalNotificationsPlugin.cancelAll();
          //  await setCallVocieOrVideo(false);
            var _prefs = await SharedPreferences.getInstance();
            await _prefs.setString("CallVocieOrVideo", "");
        }
        if(message.data["call_type"]=="voice" || message.data["call_type"]=="video"){

          var data = {
            "to_token":message.data["token"],
            "to_name":message.data["name"],
            "to_avatar":message.data["avatar"],
            "doc_id":message.data["doc_id"]??"",
            "call_type":message.data["call_type"],
            "expire_time":DateTime.now().toString(),
          };
          print(data);
          var _prefs = await SharedPreferences.getInstance();
          await _prefs.setString("CallVocieOrVideo", jsonEncode(data));
        }


      }



    }

  }*/
}
