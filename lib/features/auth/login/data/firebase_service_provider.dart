import 'package:accurate_task/core/failure/failure.dart';
import 'package:accurate_task/core/success/success.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServiceProvider {
  FirebaseAuth firebaseAuth;
  FirebaseServiceProvider({
    required this.firebaseAuth,
  });

  Future<Either<Failure, Success>> login(String email, String password) async {
    try {
      final UserCredential auth = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return Right(Success<UserCredential>(data: auth));
    } catch (e) {
      rethrow;
    }
  }
}
