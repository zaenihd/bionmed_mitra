import 'package:get/get.dart';

import '../controllers/register_hospital_controller.dart';

class RegisterHospitalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterHospitalController>(
      () => RegisterHospitalController(),
    );
  }
}
