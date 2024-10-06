import 'package:accurate_task/core/helpers/input_fields.dart';
import 'package:accurate_task/core/theme/color_manager.dart';
import 'package:flutter/material.dart';

class GeneralInputFiled extends StatelessWidget {
  const GeneralInputFiled(
      {super.key,
      required GlobalKey<FormState> fieldFormKey,
      required this.fieldInput,
      required this.label,
      required this.validateMessageFunction,
      this.prefixWidget,
      this.suffixIcon,
      this.readOnly,
      this.onTap,
      this.maxLines})
      : _emailFormKey = fieldFormKey;

  final GlobalKey<FormState> _emailFormKey;
  final TextEditingController fieldInput;
  final String label;
  final String? Function(String?) validateMessageFunction;
  final Widget? prefixWidget;
  final Widget? suffixIcon;
  final void Function()? onTap;
  final bool? readOnly;
  final int? maxLines;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _emailFormKey,
      child: TextFormField(
        onTapOutside: (value) {
          FocusScope.of(context).unfocus();
        },
        maxLines: maxLines,
        onTap: onTap,
        controller: fieldInput,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: ColorManager.labelTextColor),
        readOnly: readOnly ?? false,
        validator: (value) => validateMessageFunction(value),
        decoration: InputDecoration(
            suffixIcon: suffixIcon,
            prefixIcon: prefixWidget,
            filled: true,
            // fillColor: ColorManager.textColorInputBackGround,
            label: Text(label),
            labelStyle: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: ColorManager.labelTextColor)),
      ),
    );
  }
}

class EmailInputFiled extends GeneralInputFiled {
  const EmailInputFiled(
      {super.key,
      required super.fieldFormKey,
      required super.fieldInput,
      super.maxLines = 1,
      super.label = "UserName/Email"})
      : super(
            prefixWidget: const Icon(
              Icons.person,
              color: ColorManager.labelTextColor,
            ),
            validateMessageFunction: InputValidator.validateRegularField);
}

class PasswordInputFiled extends StatefulWidget {
  const PasswordInputFiled({
    super.key,
    required GlobalKey<FormState> FormKey,
    required this.inputController,
    this.label = "password",
    this.validateMessageFunction = InputValidator.validatePassword,
  }) : _emailFormKey = FormKey;

  final GlobalKey<FormState> _emailFormKey;
  final TextEditingController inputController;
  final String label;
  final String? Function(String?) validateMessageFunction;

  @override
  State<PasswordInputFiled> createState() => _PasswordInputFiledState();
}

class _PasswordInputFiledState extends State<PasswordInputFiled> {
  bool _obscureText = true;

  // Method to toggle password visibility
  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: widget._emailFormKey,
        child: TextFormField(
          maxLines: 1,
          obscureText: _obscureText,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: ColorManager.labelTextColor),
          controller: widget.inputController,
          validator: (value) => InputValidator.validatePassword(value),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.key,
              color: ColorManager.labelTextColor,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility_off : Icons.visibility,
                color: ColorManager.labelTextColor,
              ),
              onPressed: _togglePasswordVisibility,
            ),
            filled: true,
            // fillColor: ColorManager.textColorInputBackGround,
            label: Text(widget.label),
            labelStyle: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: ColorManager.labelTextColor),
          ),
        ));
  }
}
