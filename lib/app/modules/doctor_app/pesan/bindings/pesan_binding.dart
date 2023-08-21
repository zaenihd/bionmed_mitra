import 'package:get/get.dart';

import '../controllers/pesan_controller.dart';

class PesanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PesanController>(
      () => PesanController(),
    );
  }
}
