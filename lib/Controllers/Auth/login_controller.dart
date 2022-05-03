import 'package:app_in/Controllers/base_controller.dart';
import 'package:get/state_manager.dart';

class LoginController extends BaseController {
  RxBool isMobileLogin = false.obs;

  void changeMobileLogin() {
    isMobileLogin.value = !isMobileLogin.value;
  }
}
