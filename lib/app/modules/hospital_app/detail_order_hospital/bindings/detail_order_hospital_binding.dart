import 'package:get/get.dart';

import '../controllers/detail_order_hospital_controller.dart';

class DetailOrderHospitalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailOrderHospitalController>(
      () => DetailOrderHospitalController(),
    );
  }
}
