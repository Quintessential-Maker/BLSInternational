class VisaMasterData {
  Data? data;
  String? status;
  String? message;

  VisaMasterData({this.data, this.status, this.message});

  VisaMasterData.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}

class Data {
  List<AllLocation>? allLocation;
  List<AllPassportType>? allPassportType;
  List<AllNationality>? allNationality;
  List<AllVisaService>? allVisaService;
  List<AllVisa>? allVisa;
  List<AllVasService>? allVasService;

  Data(
      {this.allLocation,
      this.allPassportType,
      this.allNationality,
      this.allVisaService,
      this.allVisa,
      this.allVasService});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['allLocation'] != null) {
      allLocation = <AllLocation>[];
      json['allLocation'].forEach((v) {
        allLocation!.add(new AllLocation.fromJson(v));
      });
    }
    if (json['allPassportType'] != null) {
      allPassportType = <AllPassportType>[];
      json['allPassportType'].forEach((v) {
        allPassportType!.add(new AllPassportType.fromJson(v));
      });
    }
    if (json['allNationality'] != null) {
      allNationality = <AllNationality>[];
      json['allNationality'].forEach((v) {
        allNationality!.add(new AllNationality.fromJson(v));
      });
    }
    if (json['allVisaService'] != null) {
      allVisaService = <AllVisaService>[];
      json['allVisaService'].forEach((v) {
        allVisaService!.add(new AllVisaService.fromJson(v));
      });
    }
    if (json['allVisa'] != null) {
      allVisa = <AllVisa>[];
      json['allVisa'].forEach((v) {
        allVisa!.add(new AllVisa.fromJson(v));
      });
    }
    if (json['allVasService'] != null) {
      allVasService = <AllVasService>[];
      json['allVasService'].forEach((v) {
        allVasService!.add(new AllVasService.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.allLocation != null) {
      data['allLocation'] = this.allLocation!.map((v) => v.toJson()).toList();
    }
    if (this.allPassportType != null) {
      data['allPassportType'] =
          this.allPassportType!.map((v) => v.toJson()).toList();
    }
    if (this.allNationality != null) {
      data['allNationality'] =
          this.allNationality!.map((v) => v.toJson()).toList();
    }
    if (this.allVisaService != null) {
      data['allVisaService'] =
          this.allVisaService!.map((v) => v.toJson()).toList();
    }
    if (this.allVisa != null) {
      data['allVisa'] = this.allVisa!.map((v) => v.toJson()).toList();
    }
    if (this.allVasService != null) {
      data['allVasService'] =
          this.allVasService!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllLocation {
  String? id;
  String? name;
  String? state;
  String? jurisdiction;
  String? code;
  String? serno;
  String? currencyName;
  String? countryId;
  String? telCode;
  String? timezone;
  String? gmt;
  String? gstin;
  String? address;
  String? color;
  String? status;
  String? createdOn;
  String? createdBy;
  String? createdByIp;
  String? createdByBrowser;
  String? modifiedOn;
  String? modifiedBy;
  String? modifiedByIp;
  String? modifiedByBrowser;

  AllLocation(
      {this.id,
      this.name,
      this.state,
      this.jurisdiction,
      this.code,
      this.serno,
      this.currencyName,
      this.countryId,
      this.telCode,
      this.timezone,
      this.gmt,
      this.gstin,
      this.address,
      this.color,
      this.status,
      this.createdOn,
      this.createdBy,
      this.createdByIp,
      this.createdByBrowser,
      this.modifiedOn,
      this.modifiedBy,
      this.modifiedByIp,
      this.modifiedByBrowser});

  AllLocation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    state = json['state'];
    jurisdiction = json['jurisdiction'];
    code = json['code'];
    serno = json['serno'];
    currencyName = json['currency_name'];
    countryId = json['country_id'];
    telCode = json['tel_code'];
    timezone = json['timezone'];
    gmt = json['gmt'];
    gstin = json['gstin'];
    address = json['address'];
    color = json['color'];
    status = json['status'];
    createdOn = json['created_on'];
    createdBy = json['created_by'];
    createdByIp = json['created_by_ip'];
    createdByBrowser = json['created_by_browser'];
    modifiedOn = json['modified_on'];
    modifiedBy = json['modified_by'];
    modifiedByIp = json['modified_by_ip'];
    modifiedByBrowser = json['modified_by_browser'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['state'] = this.state;
    data['jurisdiction'] = this.jurisdiction;
    data['code'] = this.code;
    data['serno'] = this.serno;
    data['currency_name'] = this.currencyName;
    data['country_id'] = this.countryId;
    data['tel_code'] = this.telCode;
    data['timezone'] = this.timezone;
    data['gmt'] = this.gmt;
    data['gstin'] = this.gstin;
    data['address'] = this.address;
    data['color'] = this.color;
    data['status'] = this.status;
    data['created_on'] = this.createdOn;
    data['created_by'] = this.createdBy;
    data['created_by_ip'] = this.createdByIp;
    data['created_by_browser'] = this.createdByBrowser;
    data['modified_on'] = this.modifiedOn;
    data['modified_by'] = this.modifiedBy;
    data['modified_by_ip'] = this.modifiedByIp;
    data['modified_by_browser'] = this.modifiedByBrowser;
    return data;
  }
}

class AllPassportType {
  String? id;
  String? name;
  String? status;

  AllPassportType({this.id, this.name, this.status});

  AllPassportType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    return data;
  }
}

class AllNationality {
  String? id;
  String? name;
  String? phonecode;
  String? numcode;
  String? iso;
  String? iso3;
  String? status;

  AllNationality(
      {this.id,
      this.name,
      this.phonecode,
      this.numcode,
      this.iso,
      this.iso3,
      this.status});

  AllNationality.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phonecode = json['phonecode'];
    numcode = json['numcode'];
    iso = json['iso'];
    iso3 = json['iso3'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phonecode'] = this.phonecode;
    data['numcode'] = this.numcode;
    data['iso'] = this.iso;
    data['iso3'] = this.iso3;
    data['status'] = this.status;
    return data;
  }
}

class AllVisa {
  String? id;
  String? visaType;
  String? status;

  AllVisa({this.id, this.visaType, this.status});

  AllVisa.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    visaType = json['visa_type'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['visa_type'] = this.visaType;
    data['status'] = this.status;
    return data;
  }
}

class AllVisaService {
  String? id;
  String? name;
  String? status;

  AllVisaService({this.id, this.name, this.status});

  AllVisaService.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    return data;
  }
}

class AllVasService {
  String? id;
  String? countryId;
  String? serviceName;
  String? serviceQty;
  String? serviceFee;
  String? usdPrice;
  String? status;
  bool? checkBox;
  String? createdOn;
  String? createdBy;
  String? createdByIp;
  String? createdByBrowser;
  String? modifiedOn;
  String? modifiedBy;
  String? modifiedByIp;
  String? modifiedByBrowser;

  AllVasService(
      {this.id,
      this.countryId,
      this.serviceName,
      this.serviceQty,
      this.serviceFee,
      this.usdPrice,
        this.checkBox,
      this.status,
      this.createdOn,
      this.createdBy,
      this.createdByIp,
      this.createdByBrowser,
      this.modifiedOn,
      this.modifiedBy,
      this.modifiedByIp,
      this.modifiedByBrowser});

  AllVasService.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryId = json['country_id'];
    serviceName = json['service_name'];
    serviceQty = json['service_qty'];
    serviceFee = json['service_fee'];
    usdPrice = json['usd_price'];
    status = json['status'];
    checkBox=json.containsKey("checkBox")?false:true;
    createdOn = json['created_on'];
    createdBy = json['created_by'];
    createdByIp = json['created_by_ip'];
    createdByBrowser = json['created_by_browser'];
    modifiedOn = json['modified_on'];
    modifiedBy = json['modified_by'];
    modifiedByIp = json['modified_by_ip'];
    modifiedByBrowser = json['modified_by_browser'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['country_id'] = this.countryId;
    data['service_name'] = this.serviceName;
    data['service_qty'] = this.serviceQty;
    data['service_fee'] = this.serviceFee;
    data['checkBox'] = this.checkBox;
    data['usd_price'] = this.usdPrice;
    data['status'] = this.status;
    data['created_on'] = this.createdOn;
    data['created_by'] = this.createdBy;
    data['created_by_ip'] = this.createdByIp;
    data['created_by_browser'] = this.createdByBrowser;
    data['modified_on'] = this.modifiedOn;
    data['modified_by'] = this.modifiedBy;
    data['modified_by_ip'] = this.modifiedByIp;
    data['modified_by_browser'] = this.modifiedByBrowser;
    return data;
  }
}
