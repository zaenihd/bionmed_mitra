import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/pendapatan_tim_hospital_controller.dart';

class PendapatanTimHospitalView
    extends GetView<PendapatanTimHospitalController> {
  const PendapatanTimHospitalView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PendapatanTimHospitalView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'PendapatanTimHospitalView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
