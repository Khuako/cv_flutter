import 'package:flutter/material.dart';
import 'package:plants/constants/constant_colors.dart';
import 'package:plants/constants/constant_images.dart';
import 'package:plants/constants/constant_text.dart';

import 'login.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final PageController _pageController = PageController(initialPage: 0);
  int currIndex = 0;
  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 10,
      width: isActive ? 20 : 0,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        color: ConstantColors.primaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  List<Widget> _buildIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < 3; i++) {
      if (currIndex == i) {
        indicators.add(_indicator(true));
      } else {
        indicators.add(_indicator(false));
      }
    }
    return indicators;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 20, right: 20),
            child: InkWell(
              onTap: () => null,
              child: const Text(
                'Skip',
                style: TextStyle(
                    fontSize: 17,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
            onPageChanged: (value) {
              setState(() {
                currIndex = value;
              });
            },
            controller: _pageController,
            children: const [
              CreatePage(
                image: ConstantImages.plantOne,
                title: ConstantText.titleOne,
                description: ConstantText.descriptionOne,
              ),
              CreatePage(
                image: ConstantImages.plantTwo,
                title: ConstantText.titleTwo,
                description: ConstantText.descriptionTwo,
              ),
              CreatePage(
                image: ConstantImages.plantThree,
                title: ConstantText.titleThree,
                description: ConstantText.descriptionThree,
              ),
            ],
          ),
          Positioned(
            bottom: 80,
            left: 30,
            child: Row(
              children: _buildIndicator(),
            ),
          ),
          Positioned(
            bottom: 60,
            right: 30,
            child: Container(
              width: 70,
              child: RawMaterialButton(
                onPressed: () {
                  setState(() {
                    if (currIndex < 2) {
                      currIndex++;
                      if (currIndex < 2) {
                        _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn);
                      }
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const Login(),
                        ),
                      );
                    }
                  });
                },
                padding: const EdgeInsets.all(8),
                child: const Icon(
                  Icons.arrow_forward_ios,
                  size: 40,
                  color: Colors.white,
                ),
                fillColor: ConstantColors.primaryColor,
                shape: CircleBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CreatePage extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  const CreatePage({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 50, right: 50, bottom: 80),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 350,
            child: Image.asset(image),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: ConstantColors.primaryColor,
                fontSize: 29,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 19, fontWeight: FontWeight.w500, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
