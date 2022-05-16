import 'dart:convert';

import 'package:app_in/Controllers/base_controller.dart';
import 'package:app_in/Helper/Server/api_helper.dart';
import 'package:app_in/Helper/string_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

import '../Helper/loading_helper.dart';
import '../Models/visa_master_data_response.dart';

class VisaMasterController extends BaseController {
  var serviceTypeList = List<String>.empty(growable: true).obs;

  // var applicantTypeList = List<String>.empty(growable: true).obs;
  var pasportTypeList = List<String>.empty(growable: true).obs;
  dynamic dataDecode = "";
  RxString refreshList = "12".obs;

  RxString locationId = "12".obs;
  RxString serviceId = "12".obs;
  RxString nationalityId = "12".obs;
  RxString visaTypeId = "12".obs;
  RxString pasportNationalityId = "12".obs;

  RxString countMount = "".obs;
  RxString visaFess = "".obs;
  RxString blsFess = "".obs;
  RxString totalVISA = ''.obs;
  RxString finalVisaValue = ''.obs;
  dynamic totalAmount = 0.0.obs;

  var locationList = List<String>.empty(growable: true).obs;
  var nationalityList = List<String>.empty(growable: true).obs;
  var deliveryServiceList = List<String>.empty(growable: true).obs;
  var allVisaTypeList = List<String>.empty(growable: true).obs;
  var listOfVASValues = List<String>.empty(growable: true).obs;
  var vasServiceFList = List<AllVasService>.empty(growable: true).obs;
  var vasServiceSelectedList = List<AllVasService>.empty(growable: true).obs;

  late List<AllVasService> vasServiceF = [];
  late AllVasService vasService;

