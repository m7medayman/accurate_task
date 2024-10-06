import 'package:accurate_task/core/failure/failure.dart';
import 'package:accurate_task/core/success/success.dart';
import 'package:accurate_task/features/create_request/data/graphQl_request_mdel.dart';
import 'package:accurate_task/features/create_request/presentation/create_request_model.dart';
import 'package:accurate_task/features/update_request/data/graph_ql_server_update.dart';
import 'package:accurate_task/features/update_request/presentation/update_request_model.dart';
import 'package:either_dart/either.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class UpdateRepo {
  final updateRequestGraphServiceProvider updateRequestProvider;

  UpdateRepo({required this.updateRequestProvider});

  Future<Either<Failure, Success>> updateRequest(
      UpdateRequestModel model) async {
    bool result = await InternetConnection().hasInternetAccess;
    if (!result) {
      return Left(Failure(message: "Check internet connection "));
    } else {
      try {
        final response = updateRequestProvider.updateRequest(
            GraphqlRequestModel(
                id: model.id,
                deliverType: convertToDeliveryTypeEnum(model.deliverType)!,
                requestType: convertToTypeCodeEnum(model.requestType)!,
                dateTimeModel: model.dateTimeModel,
                payeeName: model.payeeName,
                notes: model.notes));
        return response;
      } catch (e) {
        return Left(Failure(message: e.toString()));
      }
    }
  }
}
