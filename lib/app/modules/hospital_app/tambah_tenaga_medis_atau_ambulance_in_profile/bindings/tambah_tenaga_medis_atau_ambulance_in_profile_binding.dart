import 'package:get/get.dart';

import '../controllers/tambah_tenaga_medis_atau_ambulance_in_profile_controller.dart';

class TambahTenagaMedisAtauAmbulanceInProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TambahTenagaMedisAtauAmbulanceInProfileController>(
      () => TambahTenagaMedisAtauAmbulanceInProfileController(),
    );
  }
}
