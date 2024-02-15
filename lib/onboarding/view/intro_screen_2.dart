import 'package:carousel_slider/carousel_slider.dart';
import 'package:ekart/login/view/signup_screen.dart';
import 'package:ekart/onboarding/controller/onboarding_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:provider/provider.dart';

class IntroScreen2 extends StatelessWidget {
  const IntroScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    List carouselImages = [
      "assets/images/onboardingImg1.png",
      "assets/images/onboardingImg2.png",
      "assets/images/onboardingImg3.png"
    ];
    return Scaffold(
      body: Stack(children: [
        Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.white,
                width: double.infinity,
                child: Consumer<OnboardingController>(
                  builder: (context, value, child) => Column(
                    children: [
                      const SizedBox(
                        height: 90,
                      ),
                      OnboardingTextWidget1(
                          text: value.carouselIndex == 0
                              ? "Discover Something new"
                              : value.carouselIndex == 1
                                  ? "Update trendy outfit"
                                  : "Explore your true style"),
                      const SizedBox(
                        height: 17,
                      ),
                      OnboardingText2(
                          text: value.carouselIndex == 0
                              ? "Special new arrivals just for you"
                              : value.carouselIndex == 1
                                  ? "Favorite brands and hottest trends"
                                  : "Relax and let us bring the style to you"),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 351,
              width: double.infinity,
              color: const Color(0xff464447),
              child: Column(
                children: [
                  const SizedBox(
                    height: 155,
                  ),
                  Consumer<OnboardingController>(
                    builder: (context, value, child) => DotsIndicator(
                      dotsCount: 3,
                      position: value.carouselIndex,
                      decorator: const DotsDecorator(
                          color: Color(0xff464447),
                          activeColor: Colors.white,
                          shape: CircleBorder(
                              side: BorderSide(color: Colors.white))),
                    ),
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignupSCreen(),
                          ));
                    },
                    child: Container(
                      height: 53,
                      width: 210,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(29.5),
                          color: const Color(0xffFFFFFF).withOpacity(.25),
                          border: Border.all(width: 1.18, color: Colors.white)),
                      child: Center(
                          child: Text(
                        "Shopping now",
                        style: GoogleFonts.ptSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      )),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        Align(
          alignment: Alignment.center,
          child: CarouselSlider(
            items: List.generate(
                3,
                (index) => Container(
                      width: 261,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xffE7E8E9)),
                      child: Image.asset(
                        carouselImages[index],
                        scale: 4,
                      ),
                    )),
            options: CarouselOptions(
              height: 368,
              enlargeCenterPage: true,
              viewportFraction: 0.75,
              enableInfiniteScroll: false,
              onPageChanged: (index, reason) {
                Provider.of<OnboardingController>(context, listen: false)
                    .toggleCarouselIndex(index);
              },
            ),
          ),
        )
      ]),
    );
  }
}




class OnboardingText2 extends StatelessWidget {
  final String text;
  const OnboardingText2({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: GoogleFonts.ptSans(
          fontSize: 14,
        ));
  }
}

class OnboardingTextWidget1 extends StatelessWidget {
  final String text;
  const OnboardingTextWidget1({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.ptSans(fontSize: 20, fontWeight: FontWeight.w700),
    );
  }
}
