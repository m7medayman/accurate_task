import 'package:accurate_task/features/auth/login/data/auth_repo.dart';
import 'package:accurate_task/features/auth/login/data/firebase_service_provider.dart';
import 'package:accurate_task/features/auth/login/presentation/login_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;
bool isLoginModuleInit = false;
void initLoginModule() {
  if (isLoginModuleInit) {
    return;
  }
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  getIt.registerFactory(
      () => FirebaseServiceProvider(firebaseAuth: firebaseAuth));
  getIt.registerFactory(() => AuthRepo(firebaseServiceProvider: getIt()));
  getIt.registerFactory<LoginController>(
      () => LoginController(authRepo: getIt()));
}