  Future visaMaster() async {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Loader.show();
    });

    dynamic url =
        await Api.getData(Const.visaMasterDataService).then((value) => {
              print("url $value"),
              getMasterData(value),
            });
  }

  getMasterData(String value) async {
    dynamic response = await server.digestAuthGet(
      url: value,
      bodyData: {},
    );
    Loader.hide();
    dataDecode = json.decode(response.body);
    print("data response ${dataDecode['status'].toString()}");
    print("data response ${dataDecode.toString()}");
    if (dataDecode['status'].toString() == "true") {
      print("data response ${dataDecode.toString()}");

      serviceTypeList.clear();
      // applicantTypeList.clear();
      vasServiceSelectedList.clear();
      pasportTypeList.clear();
      locationList.clear();
      nationalityList.clear();
      deliveryServiceList.clear();
      allVisaTypeList.clear();
      listOfVASValues.clear();

      for (int i = 0; i < dataDecode['data']['allVisaService'].length; i++) {
        print(
            "data allVisaService ${dataDecode['data']['allVisaService'][i]['name']}");
        serviceTypeList.add(dataDecode['data']['allVisaService'][i]['name']);
      }
      /*for (int i = 0; i < dataDecode['data']['allNationality'].length; i++) {
        // print("data allVisaService ${dataDecode['data']['allNationality'][i]['name']}");
        applicantTypeList.add(dataDecode['data']['allNationality'][i]['name']);
      }*/
      for (int i = 0; i < dataDecode['data']['allLocation'].length; i++) {
        print(
            "data allLocation ${dataDecode['data']['allLocation'][i]['name']}");
        locationList.add(dataDecode['data']['allLocation'][i]['name']);
      }
      for (int i = 0; i < dataDecode['data']['allNationality'].length; i++) {
        // print("data allNationality ${dataDecode['data']['allNationality'][i]['name']}");
        nationalityList.add(dataDecode['data']['allNationality'][i]['name']);
      }
      for (int i = 0; i < dataDecode['data']['allVasService'].length; i++) {
        // print("data allVasService ${dataDecode['data']['allVasService'][i]['service_name']}");
        deliveryServiceList
            .add(dataDecode['data']['allVasService'][i]['service_name']);
        listOfVASValues
            .add(dataDecode['data']['allVasService'][i]['service_fee']);
      }
      for (int i = 0; i < dataDecode['data']['allVisa'].length; i++) {
        print("data allVisa ${dataDecode['data']['allVisa'][i]['visa_type']}");
        allVisaTypeList.add(dataDecode['data']['allVisa'][i]['visa_type']);
      }
      for (int i = 0; i < dataDecode['data']['allPassportType'].length; i++) {
        print(
            "data allPassportType ${dataDecode['data']['allPassportType'][i]['name']}");
        pasportTypeList.add(dataDecode['data']['allPassportType'][i]['name']);
      }

      List vasList = dataDecode['data']['allVasService'];
      var visaDecodeList =
          vasList.map((m) => new AllVasService.fromJson(m)).toList();
      vasServiceFList.addAll(visaDecodeList);
      if (vasServiceFList.length > 0) {
        countMount.value = await totalCalculatedValue();
      }
      //  getVasDetail(dataDecode['data']['allVasService']);
    } else {
      Get.snackbar('Alert', dataDecode['message'],
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void getVasDetail(value) {
    for (var singleValue in value) {
      vasService = AllVasService(
          id: singleValue["id"],
          countryId: singleValue["countryId"],
          serviceName: singleValue["serviceName"],
          serviceQty: singleValue["serviceQty"],
          serviceFee: singleValue["serviceFee"],
          usdPrice: singleValue["usdPrice"],
          status: singleValue["status"],
          createdOn: singleValue["createdOn"],
          createdBy: singleValue["createdBy"],
          createdByIp: singleValue["createdByIp"],
          createdByBrowser: singleValue["createdByBrowser"],
          modifiedOn: singleValue["modifiedOn"],
          modifiedBy: singleValue["modifiedBy"],
          modifiedByIp: singleValue["modifiedByIp"],
          modifiedByBrowser: singleValue["modifiedByBrowser"]);
      vasServiceF.add(vasService);
    }
    print('lklk ${vasServiceF.length}');
  }

  Future visaPrice() async {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Loader.show();
    });

    var map = <String, String>{};

    map['visa_service_id'] = serviceId.value.toString();
    map['visa_type_id'] = visaTypeId.value.toString();
    dynamic url =
        await Api.getData(Const.visaPriceCombilationService).then((value) => {
              print("url $map"),
              getVisaPrice(value, map),
            });
  }

  getVisaPrice(value, map) async {
    dynamic response = await server.digestAuth(
      url: value,
      bodyData: map,
    );
    Loader.hide();
    dynamic dataDecode = json.decode(response.body);
    print("data response ${dataDecode['status'].toString()}");
    print("data response ${dataDecode.toString()}");
    if (dataDecode['status'].toString() == "true") {
      print("data blsFess ${dataDecode.toString()}");
      blsFess.value = dataDecode['data']['bls_price'];
      visaFess.value = dataDecode['data']['visa_price'];
      dynamic vv = 0.0, aa = 0.0, finalValu = 0.0,finalValu1 = 0.0;
      vv = double.parse(blsFess.value) +
          double.parse(visaFess.value) +
          totalAmount.value;
      aa = vv.toStringAsFixed(2);
      totalVISA.value = aa.toString();
      print("totalVISA ${totalVISA.value}");

      finalValu = vv + double.parse(countMount.value);
      finalValu1 = finalValu.toStringAsFixed(2);
      finalVisaValue.value = finalValu1.toString();
      print("finalVisaValue ${finalVisaValue.value}");

    } else {
      Get.snackbar('Alert', dataDecode['message'],
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<String> totalCalculatedValue() async {
    dynamic tQ = 0.0, tQF = 0.0;
    for (int i = 0; i < vasServiceFList.value.length; i++) {
      tQ = double.parse(vasServiceFList.value[i].serviceFee.toString()) *
          double.parse(vasServiceFList.value[i].serviceQty.toString());
      tQF = tQ.toStringAsFixed(2);
      totalAmount = totalAmount + double.parse(tQF);

      print('totalAmount: ${totalAmount}');
    }

    return totalAmount.toString();
  }

  searchVisaLocationId(value) {
    int trendIndex = locationList.value.indexWhere((f) => f == value);
    locationId.value = dataDecode['data']['allLocation'][trendIndex]['id'];
    print(trendIndex);
  }

  searchVisaServiceId(value) {
    int trendIndex = serviceTypeList.value.indexWhere((f) => f == value);
    serviceId.value = dataDecode['data']['allVisaService'][trendIndex]['id'];
    print(trendIndex);
  }

  searchVisaTypeId(value) {
    int trendIndex = allVisaTypeList.value.indexWhere((f) => f == value);
    visaTypeId.value = dataDecode['data']['allVisa'][trendIndex]['id'];
    if (visaTypeId.value.isNotEmpty) {
      visaPrice();
    }
    print(trendIndex);
  }

  searchNationalityId(value) {
    int trendIndex = nationalityList.value.indexWhere((f) => f == value);
    nationalityId.value =
        dataDecode['data']['allNationality'][trendIndex]['id'];
    pasportNationalityId.value =
        dataDecode['data']['allNationality'][trendIndex]['id'];
    print(trendIndex);
  }
}
