import 'package:app_in/Controllers/base_controller.dart';
import 'package:app_in/Helper/shared-pref.dart';
import 'package:get/state_manager.dart';
import 'package:get/get.dart';

import '../../Views/Auth/splash_view.dart';

class FileApplicationController extends BaseController {
  RxInt currentIndex = 0.obs;

RxString name = "".obs;
RxString email = "".obs;


  changeSliderIndex(int index) {
    currentIndex.value = index;
  }


  void logoutData(){
    SharedPref obj=SharedPref();
    obj.clear();
    Get.to(()=>SplashView());
  }
}
