import 'package:flutter/material.dart';

import '../components/common_button.dart';
import '../shared/my_colors.dart';
import 'login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentPage = 0;
  final _controller = PageController();

  AnimatedContainer _buildDots({
    int? index,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),
        color: MyColors.primaryColor,
      ),
      margin: const EdgeInsets.only(right: 5),
      height: 10,
      curve: Curves.easeIn,
      width: _currentPage == index ? 20 : 10,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(30.0),
      child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  flex: 3,
                  child: PageView.builder(
                    controller: _controller,
                    itemCount: _onboardingViewBuilder.length,
                    onPageChanged: (int index) =>
                        setState(() => _currentPage = index),
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            _onboardingViewBuilder[index].image,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            _onboardingViewBuilder[index].title,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            _onboardingViewBuilder[index].description,
                            style: Theme.of(context).textTheme.bodyMedium,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      );
                    },
                  )),
              CommonButton(
                  onPressed: () {
                    if (_currentPage == _onboardingViewBuilder.length - 1) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const LoginScreen()));
                    } else {
                      _controller.nextPage(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeIn);
                    }
                  },
                  text: 'Lanjutkan'),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _onboardingViewBuilder.length,
                  (index) => _buildDots(index: index),
                ),
              ),
            ],
          )),
    ));
  }
}

class _OnboardingViewBuilder {
  final String title;
  final String description;
  final String image;

  _OnboardingViewBuilder(
      {required this.title, required this.description, required this.image});
}

List<_OnboardingViewBuilder> _onboardingViewBuilder = [
  _OnboardingViewBuilder(
      title: 'Layanan Lengkap',
      description:
          'Jaga kesehatan mentalmu dengan berbagai fitur yang tersedia',
      image: 'assets/images/boarding-1.png'),
  _OnboardingViewBuilder(
      title: 'Buat Dirimu Tenang',
      description: 'Jalani hari dengan lebih mindful bersama Ruang Damai',
      image: 'assets/images/boarding-2.png'),
];
