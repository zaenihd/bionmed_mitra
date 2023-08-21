import 'package:get/get.dart';

import '../controllers/list_service_nurse_controller.dart';

class ListServiceNurseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListServiceNurseController>(
      () => ListServiceNurseController(),
    );
  }
}
