import 'package:get/get.dart';

import '../controllers/layanan_home_controller.dart';

class LayananHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LayananHomeController>(
      () => LayananHomeController(),
    );
  }
}
