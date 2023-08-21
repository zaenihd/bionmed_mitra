import 'package:get/get.dart';

import '../controllers/jadwal_saya_controller.dart';

class JadwalSayaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JadwalSayaController>(
      () => JadwalSayaController(),
    );
  }
}
