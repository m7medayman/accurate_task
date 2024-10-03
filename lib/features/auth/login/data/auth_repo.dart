import 'package:either_dart/either.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import 'package:accurate_task/core/failure/failure.dart';
import 'package:accurate_task/core/success/success.dart';
import 'package:accurate_task/features/auth/login/data/firebase_service_provider.dart';

class AuthRepo {
  FirebaseServiceProvider firebaseServiceProvider;
  AuthRepo({
    required this.firebaseServiceProvider,
  });
  Future<Either<Failure, Success>> login(String email, String password) async {
    bool result = await InternetConnection().hasInternetAccess;
    if (!result) {
      return Left(Failure(message: "Check internet connection "));
    } else {
      try {
        final user = await firebaseServiceProvider.login(email, password);
        return Right(Success(data: user));
      } catch (e) {
        return Left(Failure(message: e.toString()));
      }
    }
  }
}
