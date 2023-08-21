// ignore_for_file: deprecated_member_use

import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountController extends GetxController {
int? selected;
RxBool selec = false.obs;

Future<dynamic> kebijakanPrivasi(
  ) async {
    if (await canLaunch('https://drive.google.com/file/d/1iuNaEzVVSJHQeU_T8MmXXDTXncaMb4Qt/view?usp=share_link')) {
      await launch('https://drive.google.com/file/d/1iuNaEzVVSJHQeU_T8MmXXDTXncaMb4Qt/view?usp=share_link');
    } else {
      throw 'Could not launch''https://drive.google.com/file/d/1iuNaEzVVSJHQeU_T8MmXXDTXncaMb4Qt/view?usp=share_link';
    }

}
Future<dynamic> ketentuanPengguna(
  ) async {
    if (await canLaunch('https://drive.google.com/file/d/1RQfsqPC_LnSZdlVESRORcq1l2SCbujN0/view?usp=share_link')) {
      await launch('https://drive.google.com/file/d/1RQfsqPC_LnSZdlVESRORcq1l2SCbujN0/view?usp=share_link');
    } else {
      throw 'Could not launch''https://drive.google.com/file/d/1RQfsqPC_LnSZdlVESRORcq1l2SCbujN0/view?usp=share_link';
    }

}
}
