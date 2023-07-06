import 'package:get/get.dart';

import '../State Managment/auth_manag.dart';

class AuthBindings implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<AuthControl>(AuthControl());
  }
}
