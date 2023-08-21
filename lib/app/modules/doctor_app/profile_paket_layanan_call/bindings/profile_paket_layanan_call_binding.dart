import 'package:get/get.dart';

import '../controllers/profile_paket_layanan_call_controller.dart';

class ProfilePaketLayananCallBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfilePaketLayananCallController>(
      () => ProfilePaketLayananCallController(),
    );
  }
}
