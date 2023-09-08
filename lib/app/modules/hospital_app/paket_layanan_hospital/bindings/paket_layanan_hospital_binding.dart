import 'package:get/get.dart';

import '../controllers/paket_layanan_hospital_controller.dart';

class PaketLayananHospitalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaketLayananHospitalController>(
      () => PaketLayananHospitalController(),
    );
  }
}
