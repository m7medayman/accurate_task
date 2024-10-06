import 'package:accurate_task/core/common_widget/my_inputField.dart';
import 'package:accurate_task/core/helpers/input_fields.dart';
import 'package:accurate_task/core/theme/color_manager.dart';
import 'package:flutter/material.dart';

class BottomSheetField extends StatefulWidget {
  BottomSheetField(
      {super.key,
      this.showOnly = false,
      required this.choices,
      required this.fieldFormKey,
      required this.fieldInput,
      required this.label,
      required this.screenHeight});
  final GlobalKey<FormState> fieldFormKey;
  final TextEditingController fieldInput;
  final String label;
  final List<String> choices;
  final double screenHeight;
  final bool? showOnly;

  @override
  State<BottomSheetField> createState() => _BottomSheetFieldState();
}

class _BottomSheetFieldState extends State<BottomSheetField> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GeneralInputFiled(
        readOnly: true,
        onTap: widget.showOnly!
            ? () {}
            : () {
                show(context);
              },
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            isSelected
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        isSelected = false;
                        widget.fieldInput.clear();
                      });
                    },
                    icon: Icon(
                      Icons.cancel_outlined,
                      color: ColorManager.logoColColor,
                    ))
                : SizedBox(),
            Icon(
              Icons.arrow_drop_down_outlined,
              color: ColorManager.labelTextColor,
            ),
          ],
        ),
        fieldFormKey: widget.fieldFormKey,
        fieldInput: widget.fieldInput,
        label: widget.label,
        validateMessageFunction: InputValidator.validateRegularField);
  }

  void show(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: ColorManager.backGroundColorScaffold,
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: widget.screenHeight * 0.3, // Set your desired height
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: widget.choices.map((value) {
                    return Container(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            isSelected = true;
                            widget.fieldInput.text = value;
                            Navigator.of(context).pop();
                          });
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                value,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: ColorManager.white),
                              ),
                            ),
                            widget.choices.last == value
                                ? Container()
                                : const Divider(
                                    color: ColorManager.white,
                                    thickness: 1,
                                  )
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          );
        });
  }
}
