import 'package:accurate_task/core/Di/di.dart';
import 'package:accurate_task/core/common_widget/bottom_sheet_field.dart';
import 'package:accurate_task/core/common_widget/date_picker.dart';
import 'package:accurate_task/core/common_widget/my_elevated_button.dart';
import 'package:accurate_task/core/common_widget/my_inputField.dart';
import 'package:accurate_task/core/common_widget/separator.dart';
import 'package:accurate_task/core/helpers/date_model.dart';
import 'package:accurate_task/core/helpers/input_fields.dart';
import 'package:accurate_task/core/theme/color_manager.dart';
import 'package:accurate_task/features/create_request/helpers/strigns_constants.dart';
import 'package:accurate_task/features/create_request/presentation/create_request_controller.dart';
import 'package:accurate_task/features/create_request/presentation/create_request_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateRequestView extends StatelessWidget {
  CreateRequestView({super.key});
  final GlobalKey<FormState> formRequestKey = GlobalKey();
  final TextEditingController formRequestControl = TextEditingController();
  final GlobalKey<FormState> formDeliveryKey = GlobalKey();
  final TextEditingController formDeliveryControl = TextEditingController();
  final DateTimeModel dateTimeModel = DateTimeModel();
  final GlobalKey<FormState> formDateTimeKey = GlobalKey();
  final TextEditingController formDateTimeControl = TextEditingController();
  final GlobalKey<FormState> formNoteKey = GlobalKey();
  final TextEditingController formNoteControl = TextEditingController();
  final GlobalKey<FormState> formPayeeKey = GlobalKey();
  final TextEditingController formPayeeControl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return ChangeNotifierProvider<CreateRequestController>(
      create: (context) => getIt<CreateRequestController>(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
              textAlign: TextAlign.center,
              "Create Request",
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: ColorManager.primaryColor)),
        ),
        body: Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            width: screenWidth * 0.9,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  BottomSheetField(
                      choices: [
                        DeliveryTypeStrings.DELIVERYAGENT,
                        DeliveryTypeStrings.OFFICE
                      ],
                      fieldFormKey: formDeliveryKey,
                      fieldInput: formDeliveryControl,
                      label: "Delivery type",
                      screenHeight: screenHeight),
                  SmallFormSeparator(screenHeight: screenHeight),
                  BottomSheetField(
                      choices: [
                        TypeCodeStrings.MTRL,
                        TypeCodeStrings.PMT,
                        TypeCodeStrings.RTRN
                      ],
                      fieldFormKey: formRequestKey,
                      fieldInput: formRequestControl,
                      label: "Request Type",
                      screenHeight: screenHeight),
                  SmallFormSeparator(screenHeight: screenHeight),
                  MyDatePicker(
                    dateTimeModel: dateTimeModel,
                    formKey: formDateTimeKey,
                    fieldInput: formDateTimeControl,
                  ),
                  SmallFormSeparator(screenHeight: screenHeight),
                  GeneralInputFiled(
                      fieldFormKey: formPayeeKey,
                      fieldInput: formPayeeControl,
                      label: "Payee Name",
                      validateMessageFunction:
                          InputValidator.validateRegularField),
                  SmallFormSeparator(screenHeight: screenHeight),
                  GeneralInputFiled(
                      fieldFormKey: formNoteKey,
                      fieldInput: formNoteControl,
                      maxLines: 4,
                      label: "Note",
                      validateMessageFunction:
                          InputValidator.validateRegularField),
                  SmallFormSeparator(screenHeight: screenHeight),
                  Consumer<CreateRequestController>(
                      builder: (context, controller, child) {
                    return MyElevatedButton(
                        onPressed: () {
                          bool isDateValidate =
                              formDateTimeKey.currentState!.validate();
                          bool isrequestValidate =
                              formRequestKey.currentState!.validate();
                          bool isNoteValidate =
                              formNoteKey.currentState!.validate();
                          bool isDelivery =
                              formDeliveryKey.currentState!.validate();
                          bool isPayeeValidate =
                              formPayeeKey.currentState!.validate();
                          if (isPayeeValidate &&
                              isDelivery &&
                              isNoteValidate &&
                              isrequestValidate &&
                              isDateValidate) {
                            controller.saveRequest(
                                context,
                                CreateRequestModel(
                                    deliverType: formDeliveryControl.text,
                                    requestType: formRequestControl.text,
                                    dateTimeModel: dateTimeModel,
                                    payeeName: formPayeeControl.text,
                                    notes: formNoteControl.text));
                          }
                        },
                        screenWidth: screenWidth,
                        icon: Icons.check_circle_outline,
                        content: "Save");
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
