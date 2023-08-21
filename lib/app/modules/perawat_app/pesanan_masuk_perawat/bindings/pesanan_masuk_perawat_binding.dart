import 'package:get/get.dart';

import '../controllers/pesanan_masuk_perawat_controller.dart';

class PesananMasukPerawatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PesananMasukPerawatController>(
      () => PesananMasukPerawatController(),
    );
  }
}
