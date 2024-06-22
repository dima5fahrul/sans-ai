import 'package:flutter/material.dart';
import 'package:sansai_mobile/components/common_dropdown.dart';
import 'package:sansai_mobile/shared/my_colors.dart';

class DetailGroupScreen extends StatefulWidget {
  const DetailGroupScreen({super.key});

  @override
  State<DetailGroupScreen> createState() => _DetailGroupScreenState();
}

class _DetailGroupScreenState extends State<DetailGroupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 1,
          shadowColor: Colors.black,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          title: Text('Niko Calendar',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.w700))),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFFF8F8F8),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: ListView(
            children: [
              CommonDropdown(
                  hintText: 'Pilih Orang',
                  value: 'Mochamad Nauval Azhar',
                  onChanged: (value) {},
                  items: const ['Mochamad Nauval Azhar', 'Dimas Fahrul'],
                  textColor: Colors.black),
              const SizedBox(height: 20),
              // Text('Mood Bulanan',
              //     style: Theme.of(context).textTheme.titleMedium!.copyWith(
              //         fontWeight: FontWeight.w600, color: Colors.black)),
              // const SizedBox(height: 10),
              Image.asset('assets/images/calendar-sample.png'),
              const SizedBox(height: 20),
              // Text('Insights',
              //     style: Theme.of(context).textTheme.titleMedium!.copyWith(
              //         fontWeight: FontWeight.w600, color: Colors.black)),
              Image.asset('assets/images/statistic-sample.png'),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                decoration: BoxDecoration(
                    color: MyColors.primaryColor,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(Icons.warning_amber_rounded,
                                    color: Colors.white),
                                const SizedBox(width: 4),
                                Text('Saran',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white)),
                              ]),
                          const SizedBox(height: 8),
                          const _BulletList(items: [
                            'Lakukan meditasi untuk tidur yang lebih baik',
                            'Yuk mulai olahraga ringan! seperti jogging atau berjalan kaki'
                          ]),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(Icons.insert_drive_file_outlined,
                                    color: Colors.white),
                                const SizedBox(width: 4),
                                Text('Hasil Tes Kesehatan Mental',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white)),
                              ]),
                          const SizedBox(height: 8),
                          Text('Terakhir tes: Hari ini',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: Colors.white)),
                          const SizedBox(height: 4),
                          Text(
                            'Perlu ditangani oleh profesional',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _BulletList extends StatelessWidget {
  final List<String> items;

  const _BulletList({required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: items.map((item) => _BulletListItem(text: item)).toList(),
    );
  }
}

class _BulletListItem extends StatelessWidget {
  final String text;

  const _BulletListItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("• ",
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: Colors.white)),
        const SizedBox(width: 8),
        Expanded(
            child: Text(text,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.white)))
      ],
    );
  }
}
