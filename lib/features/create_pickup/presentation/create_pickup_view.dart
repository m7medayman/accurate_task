import 'package:accurate_task/core/common_widget/my_inputField.dart';
import 'package:accurate_task/core/common_widget/separator.dart';
import 'package:accurate_task/core/common_widget/time_picker.dart';
import 'package:accurate_task/core/helpers/input_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreatePickupView extends StatelessWidget {
  CreatePickupView({super.key});
  final GlobalKey<FormState> fromTimeKey = GlobalKey();
  final TextEditingController formInputControl = TextEditingController();
  final GlobalKey<FormState> toTimeKey = GlobalKey();
  final TextEditingController toTimeInputControl = TextEditingController();
  final GlobalKey<FormState> numberOfShipmenKey = GlobalKey();
  final TextEditingController numberOfShipmenInputControl =
      TextEditingController();
  final GlobalKey<FormState> vehicleKey = GlobalKey();
  final TextEditingController vehicleInputControl = TextEditingController();
  final GlobalKey<FormState> notesKey = GlobalKey();
  final TextEditingController notesInputControl = TextEditingController();
  DateTime timPicker1 = DateTime.now();
  DateTime timPicker2 = DateTime.now();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
            textAlign: TextAlign.center,
            "Create pickup",
            style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: screenWidth * 0.9,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // TimePickerButton(
                //   onValue: (time) {
                //     final now = DateTime.now();
                //     timPicker1 = DateTime(
                //         now.year, now.month, now.day, time!.hour, time.minute);
                //   },
                //   labelText: "From Hour",
                //   fieldFormKey: fromTimeKey,
                //   fieldInput: formInputControl,
                //   dateTime: timPicker1,
                // ),
                // SmallFormSeparator(screenHeight: screenHeight),
                // //second time picker
                // TimePickerButton(
                //   firstTime: timPicker1,

                //   isSecondTimer: true,
                //   labelText: "To Hour",
                //   fieldFormKey: toTimeKey,
                //   fieldInput: toTimeInputControl,
                //   dateTime: timPicker2,
                //   onValue: (TimeOfDay? time) {
                //     final now = DateTime.now();
                //     timPicker2 = DateTime(
                //         now.year, now.month, now.day, time!.hour, time.minute);
                //   },
                // ),
                DoubleTimePicker(
                    firstFormKey: fromTimeKey,
                    firstFieldInput: formInputControl,
                    firstLabel: "From:",
                    secondLabel: "To:",
                    screenHeight: screenHeight,
                    secondFormKey: toTimeKey,
                    secondFieldInput: toTimeInputControl),
                SmallFormSeparator(screenHeight: screenHeight),
                GeneralInputFiled(
                    fieldFormKey: numberOfShipmenKey,
                    fieldInput: numberOfShipmenInputControl,
                    label: "Number of Shipments",
                    validateMessageFunction:
                        InputValidator.validateRegularField),
                SmallFormSeparator(screenHeight: screenHeight),
                GeneralInputFiled(
                    fieldFormKey: vehicleKey,
                    fieldInput: vehicleInputControl,
                    label: "Vehicle",
                    validateMessageFunction:
                        InputValidator.validateRegularField),
                SmallFormSeparator(screenHeight: screenHeight),
                GeneralInputFiled(
                    fieldFormKey: notesKey,
                    fieldInput: notesInputControl,
                    maxLines: 4,
                    label: "Notes",
                    validateMessageFunction: InputValidator.noneValidate),
                ElevatedButton(
                    onPressed: () {
                      fromTimeKey.currentState!.validate();
                      toTimeKey.currentState!.validate();
                    },
                    child: Text('Supmit'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
