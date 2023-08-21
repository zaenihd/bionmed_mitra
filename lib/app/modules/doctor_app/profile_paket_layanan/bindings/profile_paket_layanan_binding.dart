import 'package:get/get.dart';

import '../controllers/profile_paket_layanan_controller.dart';

class ProfilePaketLayananBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfilePaketLayananController>(
      () => ProfilePaketLayananController(),
    );
  }
}
