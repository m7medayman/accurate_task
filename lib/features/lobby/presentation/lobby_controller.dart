import 'package:accurate_task/core/helpers/date_model.dart';
import 'package:accurate_task/core/routing/routes_manager.dart';
import 'package:accurate_task/features/update_request/data/graph_ql_server_update.dart';
import 'package:accurate_task/features/update_request/presentation/update_request_model.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:accurate_task/core/common_widget/alert_dialog.dart';
import 'package:accurate_task/core/shared_pref/shard_prefrences_helper.dart';
import 'package:accurate_task/features/auth/login/data/auth_repo.dart';
import 'package:accurate_task/features/create_request/helpers/strigns_constants.dart';
import 'package:accurate_task/features/lobby/data/get_request_repo.dart';
import 'package:accurate_task/features/lobby/presentation/lobby_model.dart';

class LobbyController extends ChangeNotifier {
  RequestsRepo requestsRepo;
  bool isLoading = false;
  bool isError = false;
  bool payment = true;
  bool returns = false;
  bool materials = false;
  BuildContext context;
  String errorMessage = "";
  List<Map<String, dynamic>> requestResponses = [];
  List<LobbyRequest> viewRequests = [];
  List<LobbyRequest> filteredRequests = [];
  LobbyController({
    required this.requestsRepo,
    required this.context,
  });
  Future<void> updateViewRequests() async {
    isLoading = true;
    notifyListeners();
    List<String> ids = await SharedPreferencesHelper.getIdsList();
    await requestsRepo.getRequests(ids).fold((error) {
      isLoading = false;
      isError = true;
      showAlertDialog(context, error.message, "Error");
      notifyListeners();
      isError = false;
      notifyListeners();
    }, (success) {
      requestResponses = success.data;
      viewRequests = requestResponses.map((e) {
        return LobbyRequest(
            id: e["id"].toString(),
            dateTime: e["date"].toString(),
            deliveryType: e["deliveryType"]["code"].toString(),
            typeCode: e["type"]["code"].toString(),
            notes: e["notes"].toString(),
            payeeName: e["payeeName"]);
      }).toList();
      isLoading = false;
      notifyListeners();
    });
  }

  void paymentFilter() async {
    await updateViewRequests();
    payment = true;
    returns = false;
    materials = false;
    filteredRequests = viewRequests.where((element) {
      print(element);
      return element.typeCode == "PMNT";
    }).toList();
    notifyListeners();
  }

  void returnsFilter() {
    updateViewRequests();
    payment = false;
    returns = true;
    materials = false;
    filteredRequests = viewRequests.where((element) {
      return element.typeCode == "RTRN";
    }).toList();
    notifyListeners();
  }

  void matrialFilter() {
    updateViewRequests();
    payment = false;
    returns = false;
    materials = true;
    filteredRequests = viewRequests.where((element) {
      return element.typeCode == "MTRL";
    }).toList();
    notifyListeners();
  }

  UpdateRequestModel goToUpdateScree(
      BuildContext context,
      int id,
      String deliverType,
      String requestType,
      DateTimeModel dateTimeModel,
      String payeeName,
      String notes) {
    return UpdateRequestModel(
        id: id,
        deliverType: deliverType,
        requestType: requestType,
        dateTimeModel: dateTimeModel,
        payeeName: payeeName,
        notes: notes);
  }
}
