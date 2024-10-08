import 'package:accurate_task/core/Di/di.dart';
import 'package:accurate_task/core/common_widget/my_elevated_button.dart';
import 'package:accurate_task/core/common_widget/my_inputField.dart';
import 'package:accurate_task/core/common_widget/separator.dart';
import 'package:accurate_task/core/theme/color_manager.dart';
import 'package:accurate_task/features/auth/login/presentation/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});
  final GlobalKey<FormState> emailKey = GlobalKey();
  final TextEditingController emailTextController = TextEditingController();
  final GlobalKey<FormState> passwordKey = GlobalKey();
  final TextEditingController passwordTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return ChangeNotifierProvider<LoginController>(
      create: (context) => getIt<LoginController>(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            "Accurate",
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.bold, color: ColorManager.primaryColor),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: screenHeight * 0.2,
                child: Center(
                  child: Text(
                    "ACCURATE",
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: ColorManager.logoColColor),
                  ),
                ),
              ),
              Consumer<LoginController>(builder: (context, controller, child) {
                return Flexible(
                  child: SingleChildScrollView(
                    child: SizedBox(
                      width: screenWidth * 0.8,
                      child: Column(
                        children: [
                          EmailInputFiled(
                              fieldFormKey: emailKey,
                              fieldInput: emailTextController),
                          FormSeparator(
                            screenHeight: screenHeight,
                            percent: 0.01,
                          ),
                          PasswordInputFiled(
                              FormKey: passwordKey,
                              inputController: passwordTextController),
                          FormSeparator(
                            screenHeight: screenHeight,
                            percent: 0.01,
                          ),
                          controller.isLoading
                              ? CircularProgressIndicator()
                              : MyElevatedButton(
                                  onPressed: () {
                                    if (emailKey.currentState!.validate() &&
                                        passwordKey.currentState!.validate()) {
                                      controller.updateUserEmailAndPassword(
                                          emailTextController.text.trim(),
                                          passwordTextController.text.trim());
                                      controller.Loading(context);
                                    }
                                  },
                                  screenWidth: screenWidth,
                                  icon: Icons.lock_outline_rounded,
                                  content: "Login",
                                ),
                          FormSeparator(screenHeight: screenHeight),
                          const Divider(),
                          FormSeparator(screenHeight: screenHeight),
                          MyElevatedButton(
                              screenWidth: screenWidth,
                              icon: Icons.add_circle_outline,
                              content: "Register New User"),
                          TextButton(
                              onPressed: () {},
                              child: const Text("Forgot Password?"))
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
