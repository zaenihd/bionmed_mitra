import 'package:get/get.dart';

class PendapatanSaldoController extends GetxController{
  RxString kodePinView = ''.obs;
  RxList kodePin = [].obs;
  RxString kodePinViewKonfirmasi = ''.obs;
  RxList kodePinKonfirmasi = [].obs;
  RxBool isHiddenPin = false.obs;
  RxBool isHiddenPinKonfirmasi = false.obs;
}