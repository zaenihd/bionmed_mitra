import 'package:get/get.dart';

import '../controllers/pilih_spesialis_controller.dart';

class PilihSpesialisBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PilihSpesialisController>(
      () => PilihSpesialisController(),
    );
  }
}
