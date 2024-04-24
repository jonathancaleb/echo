import 'package:echo/common/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  //logo
  Widget buildLogo() {
    return Container(
      margin: EdgeInsets.only(top: 100.h, bottom: 80.h),
      child: Text(
        "E c h o.",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: AppColors.primaryText,
            fontWeight: FontWeight.bold,
            fontSize: 34.sp),
      ),
    );
  }

  //google
  Widget buildThirdPartyLogin(String loginType, String logo) {
    return GestureDetector(
      onTap: () {
        print("third party ${loginType}");
      },
      child: Container(
        padding: EdgeInsets.all(10.h),
        margin: EdgeInsets.only(bottom: 15.h),
        width: 295.w,
        height: 44.h,
        decoration: BoxDecoration(
            color: AppColors.primaryBackground,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 1))
            ]),
        child: Row(
          mainAxisAlignment:
              logo == '' ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            logo == ''
                ? Container()
                : Container(
                    padding: EdgeInsets.only(left: 40.w, right: 30.w),
                    child: Image.asset("assets/icons/$logo.png"),
                  ),
            Container(
              child: Text(
                "Sign in with $loginType",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColors.primaryText,
                    fontWeight: FontWeight.normal,
                    fontSize: 14.sp),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildOrWidget() {
    return Container(
      margin: EdgeInsets.only(top: 20.h, bottom: 35.h),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              indent: 50,
              height: 2.h,
              color: AppColors.primarySecondaryElementText,
            ),
          ),
          const Text("  or  "),
          Expanded(
            child: Divider(
              endIndent: 50,
              height: 2.h,
              color: AppColors.primarySecondaryElementText,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSiginUpMethod() {
    return Column(
      children: [
        Text(
          "Already have an account",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: AppColors.primaryText,
              fontWeight: FontWeight.normal,
              fontSize: 12.sp),
        ),
        GestureDetector(
          onTap: () {
            print("sigin up");
          },
          child: Text(
            "Sign up here",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppColors.primaryElement,
                fontWeight: FontWeight.normal,
                fontSize: 12.sp),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primarySecondaryBackground,
      body: Center(
          child: Column(
        children: [
          //logo
          buildLogo(),
          //google
          buildThirdPartyLogin("Google", "google"),
          //facebook
          buildThirdPartyLogin("Facebook", "facebook"),
          //apple
          buildThirdPartyLogin("Apple", "apple"),

          //divider
          buildOrWidget(),

          //other options
          buildThirdPartyLogin("phone number", ""),
          SizedBox(height: 35.h),

          //account
          buildSiginUpMethod()
        ],
      )),
    );
  }
}
