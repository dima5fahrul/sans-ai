import 'package:flutter/material.dart';

import '../shared/my_colors.dart';
import 'ai_result_screen.dart';

class AIAskScreen extends StatefulWidget {
  const AIAskScreen({super.key});

  @override
  State<AIAskScreen> createState() => _AIAskScreenState();
}

class _AIAskScreenState extends State<AIAskScreen> {
  List askText = [
    'Apakah kamu pernah mendapatkan diagnosis gangguan kesehatan mental dari profesional?',
    'Apakah kamu sedang mengkonsumsi obat-obatan medis secara rutin?',
    'Bagaimana kondisi keuanganmu sekarang?',
    'Apakah kamu menilai dirimu sebagai orang yang religius?',
    'Dalam dua minggu terakhir saya merasa mampu menanggung semua masalah-masalah saya.',
    'Dalam dua minggu terakhir saya dapat berkonsentrasi pada apapun yang saya kerjakan.',
    'Dalam dua minggu terakhir saya sulit tidur karena khawatir.',
    'Dalam dua minggu terakhir saya merasa mampu membuat suatu keputusan.',
    'Dalam dua minggu terakhir saya merasa terus dibawah tekanan.',
    'Dalam dua minggu terakhir saya merasa kehilangan kepercayaan diri.'
  ];

  List answerText = [
    ['Ya', 'Tidak'],
    ['Ya', 'Tidak'],
    ['Baik', 'Biasa Saja', 'Buruk'],
    ['Ya', 'Tidak', 'Mungkin'],
    [
      'Lebih baik dari biasanya',
      'Sama seperti biasanya',
      'Kurang dari biasanya',
      'Sangat kurang dari biasanya'
    ],
    [
      'Lebih baik dari biasanya',
      'Sama seperti biasanya',
      'Kurang dari biasanya',
      'Sangat kurang dari biasanya'
    ],
    [
      'Lebih baik dari biasanya',
      'Sama seperti biasanya',
      'Kurang dari biasanya',
      'Sangat kurang dari biasanya'
    ],
    [
      'Lebih baik dari biasanya',
      'Sama seperti biasanya',
      'Kurang dari biasanya',
      'Sangat kurang dari biasanya'
    ],
    [
      'Lebih baik dari biasanya',
      'Sama seperti biasanya',
      'Kurang dari biasanya',
      'Sangat kurang dari biasanya'
    ],
    [
      'Lebih baik dari biasanya',
      'Sama seperti biasanya',
      'Kurang dari biasanya',
      'Sangat kurang dari biasanya'
    ],
  ];

  int _increment = 0;

  void _incrementStep() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Dialog(
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            child: Center(
                child: SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(color: Colors.white)))));

    Future.delayed(const Duration(milliseconds: 1500), () {
      Navigator.of(context).pop();

      if (_increment < 9) {
        setState(() {
          _increment++;
        });
      } else {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const AIResultScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            const SizedBox(height: 20),
            _lineStep(
                context: context,
                step: '${_increment + 1}/10',
                width: _increment / 10),
            const SizedBox(height: 30),
            SizedBox(
                width: double.infinity,
                height: 100,
                child: Text(askText[_increment],
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.black, fontWeight: FontWeight.bold))),
            const SizedBox(height: 20),
            SizedBox(
                width: double.infinity,
                height: 400,
                child: ListView.separated(
                    padding: const EdgeInsets.all(0),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: answerText[_increment].length,
                    itemBuilder: (context, index) {
                      return _buttonAnswer(
                          context: context,
                          onPressed: () => _incrementStep(),
                          text: answerText[_increment][index],
                          color: MyColors.firstColor);
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10))),
          ],
        ),
      ),
    );
  }

  Widget _buttonAnswer(
      {required BuildContext context,
      required String text,
      required Color color,
      required Function() onPressed}) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: color,
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        child: Text(text,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  SizedBox _lineStep(
      {required BuildContext context,
      required String step,
      required double width}) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Align(
              alignment: Alignment.centerRight,
              child: Text(step, style: Theme.of(context).textTheme.labelSmall)),
          Align(
            alignment: Alignment.centerLeft,
            child: Stack(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: 5,
                    decoration: const BoxDecoration(
                        color: Color(0xFFD9D9D9),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(5),
                            bottomRight: Radius.circular(5)))),
                Container(
                    width: MediaQuery.of(context).size.width * width,
                    height: 5,
                    decoration: const BoxDecoration(
                        color: Color(0xFF5C85CF),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            bottomLeft: Radius.circular(5)))),
              ],
            ),
          )
        ],
      ),
    );
  }
}
