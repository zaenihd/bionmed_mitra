import 'package:get/get.dart';

import '../controllers/edit_profile_hospital_controller.dart';

class EditProfileHospitalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditProfileHospitalController>(
      () => EditProfileHospitalController(),
    );
  }
}
