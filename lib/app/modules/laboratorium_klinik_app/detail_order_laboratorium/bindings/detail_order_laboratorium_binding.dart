import 'package:get/get.dart';

import '../controllers/detail_order_laboratorium_controller.dart';

class DetailOrderLaboratoriumBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailOrderLaboratoriumController>(
      () => DetailOrderLaboratoriumController(),
    );
  }
}
