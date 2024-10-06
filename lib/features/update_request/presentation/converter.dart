import 'package:accurate_task/features/create_request/helpers/strigns_constants.dart';

String deliveryConveterStringString(String input) {
  switch (input) {
    case "OFFICE":
      return DeliveryTypeStrings.OFFICE;
    case "DELIVERYAGENT":
      return DeliveryTypeStrings.DELIVERYAGENT;
    default:
      throw Exception("error while conveting strings");
  }
}

String typeConverterStringString(String input) {
  switch (input) {
    case "PMNT":
      return TypeCodeStrings.PMT;
    case "RTRN":
      return TypeCodeStrings.RTRN;
    case "MTRL":
      return TypeCodeStrings.RTRN;
    default:
      throw Exception("error while conveting strings");
  }
}
