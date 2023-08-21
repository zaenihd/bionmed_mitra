import 'package:get/get.dart';

import '../controllers/connection_controller.dart';

class ConnectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConnectionController>(
      () => ConnectionController(),
    );
  }
}
