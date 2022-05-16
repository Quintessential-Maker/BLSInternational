import 'dart:convert';

import 'package:app_in/Controllers/base_controller.dart';
import 'package:app_in/Helper/Server/api_helper.dart';
import 'package:app_in/Helper/loading_helper.dart';
import 'package:app_in/Helper/shared-pref.dart';
import 'package:app_in/Helper/string_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

import '../../Views/Dashboard/home_view.dart';

class LoginController extends BaseController {
  Future loginUser({
    required String email,
    required String password,
  }) async {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Loader.show();
    });

    var map = <String, String>{};

    map['email'] = email;
    map['password'] = password;
    dynamic url= await Api.getData(Const.loginService).then((value) => {
      print("url $value"),
      login(value,map),
    });

  }

  void login(url,map) async{
    dynamic response = await server.digestAuth(
      url: url,
      bodyData: map,
    );
    Loader.hide();
    dynamic dataDecode= json.decode(response.body);
    print("data response ${dataDecode['status'].toString()}");
    if(dataDecode['status'].toString() == "true"){
      SharedPref pref = SharedPref();
      pref.save(Const.UserData, dataDecode, true);
      Get.snackbar('Alert', dataDecode['message'], snackPosition: SnackPosition.BOTTOM);
      Get.to(()=>const HomeView());
    }else{
      Get.snackbar('Alert', dataDecode['message'], snackPosition: SnackPosition.BOTTOM);
    }
  }
  RxBool isMobileLogin = false.obs;

  RxString serviceUrl = "".obs;

  void changeMobileLogin() {
    isMobileLogin.value = !isMobileLogin.value;
  }
}
