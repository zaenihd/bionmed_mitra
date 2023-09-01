import 'package:get/get.dart';

import '../controllers/lengkapi_data_hospital_controller.dart';

class LengkapiDataHospitalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LengkapiDataHospitalController>(
      () => LengkapiDataHospitalController(),
    );
  }
}
