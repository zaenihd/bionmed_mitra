
import 'package:get/get.dart';

class DetailController extends GetxController {
  bool stop = false;


  
  RxBool selected = false.obs;
  RxString imageRecipe = "".obs;

  selec(){
    selected.value == true;
  }

  RxString paymentName = "".obs;
  RxString bankName = "".obs;

  
}
