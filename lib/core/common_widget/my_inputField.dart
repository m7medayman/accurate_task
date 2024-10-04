import 'package:accurate_task/core/helpers/input_fields.dart';
import 'package:flutter/material.dart';

class GeneralInputFiled extends StatelessWidget {
  const GeneralInputFiled(
      {super.key,
      required GlobalKey<FormState> fieldFormKey,
      required this.fieldInput,
      required this.label,
      required this.validateMessageFunction,
      this.icon,
      this.suffixIcon,
      this.readOnly,
      this.onTap,
      this.minLines})
      : _emailFormKey = fieldFormKey;

  final GlobalKey<FormState> _emailFormKey;
  final TextEditingController fieldInput;
  final String label;
  final String? Function(String?) validateMessageFunction;
  final Icon? icon;
  final Icon? suffixIcon;
  final void Function()? onTap;
  final bool? readOnly;
  final int? minLines;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _emailFormKey,
      child: TextFormField(
        maxLines: minLines,
        onTap: onTap,
        controller: fieldInput,
        readOnly: readOnly ?? false,
        validator: (value) => validateMessageFunction(value),
        decoration: InputDecoration(
            suffixIcon: suffixIcon,
            prefixIcon: icon,
            filled: true,
            // fillColor: ColorManager.textColorInputBackGround,
            label: Text(label),
            labelStyle: Theme.of(context).textTheme.bodySmall),
      ),
    );
  }
}

class EmailInputFiled extends GeneralInputFiled {
  const EmailInputFiled(
      {super.key,
      required super.fieldFormKey,
      required super.fieldInput,
      super.label = "UserName/Email"})
      : super(
            icon: const Icon(Icons.person),
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
        obscureText: _obscureText,
        controller: widget.inputController,
        validator: (value) => InputValidator.validatePassword(value),
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.key),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: _togglePasswordVisibility,
            ),
            filled: true,
            // fillColor: ColorManager.textColorInputBackGround,
            label: Text(widget.label),
            labelStyle: Theme.of(context).textTheme.bodySmall),
      ),
    );
  }
}
