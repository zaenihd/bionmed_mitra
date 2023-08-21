import 'package:get/get.dart';

import '../controllers/paket_hospital_dan_ambulance_controller.dart';

class PaketHospitalDanAmbulanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaketHospitalDanAmbulanceController>(
      () => PaketHospitalDanAmbulanceController(),
    );
  }
}
