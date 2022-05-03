import 'package:app_in/Helper/images_helper.dart';
import 'package:app_in/Helper/sizer_helper.dart';
import 'package:app_in/Helper/string_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
              const Text(
                Const.appName,
                textScaleFactor: 1,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Icon(Icons.menu, color: Colors.black)
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
        child: Column(
          children: [],
        ),
      ),
    );
  }

  Widget _topWidgets() {
    return Row(
      children: [

      ],
    );
  }
}

class _TopWidgets extends StatelessWidget {
  const _TopWidgets({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}