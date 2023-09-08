import 'package:get/get.dart';

import '../modules/doctor_app/account/bindings/account_binding.dart';
import '../modules/doctor_app/account/views/account_view.dart';
import '../modules/doctor_app/bottom_navigation/bindings/bottom_navigation_binding.dart';
import '../modules/doctor_app/bottom_navigation/views/bottom_navigation_view.dart';
import '../modules/doctor_app/call/bindings/call_binding.dart';
import '../modules/doctor_app/call/views/call_view.dart';
import '../modules/doctor_app/chat/bindings/chat_binding.dart';
import '../modules/doctor_app/chat/views/chat_view.dart';
import '../modules/doctor_app/home/bindings/home_binding.dart';
import '../modules/doctor_app/home/views/home_view.dart';
import '../modules/doctor_app/introduction_screen/bindings/introduction_screen_binding.dart';
import '../modules/doctor_app/introduction_screen/views/introduction_screen_view.dart';
import '../modules/doctor_app/jadwal_saya/bindings/jadwal_saya_binding.dart';
import '../modules/doctor_app/jadwal_saya/views/jadwal_saya_view.dart';
import '../modules/doctor_app/layanan/bindings/layanan_binding.dart';
import '../modules/doctor_app/layanan/views/layanan_view.dart';
import '../modules/doctor_app/layanan_home/bindings/layanan_home_binding.dart';
import '../modules/doctor_app/layanan_home/views/layanan_home_view.dart';
import '../modules/doctor_app/lengkapi_profil/bindings/lengkapi_profil_binding.dart';
import '../modules/doctor_app/lengkapi_profil/views/lengkapi_profil_view.dart';
import '../modules/doctor_app/login/bindings/login_binding.dart';
import '../modules/doctor_app/login/views/login_view.dart';
import '../modules/doctor_app/pesan/bindings/pesan_binding.dart';
import '../modules/doctor_app/pesan/views/pesan_view.dart';
import '../modules/doctor_app/pilih_spesialis/bindings/pilih_spesialis_binding.dart';
import '../modules/doctor_app/pilih_spesialis/views/pilih_spesialis_view.dart';
import '../modules/doctor_app/profile/bindings/profile_binding.dart';
import '../modules/doctor_app/profile/views/profile_view.dart';
import '../modules/doctor_app/profile_paket_layanan/bindings/profile_paket_layanan_binding.dart';
import '../modules/doctor_app/profile_paket_layanan/views/profile_paket_layanan_view.dart';
import '../modules/doctor_app/profile_paket_layanan_call/bindings/profile_paket_layanan_call_binding.dart';
import '../modules/doctor_app/profile_paket_layanan_call/views/profile_paket_layanan_call_view.dart';
import '../modules/doctor_app/profile_paket_layanan_vcall/bindings/profile_paket_layanan_vcall_binding.dart';
import '../modules/doctor_app/profile_paket_layanan_vcall/views/profile_paket_layanan_vcall_view.dart';
import '../modules/doctor_app/register/bindings/register_binding.dart';
import '../modules/doctor_app/register/views/register_view.dart';
import '../modules/doctor_app/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/doctor_app/splash_screen/views/splash_screen_view.dart';
import '../modules/hospital_app/detail_order_hospital/bindings/detail_order_hospital_binding.dart';
import '../modules/hospital_app/detail_order_hospital/views/detail_order_hospital_view.dart';
import '../modules/hospital_app/lengkapi_data_hospital/bindings/lengkapi_data_hospital_binding.dart';
import '../modules/hospital_app/lengkapi_data_hospital/views/lengkapi_data_hospital_view.dart';
import '../modules/hospital_app/paket_hospital_dan_ambulance/bindings/paket_hospital_dan_ambulance_binding.dart';
import '../modules/hospital_app/paket_hospital_dan_ambulance/views/paket_hospital_dan_ambulance_view.dart';
import '../modules/hospital_app/profile/edit_profile_hospital/bindings/edit_profile_hospital_binding.dart';
import '../modules/hospital_app/profile/edit_profile_hospital/views/edit_profile_hospital_view.dart';
import '../modules/hospital_app/profile/edit_profile_owner_hospital/bindings/edit_profile_owner_hospital_binding.dart';
import '../modules/hospital_app/profile/edit_profile_owner_hospital/views/edit_profile_owner_hospital_view.dart';
import '../modules/hospital_app/register_hospital/bindings/register_hospital_binding.dart';
import '../modules/hospital_app/register_hospital/views/register_hospital_view.dart';
import '../modules/hospital_app/tambah_tenaga_medis/bindings/tambah_tenaga_medis_binding.dart';
import '../modules/hospital_app/tambah_tenaga_medis/views/tambah_tenaga_medis_view.dart';
import '../modules/hospital_app/tambah_tenaga_medis_atau_ambulance_in_profile/bindings/tambah_tenaga_medis_atau_ambulance_in_profile_binding.dart';
import '../modules/hospital_app/tambah_tenaga_medis_atau_ambulance_in_profile/views/tambah_tenaga_medis_atau_ambulance_in_profile_view.dart';
import '../modules/laboratorium_klinik_app/detail_order_laboratorium/bindings/detail_order_laboratorium_binding.dart';
import '../modules/laboratorium_klinik_app/detail_order_laboratorium/views/detail_order_laboratorium_view.dart';
import '../modules/hospital_app/paket_layanan_hospital/bindings/paket_layanan_hospital_binding.dart';
import '../modules/hospital_app/paket_layanan_hospital/views/paket_layanan_hospital_view.dart';
import '../modules/perawat_app/list_service_nurse/bindings/list_service_nurse_binding.dart';
import '../modules/perawat_app/list_service_nurse/views/list_service_nurse_view.dart';
import '../modules/perawat_app/paket_layanan_nurse/bindings/paket_layanan_nurse_binding.dart';
import '../modules/perawat_app/paket_layanan_nurse/views/paket_layanan_nurse_view.dart';
import '../modules/perawat_app/pesanan_masuk_perawat/bindings/pesanan_masuk_perawat_binding.dart';
import '../modules/perawat_app/pesanan_masuk_perawat/views/pesanan_masuk_perawat_view.dart';
import '../modules/perawat_app/register_perawat/bindings/register_perawat_binding.dart';
import '../modules/perawat_app/register_perawat/views/register_perawat_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // ignore: constant_identifier_names
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.ACCOUNT,
      page: () => const AccountView(),
      binding: AccountBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.PILIH_SPESIALIS,
      page: () => const PilihSpesialisView(),
      binding: PilihSpesialisBinding(),
    ),
    GetPage(
      name: _Paths.LAYANAN,
      page: () => LayananView(),
      binding: LayananBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.BOTTOM_NAVIGATION,
      page: () => BottonNavigationView(),
      binding: BottomNavigationBinding(),
    ),
    GetPage(
      name: _Paths.LAYANAN_HOME,
      // ignore: prefer_const_constructors
      page: () => LayananHomeView(
        test: true,
      ),
      binding: LayananHomeBinding(),
    ),
    // GetPage(
    //   name: _Paths.DETAIL,
    //   page: () => DetailView(
    //     imageUrl: Get.find<LayananHomeController>()
    //         .dataListOrder[0]['order']['customer']['image']
    //         .toString(),
    //     name: Get.find<LayananHomeController>()
    //         .dataListOrder[0]['order']['customer']['name']
    //         .toString(),
    //     totalPrice: Get.find<LayananHomeController>()
    //         .dataListOrder[0]['order']['totalPrice']
    //         .toString(),
    //     servicePrice: Get.find<LayananHomeController>()
    //         .dataListOrder[0]['order']['service_price']['price']
    //         .toString(),
    //     layanan: Get.find<LayananHomeController>()
    //         .dataListOrder[0]['order']['service_price']['name']
    //         .toString(),
    //   ),
    //   binding: DetailBinding(),
    // ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.PESAN,
      page: () => PesanView(),
      binding: PesanBinding(),
    ),
    GetPage(
      name: _Paths.INTRODUCTION_SCREEN,
      page: () => IntroductionScreenView(),
      binding: IntroductionScreenBinding(),
    ),
    GetPage(
      name: _Paths.CALL,
      page: () => const CallView(),
      binding: CallBinding(),
    ),
    GetPage(
      name: _Paths.CHAT,
      page: () => const ChatView(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: _Paths.LENGKAPI_PROFIL,
      // ignore: prefer_const_constructors
      page: () => LengkapiProfilView(),
      binding: LengkapiProfilBinding(),
    ),
    GetPage(
      name: _Paths.JADWAL_SAYA,
      page: () => JadwalSayaView(),
      binding: JadwalSayaBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_PAKET_LAYANAN,
      // ignore: prefer_const_constructors
      page: () => ProfilePaketLayananView(),
      binding: ProfilePaketLayananBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_PAKET_LAYANAN_CALL,
      page: () => const ProfilePaketLayananCallView(),
      binding: ProfilePaketLayananCallBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_PAKET_LAYANAN_VCALL,
      page: () => const ProfilePaketLayananVcallView(),
      binding: ProfilePaketLayananVcallBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER_PERAWAT,
      page: () => const RegisterPerawatView(),
      binding: RegisterPerawatBinding(),
    ),
    GetPage(
      name: _Paths.PESANAN_MASUK_PERAWAT,
      page: () => PesananMasukPerawatView(),
      binding: PesananMasukPerawatBinding(),
    ),
    GetPage(
      name: _Paths.PAKET_LAYANAN_NURSE,
      page: () => PaketLayananNurseView(),
      binding: PaketLayananNurseBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_ORDER_LABORATORIUM,
      page: () => DetailOrderLaboratoriumView(),
      binding: DetailOrderLaboratoriumBinding(),
    ),
    GetPage(
      name: _Paths.LIST_SERVICE_NURSE,
      page: () => const ListServiceNurseView(),
      binding: ListServiceNurseBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER_HOSPITAL,
      page: () => const RegisterHospitalView(),
      binding: RegisterHospitalBinding(),
    ),
    GetPage(
      name: _Paths.TAMBAH_TENAGA_MEDIS,
      page: () => TambahTenagaMedisView(),
      binding: TambahTenagaMedisBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE_HOSPITAL,
      page: () => const EditProfileHospital(),
      binding: EditProfileHospitalBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_ORDER_HOSPITAL,
      page: () => DetailOrderHospitalView(),
      binding: DetailOrderHospitalBinding(),
    ),
    GetPage(
      name: _Paths.TAMBAH_TENAGA_MEDIS_ATAU_AMBULANCE_IN_PROFILE,
      page: () => const TambahTenagaMedisAtauAmbulanceInProfileView(),
      binding: TambahTenagaMedisAtauAmbulanceInProfileBinding(),
    ),
    GetPage(
      name: _Paths.PAKET_HOSPITAL_DAN_AMBULANCE,
      page: () => const PaketHospitalDanAmbulanceView(),
      binding: PaketHospitalDanAmbulanceBinding(),
    ),
    GetPage(
      name: _Paths.LENGKAPI_DATA_HOSPITAL,
      page: () => const LengkapiDataHospitalView(),
      binding: LengkapiDataHospitalBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE_OWNER_HOSPITAL,
      page: () => const EditProfileOwnerHospitalView(),
      binding: EditProfileOwnerHospitalBinding(),
    ),
    GetPage(
      name: _Paths.PAKET_LAYANAN_HOSPITAL,
      page: () =>  PaketLayananHospitalView(),
      binding: PaketLayananHospitalBinding(),
    ),
  ];
}
