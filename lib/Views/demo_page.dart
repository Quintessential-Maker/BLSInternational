import 'package:app_in/Views/stepper.dart';
import 'package:app_in/custon_common/custom_radio_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../Controllers/Dashboard/home_controller.dart';
import '../Controllers/visa_master_data_controller.dart';
import '../Helper/Server/api_helper.dart';
import '../Helper/app_colors.dart';
import '../Helper/images_helper.dart';
import '../Helper/sizer_helper.dart';
import '../Helper/string_helper.dart';
import '../custon_common/form_field.dart';
import '../wiget/dropdown_textformfield.dart';
import '../wiget/helper_widget.dart';
import '../wiget/simple_textfield_with_heading.dart';


class DemoScreen extends StatefulWidget{
  const DemoScreen({Key? key}) : super(key: key);

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

enum SingingCharacter { Yes, No }

class _DemoScreenState extends State<DemoScreen> {
  SingingCharacter? _smsChar = SingingCharacter.Yes;
  String dropdownValue = 'One';
  String applicationSubmitted = 'Individual';
  String location = 'India';
  dynamic totalAmount = 0.0;
  String nameTitle = 'Mrs';
  String currentNationality = 'select nationality';
  String deliveryMode = 'courier';
  String country = 'Pakistan';
  String visaType = 'Long Stay';
  String visaService = 'Select Visa Service';
  String passportType = 'Diplomatic';
  bool isVisible = true;
  var _formKey = GlobalKey<FormState>();


  TextEditingController firstNameR = new TextEditingController();
  TextEditingController middleName = new TextEditingController();
  TextEditingController lastName = new TextEditingController();
  TextEditingController contactNumberR = new TextEditingController();
  TextEditingController dateOfBirthR = new TextEditingController();
  TextEditingController emailR = new TextEditingController();
  TextEditingController cityApplicant = new TextEditingController();
  TextEditingController stateR = new TextEditingController();
  TextEditingController cityDeliveryR = new TextEditingController();
  TextEditingController pinCodeR = new TextEditingController();
  TextEditingController address1R = new TextEditingController();
  TextEditingController address2R = new TextEditingController();
  TextEditingController nationalityPasportR = new TextEditingController();
  TextEditingController pasportNumberR = new TextEditingController();
  TextEditingController onlineApplicationNumber = new TextEditingController();
  TextEditingController passportIssuePlaceR = new TextEditingController();
  TextEditingController issueDateR = new TextEditingController();
  TextEditingController expireDateR = new TextEditingController();
  TextEditingController countryCodeSMSR = new TextEditingController();
  TextEditingController contactNumberSMSR = new TextEditingController();



