import 'package:flutter/material.dart';
import 'package:sansai_mobile/components/common_button.dart';
import 'package:sansai_mobile/components/custom_button.dart';
import 'package:sansai_mobile/shared/my_colors.dart';

class AIResultScreen extends StatefulWidget {
  const AIResultScreen({super.key});

  @override
  State<AIResultScreen> createState() => _AIResultScreenState();
}

class _AIResultScreenState extends State<AIResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.close)),
                  const Spacer(),
                  Text('Hasil Tes',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                  const Spacer(),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: MyColors.firstColor,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.asset('assets/images/result-image.png',
                            width: 80),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Kesehatan mentalmu',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                              const SizedBox(height: 5),
                              Text('perlu ditangani oleh profesional',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: Colors.white)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                        'Kamu perlu mempertimbangkan untuk mencari bantuan profesional, karena berdasarkan jawabanmu kondisi seperti ini dapat menyebabkan kesulitan untuk mengelola hubungan bahkan tugas dikehidupan sehari-hari.',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Colors.white)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: MyColors.secondColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(
                      textAlign: TextAlign.center,
                      'Untuk memantau kondisi kesehatan mentalmu, isi secara berkala setiap 1-2 minggu ya!',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.white))),
            ],
          ),
          Column(children: [
            CommonButton(
                onPressed: () {},
                text: 'Lihat Rekomendasi',
                color: MyColors.thirdColor),
            const SizedBox(height: 6),
            CustomButton(
                text: 'Kembali ke beranda',
                onPressed: () => Navigator.pop(context),
                width: MediaQuery.of(context).size.width,
                textColor: Colors.black,
                bgColor: Colors.white,
                withBorder: true,
                height: 40)
          ]),
        ],
      ),
    ));
  }
}
