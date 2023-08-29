import 'package:bionmed/app/widget/appbar/appbar_gradient.dart';
import 'package:bionmed/app/widget/txt/text.dart';
import 'package:bionmed/theme.dart';
import 'package:flutter/material.dart';

class SopNurse extends StatelessWidget {
  const SopNurse({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarGradient('SCOPE OF WORK PERAWAT'),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Txt(
                text: 'SCOPE OF WORK PERAWAT  (NURSING HOME):',
                weight: bold,
              ),
              const SizedBox(
              height: 20.0,
              ),
              Txt(text: '1. Mengukur tanda-tanda vital (tensi, nadi, suhu, skala nyeri)', size: 11,),
              Txt(text: '2. Memeriksa saturasi oksigen', size: 11,),
              Txt(text: '3. Merawat luka', size: 11,),
              Txt(text: '4. Memandikan pasien dewasa/ geriatri', size: 11,),
              Txt(text: '5. Pijat laktasi', size: 11,),
              Txt(text: '6. Memandikan bayi dan merawat tali pusat', size: 11,),
              Txt(text: '7. Memasang dan melepas kateter', size: 11,),
              Txt(text: '8. Perawatan cateter', size: 11,),
              Txt(text: '9. Memasang dan melepas NGT', size: 11,),
              Txt(text: '10. Memberikan makan melalui NGT', size: 11,),
              Txt(text: '11. Masase payudara ibu pasca bersalin', size: 11,),
              Txt(text: '13. Pijat bayi', size: 11,),
              Txt(text: '14. Pemeriksaan GDS, Asam urat, Cholesterol ', size: 11,),
              const SizedBox(
              height: 20.0,
              ),
               Txt(
                text: 'Melaksanakan instruksi Dokter :',
                weight: bold,
              ),
              const SizedBox(
              height: 20.0,
              ),
              Txt(text: '1. Memasang dan melepas infus', size: 11,),
              Txt(text: '2. Memberikan suntikan (IV, SC, IM)', size: 11,),
              Txt(text: '3. Memberikan suntikan KB', size: 11,),
              Txt(text: '4. Nebulizer', size: 11,),
              const SizedBox(
              height: 20.0,
              ),
              Txt(
                text: 'SCOPE OF WORK BIDAN ( MOTHER CARE ) :',
                weight: bold,
              ),
              const SizedBox(
              height: 20.0,
              ),
              Txt(
                text: 'Kunjungan rumah ibu hamil ',
                weight: bold,
                size: 11,
              ),
              const SizedBox(
              height: 10.0,
              ),
              Txt(text: '1. Memeriksa keadaan umum, pemeriksaan fisik dan TTV Ibu hamil (menilai tanda bahaya yang harus diwaspadai)', size: 11,),
              Txt(text: '2. Memberikan edukasi kesehatan : ', size: 11,),
              const SizedBox(
              height: 5.0,
              ),
              Txt(text: '     -  Perkembangan kehamilan normal dan tatalaksananya ', size: 11,),
              Txt(text: '     -  Tanda bahaya kehamilan ', size: 11,),
              Txt(text: '     -  Personal hygiene, pola istirahat ', size: 11,),
              Txt(text: '     -  Therapi obat ', size: 11,),
              Txt(text: '     -  Tanda - tanda persalinan dan persiapannya', size: 11,),
              const SizedBox(
              height: 10.0,
              ),
               Txt(
                text: 'Kunjungan rumah ibu hamil ',
                weight: bold,
                size: 11,
              ),
              const SizedBox(
              height: 10.0,
              ),
              Txt(text: '1. Pemantauan masa nifas hari ke 6 ', size: 11,),
              Txt(text: '2. Memeriksa keadaan umum, pemeriksaan fisik dan TTV Ibu nifas (menilai tanda bahaya yang harus diwaspadai : infeksi, perdarahan, impending eklampsia)', size: 11,),
              Txt(text: '3. Memberikan edukasi kesehatan : pola makan, proses involusi uterus, cara menyusui ', size: 11,),
              Txt(text: '4. Pijat laktasi', size: 11,),
              Txt(text: '5. Melayani KB', size: 11,),
              const SizedBox(
              height: 10.0,
              ),
               Txt(
                text: 'Kunjungan neonatal ( SOW BABY CARE) ',
                weight: bold,
                size: 11,
              ),
              const SizedBox(
              height: 10.0,
              ),
              Txt(text: '1. Pemeriksaan Bayi (menilai tanda bahaya yang harus diwaspadai)', size: 11,),
              Txt(text: '2. Memandikan bayi dan perawatan tali pusat', size: 11,),
              Txt(text: '3. Edukasi tentang ASI ekslusif', size: 11,),
              Txt(text: '4. Pijat bayi', size: 11,),
              Txt(text: '5. Pelayanan imunisasi dasar ', size: 11,),



        
        
        
        
        
        
        
        
            ],
          ),
        ),
      ),
    );
  }
}
