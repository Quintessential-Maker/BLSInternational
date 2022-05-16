
import 'dart:convert';

import 'package:app_in/Controllers/base_controller.dart';
import 'package:app_in/Views/Auth/login_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Helper/Server/api_helper.dart';
import '../../Helper/loading_helper.dart';
import '../../Helper/string_helper.dart';

class OptController extends BaseController{


  RxString email="".obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();


  }

  Future getOtp({
    required String otp
  }) async {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Loader.show();
    });
    Map<String,String> userData={
      "otp": otp,
      "email": email.value
    };
    dynamic url= await Api.getData(Const.otpVerifyService).then((value) => {
      print("url $value"),
      register(value,userData),
    });

    Loader.hide();


  }

  void register(url,map) async{
    dynamic response = await server.digestAuth(
      url: url,
      bodyData: map,
    );
    Loader.hide();
    dynamic dataDecode= json.decode(response.body);
    print("data response ${dataDecode['message'].toString()}");
    if(dataDecode['status'].toString() == "true"){
      Get.snackbar('Alert', dataDecode['message'], snackPosition: SnackPosition.BOTTOM);
      Get.to(()=> LoginView());
    }else{
      Get.snackbar('Alert', dataDecode['message'], snackPosition: SnackPosition.BOTTOM);
    }
  }
}