  final HomeController controller = Get.put(HomeController());
  final VisaMasterController visaMasterValuesController =
      Get.put(VisaMasterController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setUserData();
    fillTheDropDowns();
    if (visaMasterValuesController.deliveryServiceList.isNotEmpty) {
      // getVASDetails();
      print(visaMasterValuesController.vasServiceF.length.toString());
    }
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

  void _submit() {
    final isValid = _formKey.currentState?.validate();
    if (!isValid!) {
      return;
    }
    _formKey.currentState?.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
            ),
          ],
        ),
      ),
    );
  }

  verticalSpace() {
    return SizedBox(
      height: 10,
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
        padding: EdgeInsets.all(5),
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
              height: 10,
            ),
            Flexible(
              child: SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpace(),
                      verticalSpace(),
                      verticalSpace(),
                      verticalSpace(),
                      HelperWidget.bigHeading("Application Type"),
                      verticalSpace(),
                      verticalSpace(),
                      AppDropdownInput(
                        heading: "Application submitted by",
                        isRequired: true,
                        hintText: "Individual",
                        // options: ["Individual", "Group"],
                        options: [applicationSubmitted],
                        value: applicationSubmitted,
                        onChanged: (String? value) {
                          setState(() {
                            applicationSubmitted = value!;
                            // state.didChange(newValue);
                          });
                        },
                        getLabel: (String value) => value,
                      ),
                      verticalSpace(),
                      Obx(() {
                        return visaMasterValuesController
                                    .locationList.value.length >
                                0
                            ? AppDropdownInput(
                                heading: "Location",
                                isRequired: true,
                                hintText: location,
                                options: visaMasterValuesController
                                    .locationList.value,
                                value: visaMasterValuesController
                                    .locationList.value[0],
                                onChanged: (String? value) {
                                  setState(() {
                                    visaMasterValuesController
                                        .searchVisaLocationId(value);
                                    print(
                                        "pallavi loc ${visaMasterValuesController.locationList.value}");
                                    location = value!;
                                    // state.didChange(newValue);
                                  });
                                },
                                getLabel: (String value) => value,
                              )
                            : SizedBox();
                      }),

                      verticalSpace(),
                      verticalSpace(),
                      HelperWidget.bigHeading("Application Details"),
                      verticalSpace(),
                      verticalSpace(),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: AppDropdownInput(
                              heading: "Title",
                              isRequired: true,
                              hintText: "Mrs",
                              options: ["Mrs", "Mr", "Miss"],
                              value: nameTitle,
                              onChanged: (String? value) {
                                setState(() {
                                  nameTitle = value!;
                                  // state.didChange(newValue);
                                });
                              },
                              getLabel: (String value) => value,
                            ),
                          ),
                          Expanded(
                            flex: 8,
                            child: Container(
                              margin: EdgeInsets.only(left: 10),
                              child: TextFieldWithHeading(
                                textController:  firstNameR,
                                heading: "First Name",
                                isRequired: true,
                              ),
                            ),
                          ),
                        ],
                      ), //pall1
                      verticalSpace(),
                      Row(
                        children: [
                          Expanded(
                            child: TextFieldWithHeading(
                              heading: "Middle Name",
                              textController:  middleName,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextFieldWithHeading(
                              textController:  lastName,
                              heading: "Last Name",
                            ),
                          ),
                        ],
                      ),
                      verticalSpace(),
                      TextFieldWithHeading(
                        textController:  contactNumberR,
                        heading: "Contact Number",
                        isRequired: true,
                        keyboardType: TextInputType.number,
                      ),
                      verticalSpace(),
                      TextFieldWithHeading(
                        textController:  dateOfBirthR,
                        heading: "Date of Birth",
                        isRequired: true,
                        keyboardType: TextInputType.datetime,
                      ),
                      verticalSpace(),
                      TextFieldWithHeading(
                        textController:  emailR,
                        heading: "Email Address",
                        isRequired: true,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      verticalSpace(),
                      TextFieldWithHeading(
                        textController:  cityApplicant,
                        heading: "City",
                      ),
                      verticalSpace(),
                      verticalSpace(),
                      HelperWidget.bigHeading("Mode of Delivery"),
                      verticalSpace(),
                      verticalSpace(),

                      Obx(() {
                        return visaMasterValuesController
                                .deliveryServiceList.value.isNotEmpty
                            ? AppDropdownInput(
                                heading: "Delivery Mode",
                                isRequired: true,
                                hintText: deliveryMode,
                                options: visaMasterValuesController
                                    .deliveryServiceList.value,
                                value: visaMasterValuesController
                                    .deliveryServiceList.value[1],
                                onChanged: (String? value) {
                                  setState(() {
                                    deliveryMode = value!;
                                    // state.didChange(newValue);
                                  });
                                },
                                getLabel: (String value) => value,
                              )
                            : SizedBox();
                      }),
                      //pall2
                      verticalSpace(),
                      Row(
                        children: [
                          Expanded(
                            child: AppDropdownInput(
                              heading: "Country",
                              isRequired: true,
                              hintText: "Pakistan",
                              // options: ["Individual", "Group"],
                              options: [country],
                              value: country,
                              onChanged: (String? value) {
                                setState(() {
                                  country = value!;
                                  // state.didChange(newValue);
                                });
                              },
                              getLabel: (String value) => value,
                            ),
                          ), //pall3
                          Expanded(
                              child: Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: TextFieldWithHeading(
                                    textController:  stateR,
                                    heading: "State",
                                    isRequired: true,
                                  )))
                        ],
                      ),
                      verticalSpace(),
                      Row(
                        children: [
                          Expanded(
                            child: TextFieldWithHeading(
                              textController:  cityDeliveryR,
                              heading: "City",
                              isRequired: true,
                            ),
                          ),
                          Expanded(
                            child: TextFieldWithHeading(
                              textController:  pinCodeR,
                              heading: "Postal Code",
                              isRequired: true,
                            ),
                          ),
                        ],
                      ),
                      verticalSpace(),
                      TextFieldWithHeading(
                        textController:  address1R,
                        heading: "Address 1",
                        isRequired: true,
                      ),
                      verticalSpace(),
                      TextFieldWithHeading(
                        textController:  address2R,
                        heading: "Address 2",
                        isRequired: true,
                      ),
                      verticalSpace(),
                      verticalSpace(),
                      HelperWidget.bigHeading("Passport Details"),
                      verticalSpace(),
                      verticalSpace(),
                      TextFieldWithHeading(
                        textController:  nationalityPasportR,
                        heading: "Nationality",
                        isRequired: true,
                      ),
                      verticalSpace(),
                      Obx(() {
                        return visaMasterValuesController
                                .pasportTypeList.value.isNotEmpty
                            ? AppDropdownInput(
                                heading: "Passport Type",
                                isRequired: true,
                                hintText: passportType,
                                options: visaMasterValuesController
                                    .pasportTypeList.value,
                                value: visaMasterValuesController
                                    .pasportTypeList.value[1],
                                onChanged: (String? value) {
                                  setState(() {
                                    passportType = value!;
                                    // state.didChange(newValue);
                                  });
                                },
                                getLabel: (String value) => value,
                              )
                            : SizedBox();
                      }),
                      //pall2
                      verticalSpace(),
                      TextFieldWithHeading(
                        textController:  pasportNumberR,
                        heading: "Passport No.",
                        isRequired: true,
                      ),
                      verticalSpace(),
                      TextFieldWithHeading(
                        textController:  onlineApplicationNumber,
                        heading: "Online Application No",
                      ),
                      verticalSpace(),
                      TextFieldWithHeading(
                        textController:  passportIssuePlaceR,
                        heading: "Passport Issue Place",
                        isRequired: true,
                      ),
                      verticalSpace(),
                      TextFieldWithHeading(
                        textController:  issueDateR,
                        heading: "Issue Date",
                        isRequired: true,
                        keyboardType: TextInputType.datetime,
                      ),
                      verticalSpace(),
                      TextFieldWithHeading(
                        textController:  expireDateR,
                        heading: "Expiry Date",
                        isRequired: true,
                        keyboardType: TextInputType.datetime,
                      ),
                      verticalSpace(),
                      verticalSpace(),
                      HelperWidget.bigHeading("Visa Type"),
                      verticalSpace(),
                      verticalSpace(),

                      Obx(() {
                        return visaMasterValuesController
                                .nationalityList.value.isNotEmpty
                            ? AppDropdownInput(
                                heading: "Current Nationality",
                                isRequired: true,
                                hintText: currentNationality,
                                options: visaMasterValuesController
                                    .nationalityList.value,
                                value: visaMasterValuesController
                                    .nationalityList.value[1],
                                onChanged: (String? value) {
                                  setState(() {
                                    currentNationality = value!;
                                    // state.didChange(newValue);
                                  });
                                },
                                getLabel: (String value) => value,
                              )
                            : SizedBox();
                      }),

                      verticalSpace(),
                      Obx(() {
                        return visaMasterValuesController
                                .serviceTypeList.value.isNotEmpty
                            ? AppDropdownInput(
                                heading: "Visa Service",
                                isRequired: true,
                                hintText: visaService,
                                options: visaMasterValuesController
                                    .serviceTypeList.value,
                                value: visaMasterValuesController
                                    .serviceTypeList.value[1],
                                onChanged: (String? value) {
                                  setState(() {
                                    visaService = value!;
                                    visaMasterValuesController
                                        .searchVisaServiceId(value);
                                    // state.didChange(newValue);
                                  });
                                },
                                getLabel: (String value) => value,
                              )
                            : SizedBox();
                      }),

                      //pp2
                      verticalSpace(),
                      Obx(() {
                        return visaMasterValuesController
                                .allVisaTypeList.value.isNotEmpty
                            ? AppDropdownInput(
                                heading: "Visa Type",
                                isRequired: true,
                                hintText: visaType,
                                options: visaMasterValuesController
                                    .allVisaTypeList.value,
                                value: visaMasterValuesController
                                    .allVisaTypeList.value[1],
                                onChanged: (String? value) {
                                  setState(() {
                                    visaType = value!;
                                    visaMasterValuesController
                                        .searchVisaTypeId(value);
                                    // state.didChange(newValue);
                                  });
                                },
                                getLabel: (String value) => value,
                              )
                            : SizedBox();
                      }),

                      //pp
                      verticalSpace(),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FormFieldCustom(
                              label: "SMS",
                              withAsterisk: true,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: ListTile(
                                    title: const Text('Yes'),
                                    leading: Radio<SingingCharacter>(
                                      value: SingingCharacter.Yes,
                                      groupValue: _smsChar,
                                      onChanged: (SingingCharacter? value) {
                                        setState(() {
                                          _smsChar = value;
                                          isVisible = true;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ListTile(
                                    title: const Text('No'),
                                    leading: Radio<SingingCharacter>(
                                      value: SingingCharacter.No,
                                      groupValue: _smsChar,
                                      onChanged: (SingingCharacter? value) {
                                        setState(() {
                                          _smsChar = value;
                                          isVisible = false;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      verticalSpace(),
                      Visibility(visible: isVisible,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: TextFieldWithHeading(
                                textController:  countryCodeSMSR,
                                heading: "Country Code",
                                isRequired: true,
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: Container(
                                margin: EdgeInsets.only(left: 10),
                                child: TextFieldWithHeading(
                                  textController:  contactNumberSMSR,
                                  heading: "Contact Number",
                                  isRequired: true,
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      verticalSpace(),
                      verticalSpace(),
                      HelperWidget.bigHeading("Other VAS Services & Fee Calculation"),
                      verticalSpace(),
                      verticalSpace(),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Select',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    'VAS Service',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    'Price',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    'Quantity',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    'Cost',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 1,
                              color: Colors.grey.shade300,
                            ),
                            Obx(() {
                              return visaMasterValuesController
                                      .vasServiceFList.isNotEmpty
                                  ? ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: visaMasterValuesController
                                          .vasServiceFList.value.length,
                                      itemBuilder: (context, index) {
                                        dynamic tQ = double.parse(
                                                visaMasterValuesController
                                                    .vasServiceFList
                                                    .value[index]
                                                    .serviceFee
                                                    .toString()) *
                                            double.parse(
                                                visaMasterValuesController
                                                    .vasServiceFList
                                                    .value[index]
                                                    .serviceQty
                                                    .toString());

                                        dynamic tQF = tQ.toStringAsFixed(2);

                                        totalAmount =
                                            totalAmount + double.parse(tQF);

                                        return Column(mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(vertical: 10),
                                              child: Row(
                                                // mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                                                children: <Widget>[
                                                  Container(
                                                    // width: MediaQuery.of(context).size.width * 0.18,
                                                    child: Checkbox(
                                                      onChanged: (value) {
                                                        setState(() {
                                                          if (visaMasterValuesController
                                                                  .vasServiceFList
                                                                  .value[index]
                                                                  .checkBox ==
                                                              false) {
                                                            visaMasterValuesController
                                                                .vasServiceFList
                                                                .value[index]
                                                                .checkBox = true;
                                                            visaMasterValuesController
                                                                .vasServiceSelectedList
                                                                .value
                                                                .add(visaMasterValuesController
                                                                    .vasServiceFList
                                                                    .value[index]);
                                                          } else {
                                                            visaMasterValuesController
                                                                .vasServiceSelectedList
                                                                .value
                                                                .remove(visaMasterValuesController
                                                                    .vasServiceFList
                                                                    .value[index]);
                                                            visaMasterValuesController
                                                                .vasServiceFList
                                                                .value[index]
                                                                .checkBox = false;
                                                          }
                                                        });
                                                      },
                                                      value:
                                                          visaMasterValuesController
                                                              .vasServiceFList
                                                              .value[index]
                                                              .checkBox,
                                                    ),
                                                  ),
                                                  Container(
                                                    // width: MediaQuery.of(context).size.width * 0.18,
                                                    child: Text(
                                                      visaMasterValuesController
                                                          .vasServiceFList
                                                          .value[index]
                                                          .serviceName
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                  Container(
                                                    // width: MediaQuery.of(context).size.width * 0.18,
                                                    child: Text(
                                                      visaMasterValuesController
                                                          .vasServiceFList
                                                          .value[index]
                                                          .serviceFee
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                  Container(
                                                    // width: MediaQuery.of(context).size.width * 0.18,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors
                                                                .grey.shade300,
                                                            width: 1)),
                                                    padding: EdgeInsets.all(5),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                          width: 4,
                                                        ),
                                                        Text(
                                                          visaMasterValuesController
                                                              .vasServiceFList
                                                              .value[index]
                                                              .serviceQty
                                                              .toString(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        Icon(Icons
                                                            .arrow_drop_down)
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    // width: MediaQuery.of(context).size.width * 0.18,
                                                    child: Text(
                                                      tQF.toString(),
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: 1,
                                              color: Colors.grey.shade300,
                                            ),
                                          ],
                                        );
                                      })
                                  : SizedBox();
                            }),
                          ],
                        ),
                      ),
                      verticalSpace(),

                      Obx(() {
                        return visaMasterValuesController
                                .countMount.value.isNotEmpty
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  HelperWidget.normalHeading("Vas Total"),
                                  HelperWidget.normalHeading(
                                    visaMasterValuesController.countMount.value
                                        .toString(),
                                  ),
                                ],
                              )
                            : SizedBox();
                      }),

                      verticalSpace(),
                      verticalSpace(),
                      HelperWidget.bigHeading("Visa Charges"),
                      verticalSpace(),
                      verticalSpace(),
                      Obx(
                        () {
                          return visaMasterValuesController
                                  .visaFess.value.isNotEmpty
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    HelperWidget.normalHeading("Visa Fee"),
                                    HelperWidget.normalHeading(
                                        visaMasterValuesController
                                            .visaFess.value),
                                  ],
                                )
                              : SizedBox();
                        },
                      ),
                      verticalSpace(),
                      Obx(
                        () {
                          return visaMasterValuesController
                                  .visaFess.value.isNotEmpty
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    HelperWidget.normalHeading(
                                        "BLS Service Fee"),
                                    HelperWidget.normalHeading(
                                        visaMasterValuesController
                                            .blsFess.value),
                                  ],
                                )
                              : SizedBox();
                        },
                      ),
                      verticalSpace(),
                      Obx(
                        () {
                          return visaMasterValuesController
                                  .totalVISA.value.isNotEmpty
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    HelperWidget.normalHeading("Visa Total"),
                                    HelperWidget.normalHeading(
                                        visaMasterValuesController
                                            .totalVISA.value),
                                  ],
                                )
                              : SizedBox();
                        },
                      ),
                      verticalSpace(),
                      verticalSpace(),
                      Row(
                        children: [
                          HelperWidget.bigHeading("Total Amount"),
                          Spacer(),
                          HelperWidget.bigHeading(""),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.red),
                            alignment: Alignment.center,
                            child: Text(
                              "Reset",
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                              child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "Proceed",
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                        ],
                      ),
                      verticalSpace(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  void fillTheDropDowns() async {
    visaMasterValuesController.visaMaster();
  }
void valuesss(){
  applicationSubmitted;
  location;
nameTitle;
firstNameR.text;
middleName.text;
lastName.text;
contactNumberR.text;
dateOfBirthR.text;
emailR.text;
cityApplicant.text;
deliveryMode;
country;
stateR.text;
cityDeliveryR.text;
pinCodeR.text;
address1R.text;
address2R.text;
nationalityPasportR.text;
passportType;
pasportNumberR.text;
onlineApplicationNumber.text;
passportIssuePlaceR.text;
issueDateR.text;
expireDateR.text;
currentNationality;
visaService;
  visaType;
  _smsChar;
  countryCodeSMSR.text;
  contactNumberSMSR.text;

}
}
