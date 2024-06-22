import 'package:flutter/material.dart';
import 'package:sansai_mobile/shared/my_colors.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../components/custom_button.dart';
import 'ai_start_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlidingUpPanel(
        minHeight: MediaQuery.of(context).size.height * 0.67,
        maxHeight: MediaQuery.of(context).size.height * 0.85,
        borderRadius: BorderRadiusGeometry.lerp(
            const BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            const BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            1),
        body: const _BodyPanel(),
        panel: const _HomeView(),
      ),
    );
  }
}

class _BodyPanel extends StatefulWidget {
  const _BodyPanel({super.key});

  @override
  State<_BodyPanel> createState() => _BodyPanelState();
}

class _BodyPanelState extends State<_BodyPanel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColors.primaryColor,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text('Hai, User!',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            Text('Bagaimana suasana hatimu saat ini?',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: Colors.white)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('assets/icons/sangat-sedih.png', height: 50),
                Image.asset('assets/icons/sedih.png', height: 50),
                Image.asset('assets/icons/biasa.png', height: 50),
                Image.asset('assets/icons/senang.png', height: 50),
                Image.asset('assets/icons/sangat-senang.png', height: 50),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeView extends StatefulWidget {
  const _HomeView({super.key});

  @override
  State<_HomeView> createState() => _HomePanelState();
}

class _HomePanelState extends State<_HomeView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 30,
            height: 3,
            color: Colors.black,
          ),
          const SizedBox(height: 15),
          Container(
              width: MediaQuery.of(context).size.width,
              height: 60,
              decoration: BoxDecoration(
                  color: const Color(0xFFEAF2FF),
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Bingung dengan moodmu?',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontWeight: FontWeight.bold)),
                          Text('Langsung',
                              style: Theme.of(context).textTheme.bodySmall)
                        ],
                      ),
                      CustomButton(
                          text: 'Tanya AI',
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AIStartScreen())),
                          borderRadius: BorderRadius.circular(7),
                          padding: const EdgeInsets.all(10),
                          bgColor: MyColors.primaryColor,
                          boldText: true,
                          width: 100,
                          height: 40),
                    ],
                  ))),
          const SizedBox(height: 20),
          Container(
            height: 160,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                color: Color(0xFF717EEE),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Column(
                      children: [
                        Text('Cek kondisi kesehatan mentalmu yuk!',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                        Text('Ikuti ini untuk mengetahuinya',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: Colors.white)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                    alignment: Alignment.bottomLeft,
                    child:
                        Image.asset('assets/images/doctor.png', height: 100)),
                Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: CustomButton(
                            text: 'Mulai',
                            onPressed: () {},
                            bgColor: Colors.white,
                            boldText: true,
                            textColor: Colors.black,
                            borderRadius: BorderRadius.circular(20),
                            padding: const EdgeInsets.all(10),
                            width: 120,
                            height: 40))),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Rekomendasi Artikel',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontWeight: FontWeight.bold)),
                Text('Lihat Semua',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.blue, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 170,
            child: ListView(
                padding: const EdgeInsets.all(0),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: const [
                  _ArticleCard(
                      title: 'Mood Cepat Berubah Apakah Bipolar?',
                      subTitle: '30 Menit',
                      image: 'assets/images/article.png',
                      bgColor: Color(0xFF425F93)),
                  SizedBox(width: 10),
                  _ArticleCard(
                      title: 'Cara Berdamai Dengan Masa Lalu',
                      subTitle: '30 Menit',
                      image: 'assets/images/article1.png',
                      bgColor: Color(0xFF425F93))
                ]),
          ),
        ],
      ),
    );
  }
}

class _ArticleCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final String image;
  final Color bgColor;

  const _ArticleCard(
      {required this.title,
      required this.subTitle,
      required this.image,
      required this.bgColor,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 250,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image:
                DecorationImage(image: AssetImage(image), fit: BoxFit.cover)),
        child: Stack(
          children: [
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(title,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                            Text(subTitle,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .copyWith(color: Colors.white))
                          ],
                        )))),
          ],
        ));
  }
}
