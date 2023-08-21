import 'package:get/get.dart';

import '../controllers/home_hospital_controller.dart';

class HomeHospitalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeHospitalController>(
      () => HomeHospitalController(),
    );
  }
}
