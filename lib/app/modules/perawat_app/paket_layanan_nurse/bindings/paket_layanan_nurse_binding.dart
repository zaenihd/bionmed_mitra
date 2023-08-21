import 'package:get/get.dart';

import '../controllers/paket_layanan_nurse_controller.dart';

class PaketLayananNurseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaketLayananNurseController>(
      () => PaketLayananNurseController(),
    );
  }
}
