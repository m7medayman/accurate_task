import 'package:accurate_task/core/common_widget/alert_dialog.dart';
import 'package:accurate_task/features/auth/login/data/auth_repo.dart';
import 'package:accurate_task/features/create_request/presentation/create_request_model.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:accurate_task/features/create_request/data/save_request_repo.dart';

class CreateRequestController extends ChangeNotifier {
  SaveRequestRepo saveRequestRepo;
  CreateRequestController({
    required this.saveRequestRepo,
  });
  bool isLoading = false;
  void saveRequest(BuildContext context, CreateRequestModel model) async {
    isLoading = true;
    showLoadingState(context);
    await saveRequestRepo.saveRequest(model).fold((failure) {
      print("Error");
      print(failure);
      isLoading = false;
      Navigator.of(context).pop();
      showAlertDialog(context, failure.message, "error");
    }, (success) {
      isLoading = false;
      Navigator.of(context).pop();
      print("success");
      print(success.data);
    });
  }
}
