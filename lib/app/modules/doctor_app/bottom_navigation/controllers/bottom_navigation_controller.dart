
import 'package:bionmed/app/modules/doctor_app/home/controllers/home_controller.dart';
import 'package:bionmed/app/modules/doctor_app/layanan_home/controllers/layanan_home_controller.dart';
import 'package:bionmed/app/modules/doctor_app/login/controllers/login_controller.dart';
import 'package:bionmed/app/modules/doctor_app/pesan/controllers/pesan_controller.dart';
import 'package:get/get.dart';

class BottomNavigationController extends GetxController {
  final layananHomeC = Get.put(LayananHomeController());
  final loginC = Get.put(LoginController());
  final homeC = Get.put(HomeController());
  var onChange = 0;
  RxBool realtimeApi = true.obs;

  void changeTabIndex(int index) async{
    onChange = index;
    update();
    if (index == 1 || index == 0) {
      if(loginC.role.value == 'nurse'){
      layananHomeC.listOrderNurse();
      }else{

     await Get.find<PesanController>().notification();
      //  Get.find<PesanController>().dataPesan[index]['orderId'];
      // homeC.timePeriodic.value = false;
      // realtimeApi.value = false;
      // if(realtimeApi.isFalse){
      // homeC.realtimeApi();
      // }

      
      layananHomeC.addOrder();
      layananHomeC.orderListToday();
      }
      // loginC.loginV2(phoneNumber: loginC.phoneNumberUser.value);

      // layananHomeC.updateStatus();
    }
  }
}
