import 'package:accurate_task/core/common_widget/my_inputField.dart';
import 'package:accurate_task/core/helpers/date_model.dart';
import 'package:accurate_task/core/helpers/input_fields.dart';
import 'package:flutter/material.dart';

class MyDatePicker extends StatelessWidget {
  const MyDatePicker(
      {super.key,
      required this.dateTimeModel,
      required this.formKey,
      required this.fieldInput});
  final DateTimeModel dateTimeModel;
  final GlobalKey<FormState> formKey;
  final TextEditingController fieldInput;

  @override
  Widget build(BuildContext context) {
    return GeneralInputFiled(
        suffixIcon: Icon(Icons.date_range),
        readOnly: true,
        onTap: () {
          showDatePicker(
                  confirmText: "next",
                  context: context,
                  firstDate: DateTime.now(),
                  lastDate:
                      DateTime.now().copyWith(year: DateTime.now().year + 1))
              .then((value) {
            if (value != null) {
              dateTimeModel.year = value.year;
              dateTimeModel.mon = value.month;
              dateTimeModel.day = value.day;
              showTimePicker(
                      context: context,
                      initialTime: TimeOfDay(
                          hour: DateTime.now().hour,
                          minute: DateTime.now().minute))
                  .then((time) {
                if (time != null) {
                  dateTimeModel.hour = time.hour;
                  dateTimeModel.minuet = time.minute;
                  fieldInput.text = dateTimeModel.toString();
                }
              });
            }
          });
        },
        fieldFormKey: formKey,
        fieldInput: fieldInput,
        label: "Pick Date",
        validateMessageFunction: InputValidator.validateRegularField);
  }
}
