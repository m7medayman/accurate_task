import 'package:accurate_task/core/common_widget/my_inputField.dart';
import 'package:accurate_task/core/common_widget/separator.dart';
import 'package:accurate_task/core/helpers/input_fields.dart';
import 'package:flutter/material.dart';

class DoubleTimePicker extends StatefulWidget {
  final GlobalKey<FormState> firstFormKey;
  final TextEditingController firstFieldInput;
  final GlobalKey<FormState> secondFormKey;
  final TextEditingController secondFieldInput;
  final String firstLabel;
  final String secondLabel;
  final double screenHeight;
  const DoubleTimePicker({
    Key? key,
    required this.firstFormKey,
    required this.firstFieldInput,
    required this.firstLabel,
    required this.secondLabel,
    required this.screenHeight,
    required this.secondFormKey,
    required this.secondFieldInput,
  }) : super(key: key);

  @override
  State<DoubleTimePicker> createState() => _DoubleTimePickerState();
}

class _DoubleTimePickerState extends State<DoubleTimePicker> {
  DateTime dateTime1 = DateTime.now();
  DateTime dateTime2 = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GeneralInputFiled(
          suffixIcon: const Icon(Icons.access_alarm),
          readOnly: true,
          fieldFormKey: widget.firstFormKey,
          fieldInput: widget.firstFieldInput,
          label: widget.firstLabel,
          validateMessageFunction: (value) {
            if (dateTime1.isAfter(dateTime2)) {
              return "From Time Should be Before ToTime";
            }
            return InputValidator.validateRegularField(value);
          },
          onTap: () async {
            await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay(
                        hour: DateTime.now().hour,
                        minute: DateTime.now().minute))
                .then((time) {
              setState(() {
                if (time == null) {
                  time = TimeOfDay(
                      hour: DateTime.now().hour, minute: DateTime.now().minute);
                }
                String timeText =
                    "${time!.hour.toString()}:${time!.minute.toString()}";
                widget.firstFieldInput.text = timeText.trim();
                DateTime now = DateTime.now();
                dateTime1 = DateTime(
                    now.year, now.month, now.day, time!.hour, time!.minute);
              });
            });
          },
        ),
        SmallFormSeparator(screenHeight: widget.screenHeight),
        GeneralInputFiled(
            suffixIcon: const Icon(Icons.access_alarm),
            readOnly: true,
            fieldFormKey: widget.secondFormKey,
            onTap: () async {
              await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay(
                          hour: DateTime.now().hour,
                          minute: DateTime.now().minute))
                  .then((time) {
                setState(() {
                  if (time == null) {
                    time = TimeOfDay(
                        hour: DateTime.now().hour,
                        minute: DateTime.now().minute);
                  }
                  String timeText =
                      "${time!.hour.toString()}:${time!.minute.toString()}";
                  widget.secondFieldInput.text = timeText.trim();
                  DateTime now = DateTime.now();
                  dateTime2 = DateTime(
                      now.year, now.month, now.day, time!.hour, time!.minute);
                });
              });
            },
            fieldInput: widget.secondFieldInput,
            label: widget.secondLabel,
            validateMessageFunction: (value) {
              if (dateTime1.isAfter(dateTime2)) {
                return "From Time Should be Before ToTime";
              }
              return InputValidator.validateRegularField(value);
            })
      ],
    );
  }
}
