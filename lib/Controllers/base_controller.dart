import 'package:app_in/Helper/Server/server_request.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class BaseController extends GetxController {
  final Server server = Server();
  final Map<String, String> headers = {
    "Accept": "application/json",
    "Content-Type": "application/x-www-form-urlencoded",
    'X-API-KEY': '1b22d84d-c70e-45bc-bdbd-2413a15519bc',
  };
}
