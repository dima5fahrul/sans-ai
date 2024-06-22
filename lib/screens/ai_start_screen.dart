import 'package:flutter/material.dart';
import 'package:sansai_mobile/components/common_button.dart';
import 'package:sansai_mobile/screens/ai_ask_screen.dart';

import '../shared/my_colors.dart';

class AIStartScreen extends StatefulWidget {
  const AIStartScreen({super.key});

  @override
  State<AIStartScreen> createState() => _AIStartScreenState();
}

class _AIStartScreenState extends State<AIStartScreen> {
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
          Row(
            children: [
              GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close)),
              const Spacer(),
              Text('Tes Kesehatan Mental',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.black, fontWeight: FontWeight.bold)),
              const Spacer(),
            ],
          ),
          Column(children: [
            Image.asset('assets/images/computer.png', width: 280),
            const SizedBox(height: 40),
            Text('Ketahui Kondisi Kesehatan Mentalmu',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Colors.black, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(
                'Hasil dari tes ini adalah gambaran kondisi kesehatan mentalmu, tidak ada jawaban yang benar ataupun salah jadi jawab dengan jujur ya!',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.black)),
            const SizedBox(height: 10),
            Text(
                'Perlu diingat untuk tidak mendiagnosis diri sendiri dari hasil tes ini.',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.black)),
          ]),
          CommonButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const AIAskScreen())),
              text: 'Mulai',
              color: MyColors.firstColor),
        ],
      ),
    ));
  }
}
