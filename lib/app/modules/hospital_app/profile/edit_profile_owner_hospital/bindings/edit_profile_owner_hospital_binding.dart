import 'package:get/get.dart';

import '../controllers/edit_profile_owner_hospital_controller.dart';

class EditProfileOwnerHospitalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditProfileOwnerHospitalController>(
      () => EditProfileOwnerHospitalController(),
    );
  }
}
