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
            validateMessageFunction: InputValidator.validateEmail);
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

class TimePickerButton extends StatefulWidget {
  TimePickerButton(
      {super.key,
      required this.labelText,
      required GlobalKey<FormState> fieldFormKey,
      required this.fieldInput,
      this.isSecondTimer = false,
      required this.dateTime,
      required this.onValue,
      this.secondTime,
      this.firstTime})
      : _fieldFormKey = fieldFormKey;
  final String labelText;
  final GlobalKey<FormState> _fieldFormKey;
  final TextEditingController fieldInput;
  final bool isSecondTimer;
  final DateTime dateTime;
  DateTime? firstTime;
  DateTime? secondTime;
  Function(TimeOfDay?) onValue;
  @override
  State<TimePickerButton> createState() => _TimePickerButtonState();
}

class _TimePickerButtonState extends State<TimePickerButton> {
  String timeText = "";
  @override
  Widget build(BuildContext context) {
    return GeneralInputFiled(
      suffixIcon: const Icon(Icons.access_alarm),
      readOnly: true,
      fieldFormKey: widget._fieldFormKey,
      fieldInput: widget.fieldInput,
      label: widget.labelText,
      validateMessageFunction: (value) {
        String? error = InputValidator.validateRegularField(value);
        if (error != null) {
          return error;
        }
        if (widget.isSecondTimer) {
          if (widget.firstTime == null) {
            return null;
          }
          if (widget.secondTime == null) {
            return null;
          }
          if (widget.secondTime!.isBefore(widget.firstTime!)) {
            return "From Time Should be Before ToTime";
          }
        }
      },
      onTap: () async {
        await showTimePicker(
                context: context,
                initialTime: TimeOfDay(
                    hour: DateTime.now().hour, minute: DateTime.now().minute))
            .then((time) {
          setState(() {
            if (time == null) {
              time = TimeOfDay(
                  hour: DateTime.now().hour, minute: DateTime.now().minute);
            }
            widget.onValue(time);
            timeText = "${time!.hour.toString()}:${time!.minute.toString()}";
            widget.fieldInput.text = timeText;
          });
        });
      },
    );
  }
}
