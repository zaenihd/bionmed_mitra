import 'package:get/get.dart';

import '../controllers/pesan_hospital_controller.dart';

class PesanHospitalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PesanHospitalController>(
      () => PesanHospitalController(),
    );
  }
}
