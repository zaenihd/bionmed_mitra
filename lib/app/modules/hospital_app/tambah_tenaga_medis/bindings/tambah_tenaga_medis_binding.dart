import 'package:get/get.dart';

import '../controllers/tambah_tenaga_medis_controller.dart';

class TambahTenagaMedisBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TambahTenagaMedisController>(
      () => TambahTenagaMedisController(),
    );
  }
}
