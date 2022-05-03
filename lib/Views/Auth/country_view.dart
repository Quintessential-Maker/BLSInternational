import 'package:app_in/Helper/app_button.dart';
import 'package:app_in/Helper/images_helper.dart';
import 'package:app_in/Helper/navigator_helper.dart';
import 'package:app_in/Helper/sizer_helper.dart';
import 'package:app_in/Helper/string_helper.dart';
import 'package:app_in/Views/Auth/login_view.dart';
import 'package:flutter/material.dart';

class CountryView extends StatefulWidget {
  const CountryView({Key? key}) : super(key: key);

  @override
  State<CountryView> createState() => _CountryViewState();
}

class _CountryViewState extends State<CountryView> {
  PageController controller = PageController();
  var images = [Img.pak, Img.italy, Img.india];
  var country = ['Pakistan', 'Italy', 'India'];
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              Const.leavingFrom,
              textScaleFactor: 1,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Sizer.vSpace(context, 0.02),
            _buildImages(),
            SizedBox(
              height: Sizer.dHeight(context) * 0.06,
              child: _buildIndicator(),
            ),
          ],
        ),
      ),
      bottomSheet: getStarted(),
    );
  }

  Widget _buildImages() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            controller.previousPage(
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeIn,
            );
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.grey,
          ),
        ),
        SizedBox(
          height: Sizer.dHeight(context) * 0.2,
          width: Sizer.dWidth(context) / 2,
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overScroll) {
              overScroll.disallowIndicator();
              return false;
            },
            child: PageView.builder(
              scrollDirection: Axis.horizontal,
              controller: controller,
              onPageChanged: (value) {
                setState(() {
                  currentIndex = value;
                });
              },
              itemCount: images.length,
              itemBuilder: (context, index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 1000),
                  child: Column(
                    children: [
                      Image.asset(
                        images[index],
                        filterQuality: FilterQuality.medium,
                        height: Sizer.dHeight(context) * 0.15,
                      ),
                      Sizer.vSpace(context, 0.02),
                      Text(
                        country[index],
                        textScaleFactor: 1,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            controller.nextPage(
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeIn,
            );
          },
          icon: const Icon(
            Icons.arrow_forward_ios_rounded,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildIndicator() {
    return ListView.builder(
      itemCount: images.length,
      primary: false,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          height: 5,
          width: currentIndex == index ? 7 : 5,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            color: currentIndex == index
                ? Colors.black
                : Colors.black.withOpacity(0.3),
            shape: BoxShape.circle,
          ),
        );
      },
    );
  }

  Widget getStarted() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 46, vertical: 16),
      child: Appbutton(
        onTap: () => Nav.to(context, const LoginView()),
        text: Const.getStarted,
      ),
    );
  }
}
