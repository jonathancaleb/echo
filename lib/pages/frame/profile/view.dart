import 'package:echo/common/values/colors.dart';
import 'package:echo/pages/frame/profile/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  AppBar buildAppBar() {
    return AppBar(
      title: Text(
        "Profile",
        style: TextStyle(
            color: AppColors.primaryText,
            fontSize: 16.sp,
            fontWeight: FontWeight.normal),
      ),
    );
  }

  Widget buildProfilePhoto() {
    return Stack(
      children: [
        Container(
          width: 120.w,
          height: 120.w,
          decoration: BoxDecoration(
              color: AppColors.primarySecondaryBackground,
              borderRadius: BorderRadius.all(Radius.circular(60.w)),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 1))
              ]),
          child: Image(
              width: 120.w,
              height: 120.h,
              fit: BoxFit.cover,
              image: AssetImage("assets/images/account_header.png")),
        ),
        //2
        Positioned(
            bottom: 0.w,
            right: 0.w,
            height: 35.w,
            child: GestureDetector(
              child: Container(
                height: 35.w,
                width: 35.w,
                padding: EdgeInsets.all(7.w),
                decoration: BoxDecoration(
                    color: AppColors.primaryElement,
                    borderRadius: BorderRadius.all(Radius.circular(40.w))),
                child: Image.asset("assets/icons/edit.png"),
              ),
            ))
      ],
    );
  }

  Widget buildCompleteBtn() {
    return GestureDetector(
      child: Container(
        width: 295.w,
        height: 44.h,
        margin: EdgeInsets.only(top: 60.h, bottom: 30.h),
        decoration: BoxDecoration(
            color: AppColors.primaryElement,
            borderRadius: BorderRadius.all(Radius.circular(5.w)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 1))
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Complete",
              style: TextStyle(
                  color: AppColors.primaryElementText,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLogOutBtn() {
    return GestureDetector(
      child: Container(
        width: 295.w,
        height: 44.h,
        margin: EdgeInsets.only(top: 0.h, bottom: 30.h),
        decoration: BoxDecoration(
            color: AppColors.primarySecondaryElementText,
            borderRadius: BorderRadius.all(Radius.circular(5.w)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 1))
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Logout",
              style: TextStyle(
                  color: AppColors.primaryElementText,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),

      //logout
      onTap: () {
        Get.defaultDialog(
            title: "Are you sure to log out?",
            content: Container(),
            onConfirm: () {
              controller.goLogout();
            },
            onCancel: () {},
            textConfirm: "Confirm",
            textCancel: "Cancel",
            confirmTextColor: Colors.white);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(),
        body: SafeArea(
            child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                child: Column(
                  children: [
                    buildProfilePhoto(),
                    buildCompleteBtn(),
                    buildLogOutBtn()
                  ],
                ),
              ),
            )
          ],
        )));
  }
}
