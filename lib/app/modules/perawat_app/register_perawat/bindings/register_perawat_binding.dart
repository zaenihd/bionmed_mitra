import 'package:get/get.dart';

import '../controllers/register_perawat_controller.dart';

class RegisterPerawatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterPerawatController>(
      () => RegisterPerawatController(),
    );
  }
}
