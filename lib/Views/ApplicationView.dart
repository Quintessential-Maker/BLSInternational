import 'package:app_in/Controllers/Dashboard/home_controller.dart';
import 'package:app_in/Helper/app_colors.dart';
import 'package:app_in/Helper/images_helper.dart';
import 'package:app_in/Helper/sizer_helper.dart';
import 'package:app_in/Helper/string_helper.dart';
import 'package:app_in/Views/stepper.dart';
import 'package:app_in/custon_common/form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../Helper/Server/api_helper.dart';
import '../Controllers/visa_master_data_controller.dart';

class ApplicationView extends StatefulWidget {
  const ApplicationView({Key? key}) : super(key: key);

  @override
  State<ApplicationView> createState() => _ApplicationViewState();
}

class _ApplicationViewState extends State<ApplicationView> {
  final HomeController controller = Get.put(HomeController());
  final VisaMasterController controller2 = Get.put(VisaMasterController());

  final fieldText = TextEditingController();

  String dropdownvalue = 'Individual';
  String serviceTypeValue = 'Individual';
  String applicantTypeValue = 'Individual';
  String typeOfPassportValue = 'Individual';

  var items = ['Individual'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setUserData();

    fillTheDropDowns();
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

  int currentStep = 1;
  int stepLength = 4;
  late bool complete;

  next() {
    if (currentStep <= stepLength) {
      goTo(currentStep + 1);
    }
  }

  back() {
    if (currentStep > 1) {
      goTo(currentStep - 1);
    }
  }

  goTo(int step) {
    setState(() => currentStep = step);
    if (currentStep > stepLength) {
      setState(() => complete = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                        boxShadow: [
                          new BoxShadow(
                            color: Colors.white.withOpacity(0.5),
                            blurRadius: 1.0,
                          ),
                        ],
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(0),
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0)),
                        color: Colors.red),
                  )),
                  Expanded(
                      child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                        boxShadow: [
                          new BoxShadow(
                            color: Colors.white.withOpacity(0.5),
                            blurRadius: 1.0,
                          ),
                        ],
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(0),
                            topRight: Radius.circular(0),
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0)),
                        color: Colors.white),
                  )),
                  Expanded(
                      child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                        boxShadow: [
                          new BoxShadow(
                            color: Colors.white.withOpacity(0.5),
                            blurRadius: 1.0,
                          ),
                        ],
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(0),
                            topRight: Radius.circular(20),
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0)),
                        color: Colors.green),
                  ))
                ],
              ),
              margin: EdgeInsets.only(top: 1, right: 5, left: 6),
            ),
            Container(
                height: 180,
                margin: EdgeInsets.only(top: 20),
                child: _appbarWidget()),
            Container(
              height: MediaQuery.of(context).size.height,
              margin: EdgeInsets.only(top: 150),
              child: _mainWidget(),
            )
          ],
        ),
      ),
    );
  }

  Widget _appbarWidget() {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          boxShadow: [
            new BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 1.0,
            ),
          ],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(0)),
          color: AppColor.yellow),
      child: Column(
        children: [
          Row(
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
                  icon: Icon(Icons.menu, color: Colors.black))
            ],
          ),
          Sizer.vSpace(context, 0.04),
          Text(
            'Fill An Application',
            textAlign: TextAlign.left,
            textScaleFactor: 1,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }

  Widget _mainWidget() {
    return Container(
        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            boxShadow: [
              new BoxShadow(
                color: Colors.white.withOpacity(0.5),
                blurRadius: 1.0,
              ),
            ],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0)),
            color: Colors.white),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              NumberStepper(
                totalSteps: stepLength,
                width: MediaQuery.of(context).size.width,
                curStep: currentStep,
                stepCompleteColor: Colors.blue,
                currentStepColor: Color(0xffdbecff),
                inactiveColor: Color(0xffbababa),
                lineWidth: 1.5,
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Application Type",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    FormFieldCustom(
                      label: "Application Submitted by",
                      withAsterisk: true,
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                child: DropdownButton(
                  value: dropdownvalue,
                  isExpanded: true,
                  icon: Icon(Icons.keyboard_arrow_down),
                  items: items.map((String items) {
                    return DropdownMenuItem(value: items, child: Text(items));
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue!;
                    });
                  },
                ),
              ),
              const Divider(
                  color: Colors.black,
                height: 1,
                thickness: 0.5,
              ),
              SizedBox(
                height: 5.0,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FormFieldCustom(
                      label: "Location",
                      withAsterisk: true,
                    ),
                  ],
                ),
              ),
              Obx(() {
                return controller2.locationList.value.isNotEmpty
                    ? Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  child: DropdownButtonFormField<String>(
                    onChanged: (String? newValue) {
                      setState(() {});
                    },
                    validator: (value) => value == null
                        ? 'Individual"'
                        : null,
                    items: controller2.locationList.value
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                )
                    : SizedBox();
              }),
              SizedBox(height: 15.0,),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Applicant Details",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    FormFieldCustom(
                      label: "Application Submitted by",
                      withAsterisk: true,
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                child: DropdownButton(
                  value: dropdownvalue,
                  isExpanded: true,
                  icon: Icon(Icons.keyboard_arrow_down),
                  items: items.map((String items) {
                    return DropdownMenuItem(value: items, child: Text(items));
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue!;
                    });
                  },
                ),
              ),

              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "Service Type",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                child: DropdownButton(
                  value: dropdownvalue,
                  isExpanded: true,
                  icon: Icon(Icons.keyboard_arrow_down),
                  items: items.map((String items) {
                    return DropdownMenuItem(value: items, child: Text(items));
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue!;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "Applicant Type",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  child: DropdownButton(
                    value: dropdownvalue,
                    isExpanded: true,
                    icon: Icon(Icons.keyboard_arrow_down),
                    items: items.map((String items) {
                      return DropdownMenuItem(value: items, child: Text(items));
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Applicants First Name',
                  hintText: 'Enter your name',
                  // errorText: "_errorText",
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple, width: 0.5),
                  ),
                  errorBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 0.5),
                  ),
                  focusedErrorBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 0.5),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Applicants Middle Name',
                  hintText: 'Enter your middle name',
                  // errorText: "_errorText",
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple, width: 0.5),
                  ),
                  errorBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 0.5),
                  ),
                  focusedErrorBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 0.5),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Applicants Last Name',
                  hintText: 'Enter your last name',
                  // errorText: "_errorText",
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple, width: 0.5),
                  ),
                  errorBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 0.5),
                  ),
                  focusedErrorBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 0.5),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Date of Birth',
                  hintText: 'DD/MM/YYYY',
                  // errorText: "_errorText",
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple, width: 0.5),
                  ),
                  errorBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 0.5),
                  ),
                  focusedErrorBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 0.5),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  hintText: 'Enter your email address',
                  // errorText: "_errorText",
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple, width: 0.5),
                  ),
                  errorBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 0.5),
                  ),
                  focusedErrorBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 0.5),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "Type of Passport",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  child: DropdownButton(
                    value: dropdownvalue,
                    isExpanded: true,
                    icon: Icon(Icons.keyboard_arrow_down),
                    items: items.map((String items) {
                      return DropdownMenuItem(value: items, child: Text(items));
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Passport Number',
                  hintText: 'Enter your passport number',
                  // errorText: "_errorText",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple, width: 0.5),
                  ),
                  errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 0.5),
                  ),
                  focusedErrorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 0.5),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Passport Issue Place',
                  hintText: 'Enter your passport issue place',
                  // errorText: "_errorText",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple, width: 0.5),
                  ),
                  errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 0.5),
                  ),
                  focusedErrorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 0.5),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Issue Date',
                  hintText: 'DD/MM/YYYY',
                  // errorText: "_errorText",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple, width: 0.5),
                  ),
                  errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 0.5),
                  ),
                  focusedErrorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 0.5),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Expiry Date',
                  hintText: 'DD/MM/YYYY',
                  // errorText: "_errorText",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple, width: 0.5),
                  ),
                  errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 0.5),
                  ),
                  focusedErrorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 0.5),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Service Request',
                  hintText: 'Enter your service request',
                  // errorText: "_errorText",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple, width: 0.5),
                  ),
                  errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 0.5),
                  ),
                  focusedErrorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 0.5),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ListTile(
                title: Row(
                  children: <Widget>[
                    Expanded(
                        child: RaisedButton(
                      onPressed: () {},
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text("Proceed"),
                      color: Colors.green,
                      textColor: Colors.white,
                    )),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: RaisedButton(
                      onPressed: () {
                        clearValues();
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text("Reset"),
                      color: Colors.red,
                      textColor: Colors.white,
                    )),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  void clearValues() {
    setState(() {
      dropdownvalue = "";
      serviceTypeValue = "";
      applicantTypeValue = "";
      typeOfPassportValue = "";
      fieldText.clear();
    });
  }

  void fillTheDropDowns() {
    controller2.visaMaster();
  }
}
