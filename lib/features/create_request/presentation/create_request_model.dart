import 'package:accurate_task/core/helpers/date_model.dart';

class CreateRequestModel {
  String deliverType;
  String requestType;
  DateTimeModel dateTimeModel;
  String payeeName;
  String notes;
  CreateRequestModel({
    required this.deliverType,
    required this.requestType,
    required this.dateTimeModel,
    required this.payeeName,
    required this.notes,
  });
}
