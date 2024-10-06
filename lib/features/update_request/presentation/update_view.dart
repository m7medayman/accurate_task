import 'package:accurate_task/core/Di/di.dart';
import 'package:accurate_task/core/common_widget/my_elevated_button.dart';
import 'package:accurate_task/core/helpers/input_fields.dart';
import 'package:accurate_task/features/update_request/presentation/converter.dart';
import 'package:accurate_task/features/update_request/presentation/update_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:accurate_task/core/common_widget/bottom_sheet_field.dart';
import 'package:accurate_task/core/common_widget/date_picker.dart';
import 'package:accurate_task/core/common_widget/my_inputField.dart';
import 'package:accurate_task/core/common_widget/separator.dart';
import 'package:accurate_task/core/helpers/date_model.dart';
import 'package:accurate_task/core/theme/color_manager.dart';
import 'package:accurate_task/features/create_request/helpers/strigns_constants.dart';
import 'package:accurate_task/features/update_request/presentation/update_request_model.dart';

class UpdateView extends StatelessWidget {
  UpdateRequestModel model;
  UpdateView({
    Key? key,
    required this.model,
  }) : super(key: key) {
    formDateTimeControl.text = model.dateTimeModel.toString();
    dateTimeModel = model.dateTimeModel;
    formDeliveryControl.text = deliveryConveterStringString(model.deliverType);
    formPayeeControl.text = model.payeeName;
    formNoteControl.text = model.notes;
    formRequestControl.text = typeConverterStringString(model.requestType);
  }
  final GlobalKey<FormState> formRequestKey = GlobalKey();
  final TextEditingController formRequestControl = TextEditingController();
  final GlobalKey<FormState> formDeliveryKey = GlobalKey();
  final TextEditingController formDeliveryControl = TextEditingController();
  DateTimeModel dateTimeModel = DateTimeModel();
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Update Request",
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(color: ColorManager.primaryColor),
        ),
      ),
      body: ChangeNotifierProvider(
        create: (context) => getIt<UpdateController>(),
        child: Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            width: screenWidth * 0.9,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  BottomSheetField(
                      showOnly: true,
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
                      showOnly: true,
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
                  Consumer<UpdateController>(
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
                            controller.UpdateRequest(
                                context,
                                UpdateRequestModel(
                                    id: model.id,
                                    deliverType: formDeliveryControl.text,
                                    requestType: formRequestControl.text,
                                    dateTimeModel: dateTimeModel,
                                    payeeName: formPayeeControl.text,
                                    notes: formNoteControl.text));
                          }
                        },
                        screenWidth: screenWidth,
                        icon: Icons.check_circle_outline,
                        content: "update");
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
