import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:pangolin_notes/Provider/settings_provider.dart';
import 'package:provider/provider.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  OnBoardingPageState createState() => OnBoardingPageState();
}

class OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  Future<void> _onIntroEnd(context) async {
    await Provider.of<SettingsProvider>(context, listen: false)
        .showOnboardingCompleted();
    Navigator.pushNamed(context, '/');
  }

  Widget _buildFullscreenImage(String asset) {
    return Image.asset(
      asset,
      fit: BoxFit.fitWidth,
      alignment: Alignment.center,
    );
  }

  @override
  Widget build(BuildContext context) {
    const pageDecoration = PageDecoration(
      imagePadding: EdgeInsets.only(bottom: 20),
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.transparent,

      pages: [
        PageViewModel(
          title: "",
          body: "",
          image: _buildFullscreenImage('assets/intro/1.png'),
          decoration: pageDecoration.copyWith(
            imageAlignment: Alignment.topCenter,
            contentMargin: const EdgeInsets.symmetric(horizontal: 1),
            fullScreen: true,
            imageFlex: 5,
          ),
        ),
        PageViewModel(
          title: "",
          body: "",
          image: _buildFullscreenImage('assets/intro/2.png'),
          decoration: pageDecoration.copyWith(
            imageAlignment: Alignment.topCenter,
            contentMargin: const EdgeInsets.symmetric(horizontal: 1),
            fullScreen: true,
            imageFlex: 5,
          ),
        ),
        PageViewModel(
          title: "",
          body: "",
          image: _buildFullscreenImage('assets/intro/4.png'),
          decoration: pageDecoration.copyWith(
            imageAlignment: Alignment.topCenter,
            contentMargin: const EdgeInsets.symmetric(horizontal: 1),
            fullScreen: true,
            imageFlex: 5,
          ),
        ),
        PageViewModel(
          title: "",
          body: "",
          image: _buildFullscreenImage('assets/intro/5.png'),
          decoration: pageDecoration.copyWith(
            imageAlignment: Alignment.topCenter,
            contentMargin: const EdgeInsets.symmetric(horizontal: 1),
            fullScreen: true,
            imageFlex: 5,
          ),
        ),
        PageViewModel(
          title: "",
          body: "",
          image: _buildFullscreenImage('assets/intro/3.png'),
          decoration: pageDecoration.copyWith(
            imageAlignment: Alignment.topCenter,
            contentMargin: const EdgeInsets.symmetric(horizontal: 1),
            fullScreen: true,
            imageFlex: 5,
          ),
        ),
        PageViewModel(
          title: "",
          body: "",
          image: _buildFullscreenImage('assets/intro/6.png'),
          decoration: pageDecoration.copyWith(
            imageAlignment: Alignment.topCenter,
            contentMargin: const EdgeInsets.symmetric(horizontal: 1),
            fullScreen: true,
            imageFlex: 5,
          ),
        ),
        PageViewModel(
          title: "",
          body: "",
          image: _buildFullscreenImage('assets/intro/7.png'),
          decoration: pageDecoration.copyWith(
            imageAlignment: Alignment.topCenter,
            contentMargin: const EdgeInsets.symmetric(horizontal: 1),
            fullScreen: true,
            imageFlex: 5,
          ),
          reverse: true,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: false,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: true,
      //rtl: true, // Display as right-to-left
      back: const Icon(Icons.arrow_back),
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.black87,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
