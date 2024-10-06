import 'package:accurate_task/core/helpers/date_model.dart';

class UpdateRequestModel {
  int id;
  String deliverType;
  String requestType;
  DateTimeModel dateTimeModel;
  String payeeName;
  String notes;
  UpdateRequestModel({
    required this.id,
    required this.deliverType,
    required this.requestType,
    required this.dateTimeModel,
    required this.payeeName,
    required this.notes,
  });
}
