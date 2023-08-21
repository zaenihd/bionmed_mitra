import 'package:get/get.dart';

import '../controllers/profile_paket_layanan_vcall_controller.dart';

class ProfilePaketLayananVcallBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfilePaketLayananVcallController>(
      () => ProfilePaketLayananVcallController(),
    );
  }
}
