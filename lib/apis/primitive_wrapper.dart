import '../utils/constant.dart';
import 'api_request_type.dart';

class ReferenceWrapper {
  bool shouldIParse = false;
  ApiRequestType requestType = ApiRequestType.mapStringDynamic;
  var _requestParam;
  get requestParam {
    return _requestParam;
  }

  set requestParam(requestParam) {
    _requestParam = requestParam;
    responseParam = null;
    shouldIParse = false;
    URLType = DiffURLType.storedProcedure;
    requestType = ApiRequestType.mapStringDynamic;
  }

  var responseParam;
  bool isError = false;
  DiffURLType? URLType;
  bool isLoading = true;
  get isInternet async {
    var status = await Constants.isInternetAvailable();
    return status;
  }

  ReferenceWrapper(this._requestParam, this.responseParam);
}

enum DiffURLType { callAuth, fullUrl, storedProcedure, pushNotification }

class Param {
  Param({
    this.name,
    this.value,
  });

  String? name;
  String? value;

  factory Param.fromJson(Map<String, dynamic> json) => Param(
        name: json["Name"],
        value: json["Value"],
      );

  Map<String, dynamic> toJson() => {
        "Name": name,
        "Value": value,
      };
}
