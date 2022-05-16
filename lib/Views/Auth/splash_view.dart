import 'package:app_in/Helper/images_helper.dart';
import 'package:app_in/Helper/navigator_helper.dart';
import 'package:app_in/Helper/sizer_helper.dart';
import 'package:app_in/Helper/string_helper.dart';
import 'package:app_in/Views/Auth/country_view.dart';
import 'package:app_in/Views/Dashboard/home_view.dart';
import 'package:flutter/material.dart';

import '../../Helper/Server/api_helper.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {


  @override
  void initState() {
    getUserData();
    super.initState();
  }

  void getUserData() async{
   dynamic  userData= await Api.getUserData().then((userData) => {
   if(userData=="Null"){
       Future.delayed(const Duration(seconds: 2), () {
    Nav.off(context, const CountryView());
    }),
    }else{
    Future.delayed(const Duration(seconds: 2), () {
    Nav.off(context, const HomeView());
    }),

    }

  });


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Sizer.dHeight(context),
        width: Sizer.dWidth(context),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Img.splash),
            filterQuality: FilterQuality.medium,
            fit: BoxFit.fill,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.white,
                          blurRadius: 80,
                          spreadRadius: 20,
                        ),
                      ],
                    ),
                    child: Image.asset(
                      Img.appLogo,
                      filterQuality: FilterQuality.medium,
                      fit: BoxFit.contain,
                      height: 180,
                      width: 180,
                    ),
                  ),
                  Sizer.vSpace(context, 0.02),
                  const Text(
                    Const.splashText,
                    textScaleFactor: 1.2,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              Column(
                children: [
                  // getStarted(),
                  Sizer.vSpace(context, 0.1),
                  const Text(
                    Const.terms,
                    textScaleFactor: 1.2,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                  Sizer.vSpace(context, 0.02),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getStarted() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: const Color(0xffd12534),
          ),
        ),
        child: const Text(
          Const.getStarted,
          textScaleFactor: 1,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
