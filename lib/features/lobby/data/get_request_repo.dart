import 'package:accurate_task/core/failure/failure.dart';
import 'package:accurate_task/core/success/success.dart';
import 'package:accurate_task/features/lobby/data/graph_ql_service_provider.dart';
import 'package:either_dart/either.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class RequestsRepo {
  RequestsGraphServiceProvider requestsGraphServiceProvider;
  RequestsRepo({
    required this.requestsGraphServiceProvider,
  });

  Future<Either<Failure, Success>> getRequests(List<String> ids) async {
    bool result = await InternetConnection().hasInternetAccess;
    if (!result) {
      return Left(Failure(message: "Check internet connection "));
    } else {
      try {
        final response =
            await requestsGraphServiceProvider.getPunchOfRequest(ids);
        return response;
      } catch (e) {
        return Left(Failure(message: e.toString()));
      }
    }
  }
}
