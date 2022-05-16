import 'package:app_in/Controllers/Dashboard/home_controller.dart';
import 'package:app_in/Helper/images_helper.dart';
import 'package:app_in/Helper/navigator_helper.dart';
import 'package:app_in/Helper/sizer_helper.dart';
import 'package:app_in/Helper/string_helper.dart';
import 'package:app_in/Views/Auth/login_view.dart';
import 'package:app_in/Views/demo_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../Helper/Server/api_helper.dart';
import '../ApplicationView.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeController controller = Get.put(HomeController());
RxInt dialogCount = 0.obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setUserData();

    /*if(dialogCount == 0){
      _showDialog(context);
    }*/

  }

  void setUserData() async {
    await Api.getUserData().then((value) => {
          if (value == "Null")
            {
              controller.name.value = Const.appName,
              controller.email.value = Const.appEMail,
            }
          else
            {
              controller.name.value = value['data']['name'],
              controller.email.value = value['data']['email'],
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: const Color(0xffefdaaf),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _appbarWidget(),
              _mainWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _appbarWidget() {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                Img.profileFilled,
                height: 45,
              ),
              Sizer.hSpace(context, 0.04),
              Obx(() {
                return controller.name.value != null
                    ? Text(
                        '${controller.name.value} \n ${controller.email.value}',
                        textScaleFactor: 1,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : Text(
                        Const.appName,
                        textScaleFactor: 1,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      );
              })
            ],
          ),
          IconButton(
              onPressed: () {
                controller.logoutData();
              },
              icon: Icon(Icons.logout, color: Colors.black))
        ],
      ),
    );
  }

  Widget _mainWidget() {
    return Expanded(
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _topWidgets(),
              _SliderWidget(controller: controller),
              _activeAppointment(),
              Sizer.vSpace(context, 0.02),
              _exploreServices(),
              Sizer.vSpace(context, 0.02),
            ],
          ),
        ),
      ),
    );
  }

  Widget _topWidgets() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () => {
              dialogCount++,
              Nav.to(context, const LoginView())
            },
            child: const _TopWidget(
              image: Img.desktopOutline,
              title: Const.createAccount,
              imageSize: 25,
              padding: EdgeInsets.fromLTRB(6, 6, 6, 2),
            ),
          ),
          InkWell(
            onTap: () => {
              dialogCount++,
              // Nav.to(context, const ApplicationView())
              Nav.to(context, const DemoScreen())
            },
            child: const _TopWidget(
              image: Img.docWrite,
              title: Const.onlineApplication,
              imageSize: 25,
              padding: EdgeInsets.all(8),
            ),
          ),
          const _TopWidget(
            image: Img.calendarMore,
            title: Const.bookAppointment,
            imageSize: 25,
            padding: EdgeInsets.all(8),
          ),
          const _TopWidget(
            image: Img.docUpload,
            title: Const.appointmentConfirmation,
            imageSize: 18,
            padding: EdgeInsets.all(10),
          ),
        ],
      ),
    );
  }

  Widget _activeAppointment() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            Const.activeAppointment,
            textAlign: TextAlign.left,
            textScaleFactor: 1.2,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(),
          Sizer.vSpace(context, 0.02),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(-3, 3),
                  color: Colors.black12,
                  blurRadius: 10,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Color(0xffefdaaf),
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        Img.user,
                        height: 25,
                        color: Colors.white,
                      ),
                    ),
                    Sizer.hSpace(context, 0.02),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Appointment Confirmed',
                          textScaleFactor: 1.1,
                          style: TextStyle(
                            color: Color(0xffefdaaf),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Ramesh kumar sharma, M-29',
                          textScaleFactor: 0.9,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Your appointment has been confirmed on\n19-march-2022',
                          textScaleFactor: 0.9,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Sizer.vSpace(context, 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        Const.needHelp,
                        textScaleFactor: 1,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: const Color(0xffefdaaf),
                        ),
                      ),
                      child: const Text(
                        Const.trackNow,
                        textScaleFactor: 1,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        Const.fillOnline,
                        textScaleFactor: 1,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _exploreServices() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            Const.exploreService,
            textAlign: TextAlign.left,
            textScaleFactor: 1.2,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(),
          Sizer.vSpace(context, 0.02),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(-3, 3),
                  color: Colors.black12,
                  blurRadius: 10,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    _ExploreWidget(
                      image: Img.desktopOutline,
                      title: Const.createAccount,
                      imageSize: 25,
                      padding: EdgeInsets.fromLTRB(6, 6, 6, 2),
                    ),
                    _ExploreWidget(
                      image: Img.docWrite,
                      title: Const.onlineApplication,
                      imageSize: 25,
                      padding: EdgeInsets.all(8),
                    ),
                    _ExploreWidget(
                      image: Img.calendarMore,
                      title: Const.bookAppointment,
                      imageSize: 25,
                      padding: EdgeInsets.all(8),
                    ),
                    _ExploreWidget(
                      image: Img.docUpload,
                      title: Const.appointmentConfirmation,
                      imageSize: 18,
                      padding: EdgeInsets.all(10),
                    ),
                  ],
                ),
                Sizer.vSpace(context, 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    _ExploreWidget(
                      image: Img.desktopOutline,
                      title: Const.createAccount,
                      imageSize: 25,
                      padding: EdgeInsets.fromLTRB(6, 6, 6, 2),
                    ),
                    _ExploreWidget(
                      image: Img.docWrite,
                      title: Const.onlineApplication,
                      imageSize: 25,
                      padding: EdgeInsets.all(8),
                    ),
                    _ExploreWidget(
                      image: Img.calendarMore,
                      title: Const.bookAppointment,
                      imageSize: 25,
                      padding: EdgeInsets.all(8),
                    ),
                    _ExploreWidget(
                      image: Img.docUpload,
                      title: Const.appointmentConfirmation,
                      imageSize: 18,
                      padding: EdgeInsets.all(10),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

_showDialog(BuildContext context) {
    showDialog(
        builder: (context) => CupertinoAlertDialog(
          title: Column(
            children: <Widget>[
              Text("Your Account has been created successfully"),
              Padding(
                padding: EdgeInsets.all(5),
              ),
              Image.asset(
                'assets/images/success.png',
                filterQuality: FilterQuality.medium,
                height: 100,
              ),
              Padding(
                padding: EdgeInsets.all(5),
              ),
            ],
          ),
          content: new Text("An iOS-style alert dialog." +
              "An alert dialog informs the user about situations that require acknowledgement."),
          actions: <Widget>[
            CupertinoButton(
              child: Text(
                'Fill Online Application',
                style: TextStyle(fontSize: 20.0),
              ),
              padding: EdgeInsets.all(10),
              color: Colors.blueAccent,
              onPressed: () {
                Navigator.of(context).pop();
              },

            ),
            SizedBox(
              width: 10,
              height: 5,
            ),
            CupertinoButton(
              child: Text(
                'Book Your Appoinment',
                style: TextStyle(fontSize: 20.0),
              ),
              padding: EdgeInsets.all(10),
              color: Colors.blueAccent,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            SizedBox(
              width: 10,
              height: 5,
            ),
            CupertinoButton(
              child: Text(
                'Go To My Account',
                style: TextStyle(fontSize: 20.0),
              ),
              padding: EdgeInsets.all(10),
              color: Colors.blueAccent,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            SizedBox(
              width: 10,
              height: 5,
            ),
          ],
        ),
        context: context);
  }
}

class _TopWidget extends StatelessWidget {
  const _TopWidget({
    Key? key,
    required this.image,
    required this.title,
    required this.imageSize,
    required this.padding,
  }) : super(key: key);
  final String image;
  final String title;
  final double imageSize;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 45,
          width: 45,
          padding: padding,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey),
          ),
          child: SvgPicture.asset(
            image,
            height: imageSize,
            color: const Color(0xffcdb264),
          ),
        ),
        Sizer.vSpace(context, 0.01),
        Text(
          title,
          textScaleFactor: 0.7,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _SliderWidget extends StatelessWidget {
  const _SliderWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overScroll) {
        overScroll.disallowIndicator();
        return false;
      },
      child: Column(
        children: [
          SizedBox(
            height: Sizer.dHeight(context) * 0.24,
            width: Sizer.dWidth(context),
            child: PageView.builder(
              scrollDirection: Axis.horizontal,
              onPageChanged: controller.changeSliderIndex,
              itemCount: 3,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            Const.applyVisa,
                            textScaleFactor: 1.2,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            Const.sliderContent,
                            textScaleFactor: 0.9,
                            style: TextStyle(
                              color: Colors.white54,
                            ),
                          ),
                          Row(
                            children: const [
                              Text(
                                Const.clickHere,
                                textScaleFactor: 1,
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.white54,
                              ),
                            ],
                          ),
                        ],
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          Img.applyVisa,
                          filterQuality: FilterQuality.medium,
                          height: 150,
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: Sizer.dHeight(context) * 0.06,
            child: ListView.builder(
              itemCount: 3,
              primary: false,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Obx(
                  () => AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    height: 5,
                    width: controller.currentIndex.value == index ? 7 : 5,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: controller.currentIndex.value == index
                          ? Colors.black
                          : Colors.black.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ExploreWidget extends StatelessWidget {
  const _ExploreWidget({
    Key? key,
    required this.image,
    required this.title,
    required this.imageSize,
    required this.padding,
  }) : super(key: key);
  final String image;
  final String title;
  final double imageSize;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 45,
          width: 45,
          padding: padding,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey),
          ),
          child: SvgPicture.asset(
            image,
            height: imageSize,
            color: const Color(0xffcdb264),
          ),
        ),
        Sizer.vSpace(context, 0.01),
        Text(
          title,
          textScaleFactor: 0.7,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
