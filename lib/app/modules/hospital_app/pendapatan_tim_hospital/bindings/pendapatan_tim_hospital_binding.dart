import 'package:get/get.dart';

import '../controllers/pendapatan_tim_hospital_controller.dart';

class PendapatanTimHospitalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PendapatanTimHospitalController>(
      () => PendapatanTimHospitalController(),
    );
  }
}
