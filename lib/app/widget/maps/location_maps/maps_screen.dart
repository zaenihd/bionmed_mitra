// import 'dart:async';

// import 'package:bionmed/app/widget/maps/location_maps/widget/card_address.dart';
// import 'package:bionmed/app/widget/other/loading_indicator.dart';
// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:loading_overlay/loading_overlay.dart';

// import '../../../constant/colors.dart';


// class MapsScreen extends StatefulWidget {
//   @override
//   _MapsScreenState createState() => _MapsScreenState();
// }

// class _MapsScreenState extends State<MapsScreen> {
//   var storeController = Get.find<StoreController>();

//   @override
//   void initState() {
//     super.initState();
//     storeController.fetchAddresses();
//     storeController.fetchProfile();
//   }

//   String location = 'Null, Press Button';
//   String Address = 'Alamat anda...';

//   Future _getGeoLocationPosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     // Test if location services are enabled.
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       await Geolocator.openLocationSettings();
//       return Future.error('Location services are disabled.');
//     }

//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         // your App should show an explanatory UI now.
//         return Future.error('Location permissions are denied');
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       // Permissions are denied forever, handle appropriately.
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }

//     // When we reach here, permissions are granted and we can
//     // continue accessing the position of the device.
//     return await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//   }

//   Future GetAddressFromLatLong(Position position) async {
//     List placemarks =
//         await placemarkFromCoordinates(position.latitude, position.longitude);
//     print(placemarks);
//     Placemark place = placemarks[0];
//     Address =
//         '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Alamat anda'),
//         backgroundColor: AppColor.secondColor,
//         elevation: 0,
//       ),
//       body: Container(
//         margin: const EdgeInsets.all(26),
//         decoration: const BoxDecoration(
//           color: Colors.transparent,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(25.0),
//             topRight: Radius.circular(25.0),
//           ),
//         ),
//         child: Obx(
//           () => Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               storeController.loading.value
//                   ? loadingIndicator()
//                   : Column(
//                       children: [
//                         ...storeController.addresses.map((e) {
//                           print(e);
//                           // var e = v['address'][0];
//                           return InkWell(
//                             onTap: () {
//                               storeController.setSelectedAddress(e);
//                               Get.back();
//                             },
//                             child: CardAddress(
//                               label: e['label'],
//                               desc:
//                                   '${e['address1']} ${e['address2'] != '' ? ', ' : ''} ${e['address2']}',
//                               isDefault: e['default'],
//                             ),
//                           );
//                         }),
//                       ],
//                     ),
//               const SizedBox(height: 16),
//               InkWell(
//                 onTap: () {
//                   // Get.to(() => const PageLocation());

//                   // await Get.to(() => const AddAddress());
//                   storeController.fetchAddresses();
//                 },
//                 child: DottedBorder(
//                   padding: const EdgeInsets.all(17),
//                   radius: const Radius.circular(12),
//                   color: const Color(0xffCCCCCC),
//                   dashPattern: const [8, 5],
//                   strokeWidth: 2,
//                   child: const Center(
//                     child: Text(
//                       "Tambah alamat baru",
//                       style: TextStyle(color: AppColor.weakColor),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 30),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
