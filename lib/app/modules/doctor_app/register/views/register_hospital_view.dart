// import 'package:bionmed/app/routes/app_pages.dart';
// import 'package:bionmed/app/widget/appbar/appbar_back.dart';
// import 'package:bionmed/app/widget/header/header_layanan.dart';
// import 'package:bionmed/theme.dart';
// import 'package:flutter/material.dart';

// import 'package:get/get.dart';

// import '../../../../widget/textform/input_primary1.dart';
// import '../controllers/register_controller.dart';

// // ignore: must_be_immutable
// class RegisterHospitalView extends GetView<RegisterController> {
//    RegisterHospitalView({Key? key}) : super(key: key);
//    final TextEditingController controllerNameHospital = TextEditingController();
//   final TextEditingController controllerKota = TextEditingController();
//   final TextEditingController controllerAlamat = TextEditingController();

//   List jenisKelamin = ['Laki - laki', "Perempuan"];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // ignore: avoid_unnecessary_containers
//       backgroundColor: backgroundColorC,
//       appBar: appbarBack(),
//       // body: LoadingOverlay(
//       //   isLoading: Get.find<RegisterController>().isloading.value,
//       //   progressIndicator: loadingIndicator(),
//       //   color: Colors.transparent,
//       //   opacity: 0.2,
//       //   child: 
//         body :ListView(
//           padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
//           // ignore: prefer_const_literals_to_create_immutables
//           children: [
//             HeaderWidget(imageUrl: 'assets/icon/icon_biodata.png', title: "Biodata", subtitle: "Isi data ini dengan lengkap untuk membuat \nakun anda"),
//             const SizedBox(height: 32),
//             GestureDetector(
//                 onTap: () {
//                   // pickerFilesImage(context);
//                 },
//                 // child: files == null
//                 //     ? Container(
//                 //         height: 100,
//                 //         width: 100,
//                 //         decoration: const BoxDecoration(
//                 //             shape: BoxShape.circle, color: AppColor.weak2Color),
//                 //         child: Column(
//                 //           crossAxisAlignment: CrossAxisAlignment.center,
//                 //           mainAxisAlignment: MainAxisAlignment.center,
//                 //           // ignore: prefer_const_literals_to_create_immutables
//                 //           children: [
//                 //             Icon(
//                 //               Icons.add_a_photo_outlined,
//                 //               size: 42,
//                 //               color: AppColor.bodyColor[500],
//                 //             ),
//                 //             const SizedBox(height: 6),
//                 //             Text(
//                 //               "Tambahkan foto",
//                 //               style: TextStyle(
//                 //                 color: AppColor.bodyColor[500],
//                 //                 fontSize: 11,
//                 //               ),
//                 //             ),
//                 //           ],
//                 //         ),
//                 //       )
//                     child: Column(
//                       children: [
//                         Container(
//                             height: 120,
//                             width: 120,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(100),
//                               color: textFieldC),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                               Image.asset('assets/icon/icon_camera.png'),
//                               const SizedBox(height: 6,),
//                               Text('Tambahkan foto', style: blackTextStyle.copyWith(color: subtitleColor, fontSize: 11),)
//                             ],),
//                             // child: Column(
//                             //   children: [
//                             //     Stack(
//                             //       children: [
//                             //         ClipOval(
                                      
//                             //           child: SizedBox.fromSize(
//                             //             size: Size.fromRadius(48), // Image radius
//                             //             // child: Image.file(files, fit: BoxFit.cover),
//                             //           ),
//                             //         ),
//                             //         Positioned(
//                             //           left: 55,
//                             //           bottom: 5,
//                             //           child: Icon(
//                             //             Icons.add_a_photo,
//                             //             size: 35,
//                             //             // color: AppColor.bodyColor.shade500,
//                             //           ),
//                             //         ),
//                             //       ],
//                             //     ),
//                             //   ],
//                             // ),
//                           ),
//                       ],
//                     )),
//             const SizedBox(height: 6),
//             const Text(
//               "Foto Profile",
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 // color: AppColor.bodyColor,
//               ),
//             ),
//             const SizedBox(height: 24),
//             const SizedBox(
//               width: double.infinity,
//               child: Text(
//                 'Nama Rumah Sakit',
//                 textAlign: TextAlign.left,
//               ),
//             ),
//             const SizedBox(height: 6,),
//             InputPrimary(onChange: (p0) {
//             }, controller: controllerNameHospital, onTap: (){}, hintText: 'Masukkan nama rumah sakit',),
//             const SizedBox(height: 16),
//             const SizedBox(
//               width: double.infinity,
//               child: Text(
//                 'Kota / Provinsi',
//                 textAlign: TextAlign.left,
//               ),
//             ),
//                         InputPrimary(onChange: (p0) {}, controller: controllerKota, onTap: (){}, hintText: 'Isi kota anda',),

//             const SizedBox(height: 16),
//             const SizedBox(
//               width: double.infinity,
//               child: Text(
//                 'Alamat',
//                 textAlign: TextAlign.left,
//               ),
//             ),
//             InputPrimary(onChange: (p0) {}, controller: controllerAlamat, onTap: (){}, hintText: 'Isi alamat anda',),
//             const SizedBox(height: 50),
//             Container(
//               margin: const EdgeInsets.only(bottom: 24),
//               height: 45,
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: (){
//                   Get.toNamed(Routes.LAYANAN);
//                 },
//                 style:
//                     ElevatedButton.styleFrom(
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
//                       backgroundColor: buttonColor
//                     ),
//                 child:  Text(
//                   "Lanjutkan",
//                   style: whiteTextStyle.copyWith(fontWeight: bold),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       );
    
//   }
// }
