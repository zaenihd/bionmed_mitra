
import 'package:bionmed/app/modules/doctor_app/detail/controllers/detail_controller.dart';
import 'package:bionmed/app/widget/button/button_gradien.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Resep extends StatelessWidget {
  Resep({super.key});

  final myC = Get.put(DetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Resep",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        titleTextStyle: const TextStyle(color: Colors.black),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                    color: Color(0xffF3F3F3)),
                child: 
                CachedNetworkImage(
        imageUrl: myC.imageRecipe.toString(),
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
     ),),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
              child: Text(
                myC.imageRecipe.value.substring(40),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
      bottomSheet: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
          child: ButtomGradient(label: "Kembali", onTap: (){Get.back();})
     ) );
  }
}

