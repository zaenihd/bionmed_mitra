import 'package:bionmed/app/routes/app_pages.dart';
import 'package:bionmed/app/widget/appbar/appbar_back.dart';
import 'package:bionmed/app/widget/header/header_layanan.dart';
import 'package:bionmed/theme.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../constant/colors.dart';
import '../../../../constant/styles.dart';
import '../../../../widget/textform/input_primary1.dart';

// ignore: must_be_immutable
class RegisterPsyhcoterpyView extends StatefulWidget {
   const RegisterPsyhcoterpyView({Key? key}) : super(key: key);

  @override
  State<RegisterPsyhcoterpyView> createState() => _RegisterPsyhcoterpyViewState();
}

class _RegisterPsyhcoterpyViewState extends State<RegisterPsyhcoterpyView> {
     final TextEditingController controllerDate = TextEditingController();

  final TextEditingController controllerName = TextEditingController();

  final TextEditingController controllerPengalaman = TextEditingController();

  final TextEditingController controllerNomerStr = TextEditingController();

  final TextEditingController controllerKota = TextEditingController();

  final TextEditingController controllerAlamat = TextEditingController();
  

  final jenisKelamin = ['Laki - laki', "Perempuan"];

  String selectedValue = '';

  bool isButtonActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: avoid_unnecessary_containers
      backgroundColor: backgroundColorC,
      appBar: appbarBack(),
      // body: LoadingOverlay(
      //   isLoading: Get.find<RegisterController>().isloading.value,
      //   progressIndicator: loadingIndicator(),
      //   color: Colors.transparent,
      //   opacity: 0.2,
      //   child: 
        body :
        ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            HeaderWidget(imageUrl: 'assets/icon/icon_biodata.png', title: "Biodata", subtitle: "Isi data ini dengan lengkap untuk membuat \nakun anda"),
            const SizedBox(height: 32),
            GestureDetector(
                onTap: () {
                  // pickerFilesImage(context);
                },
                // child: files == null
                //     ? Container(
                //         height: 100,
                //         width: 100,
                //         decoration: const BoxDecoration(
                //             shape: BoxShape.circle, color: AppColor.weak2Color),
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.center,
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           // ignore: prefer_const_literals_to_create_immutables
                //           children: [
                //             Icon(
                //               Icons.add_a_photo_outlined,
                //               size: 42,
                //               color: AppColor.bodyColor[500],
                //             ),
                //             const SizedBox(height: 6),
                //             Text(
                //               "Tambahkan foto",
                //               style: TextStyle(
                //                 color: AppColor.bodyColor[500],
                //                 fontSize: 11,
                //               ),
                //             ),
                //           ],
                //         ),
                //       )
                    child: Column(
                      children: [
                        Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: textFieldC),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                              Image.asset('assets/icon/icon_camera.png'),
                              const SizedBox(height: 6,),
                              Text('Tambahkan foto', style: blackTextStyle.copyWith(color: subtitleColor, fontSize: 11),)
                            ],),
                          
                            // child: Column(
                            //   children: [
                            //     Stack(
                            //       children: [
                            //         ClipOval(
                                      
                            //           child: SizedBox.fromSize(
                            //             size: Size.fromRadius(48), // Image radius
                            //             // child: Image.file(files, fit: BoxFit.cover),
                            //           ),
                            //         ),
                            //         Positioned(
                            //           left: 55,
                            //           bottom: 5,
                            //           child: Icon(
                            //             Icons.add_a_photo,
                            //             size: 35,
                            //             // color: AppColor.bodyColor.shade500,
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //   ],
                            // ),
                          ),
                      ],
                    )),
            const SizedBox(height: 6),
            const Text(
              "Foto Profile",
              textAlign: TextAlign.center,
              style: TextStyle(
                // color: AppColor.bodyColor,
              ),
            ),
            const SizedBox(height: 24),
            const SizedBox(
              width: double.infinity,
              child: Text(
                'Nama Lengkap',
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(height: 6,),

            // ignore: avoid_unnecessary_containers
            // Container(
            //   child: InputText(label :"Masukkan nama lengkap", border: BorderSide.none, color: textFieldC!, maxLines: 1,)
            // ),
            InputPrimary(onChange: (p0) {
              
            }, controller: controllerName, onTap: (){}, hintText: 'Masukkan nama lengkap',),
            const SizedBox(height: 16),
            const SizedBox(
              width: double.infinity,
              child: Text(
                'Tanggal Lahir',
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(height: 6,),

            // ignore: avoid_unnecessary_containers
            // Container(
            //   child: InputText(label :"Masukan tanggal lahir ", border: BorderSide.none, color:textFieldC!, maxLines: 1,)
            // ),
            InputPrimary(
              controller: controllerDate,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1800),
                    lastDate: DateTime(2101));

                if (pickedDate != null) {
                  // ignore: avoid_print
                  print(pickedDate);
                  String formattedDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                  // ignore: avoid_print
                  print(formattedDate);

                  setState(() {
                    controllerDate.text = formattedDate;
                  });
                } else {
                  // ignore: avoid_print
                  print("Date is not selected");
                }
              },
              hintText: "Masukkan tanggal lahir",
              onChange: (val) {},
              validate: (value) {
                if (value.toString().isNotEmpty) {
                  return null;
                }
                return "Tanggal lahir tidak boleh kosong";
              },
              prefixIcon: const Icon(Icons.calendar_month),
            ),
            const SizedBox(height: 16),
            const SizedBox(
              width: double.infinity,
              child: Text(
                'Jenis Kelamin',
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              width: Get.width,
              decoration: BoxDecoration(
                  color: AppColor.bgForm,
                  borderRadius: BorderRadius.circular(10),
                  border: BorderStyles.borderGrey),
              // dropdown below..
              child: DropdownButton<String>(

                // value: selectedValue,
                onChanged: (String? newValue) =>
                    setState(() => selectedValue = newValue!),
                items: jenisKelamin
                    .map<DropdownMenuItem<String>>(
                        (String value) => DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColor.bodyColor.shade500,
                                ),
                              ),
                            ))
                    .toList(),
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Color(0xffb6b6b6),
                ),
                iconSize: 20,
                underline: const SizedBox(),
                isExpanded: true,
              ),
            ),

            const SizedBox(height: 16),
            const SizedBox(
              width: double.infinity,
              child: Text(
                'Kota / Provinsi',
                textAlign: TextAlign.left,
              ),
            ),
                        InputPrimary(onChange: (p0) {}, controller: controllerKota, onTap: (){}, hintText: 'Isi kota anda',),

            const SizedBox(height: 16),
            const SizedBox(
              width: double.infinity,
              child: Text(
                'Alamat',
                textAlign: TextAlign.left,
              ),
            ),
            InputPrimary(onChange: (p0) {}, controller: controllerAlamat, onTap: (){}, hintText: 'Isi alamat anda',),
            const SizedBox(height: 50),
            Container(
              margin: const EdgeInsets.only(bottom: 24),
              height: 45,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (){
                  Get.toNamed(Routes.LAYANAN);
                },
                style:
                    ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                      backgroundColor: buttonColor
                    ),
                child:  Text(
                  "Lanjutkan",
                  style: whiteTextStyle.copyWith(fontWeight: bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      );
    
  }
}
