import 'package:accurate_task/core/helpers/date_model.dart';
import 'package:accurate_task/features/create_request/helpers/strigns_constants.dart';

class GraphqlRequestModel {
  DeliveryType deliverType;
  TypeCode requestType;
  DateTimeModel dateTimeModel;
  String payeeName;
  String notes;
  GraphqlRequestModel({
    required this.deliverType,
    required this.requestType,
    required this.dateTimeModel,
    required this.payeeName,
    required this.notes,
  });
  Map<String, dynamic> toGQLRequest() {
    return {
      "input": {
        "payeeName": payeeName.trim(),
        "typeCode": requestType.toRequest().trim(),
        "customerId": 5,
        "branchId": 1,
        "date": dateTimeModel.toString().trim(),
        "notes": notes,
        "deliveryTypeCode": deliverType.toRequest().trim()
      }
    };
  }
}

enum TypeCode {
  PMT,
  RTRN,
  MTRL,
}

extension ToStringConverter on TypeCode {
  String toRequest() {
    switch (this) {
      case TypeCode.PMT:
        return "PMT";
      case TypeCode.RTRN:
        return "RTRN";
      case TypeCode.MTRL:
        return "MTRL";
      default:
        throw Exception("error while converting");
    }
  }
}

enum DeliveryType {
  OFFICE,
  DELIVERYAGENT,
}

extension toStringConverter on DeliveryType {
  String toRequest() {
    switch (this) {
      case DeliveryType.DELIVERYAGENT:
        return "DELIVERYAGENT";
      case DeliveryType.OFFICE:
        return "OFFICE";
      default:
        throw Exception("error while converting");
    }
  }
}

DeliveryType? convertToDeliveryTypeEnum(String value) {
  switch (value) {
    case DeliveryTypeStrings.OFFICE:
      return DeliveryType.OFFICE;
    case DeliveryTypeStrings.DELIVERYAGENT:
      return DeliveryType.DELIVERYAGENT;
    default:
      throw Exception("Unknown DeliveryType string: $value");
  }
}

// Function to convert string to TypeCode enum
TypeCode? convertToTypeCodeEnum(String value) {
  switch (value) {
    case TypeCodeStrings.PMT:
      return TypeCode.PMT;
    case TypeCodeStrings.RTRN:
      return TypeCode.RTRN;
    case TypeCodeStrings.MTRL:
      return TypeCode.MTRL;
    default:
      throw Exception("Unknown TypeCode string: $value");
  }
}
