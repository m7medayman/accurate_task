import 'package:accurate_task/features/update_request/presentation/update_request_model.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';

import 'package:accurate_task/core/common_widget/alert_dialog.dart';
import 'package:accurate_task/features/create_request/presentation/create_request_model.dart';
import 'package:accurate_task/features/update_request/data/graph_ql_repo.dart';

class UpdateController extends ChangeNotifier {
  bool isLoading = false;
  UpdateRepo repo;
  UpdateController({
    required this.repo,
  });
  void UpdateRequest(BuildContext context, UpdateRequestModel model) async {
    isLoading = true;
    showLoadingState(context);
    await repo.updateRequest(model).fold((failure) {
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
      Navigator.of(context).pop();
    });
  }
}
