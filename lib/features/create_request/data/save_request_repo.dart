import 'package:accurate_task/core/failure/failure.dart';
import 'package:accurate_task/core/success/success.dart';
import 'package:accurate_task/features/create_request/data/graphQl_request_mdel.dart';
import 'package:accurate_task/features/create_request/data/graph_service_provider.dart';
import 'package:accurate_task/features/create_request/presentation/create_request_model.dart';
import 'package:either_dart/either.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class SaveRequestRepo {
  SaveRequestGraphServiceProvider saveRequestGraphServiceProvider;
  SaveRequestRepo({
    required this.saveRequestGraphServiceProvider,
  });

  Future<Either<Failure, Success>> saveRequest(CreateRequestModel model) async {
    bool result = await InternetConnection().hasInternetAccess;
    if (!result) {
      return Left(Failure(message: "Check internet connection "));
    } else {
      try {
        final response = saveRequestGraphServiceProvider.saveRequest(
            GraphqlRequestModel(
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
