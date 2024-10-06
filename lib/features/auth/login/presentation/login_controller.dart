import 'package:accurate_task/core/common_widget/alert_dialog.dart';
import 'package:accurate_task/core/routing/routes_manager.dart';
import 'package:accurate_task/core/success/success.dart';
import 'package:accurate_task/features/auth/login/presentation/login_model.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:accurate_task/features/auth/login/data/auth_repo.dart';

class LoginController with ChangeNotifier {
  AuthRepo authRepo;

  LoginUserModel userModel = LoginUserModel(
    email: "",
    password: "",
  );
  String errorMessage = "";
  bool isLoading = false;
  bool isError = false;
  LoginController({
    required this.authRepo,
  });
  void updateUserEmailAndPassword(String email, String password) {
    userModel.email = email;
    userModel.password = password;
  }

  void Loading(BuildContext context) async {
    isLoading = true;
    FocusScope.of(context).unfocus();
    notifyListeners();
    await authRepo.login(userModel.email!, userModel.password!).fold((failure) {
      isError = true;
      errorMessage = failure.message;
      isLoading = false;
      notifyListeners();
      showAlertDialog(context, failure.message, "Error");
      print(failure.message);
    }, (success) {
      print("success");
      print(success.data);
      Navigator.of(context).pushReplacementNamed(Routes.createRequest);
    });
  }
}
