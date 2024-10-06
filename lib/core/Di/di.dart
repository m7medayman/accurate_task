import 'package:accurate_task/features/auth/login/data/auth_repo.dart';
import 'package:accurate_task/features/auth/login/data/firebase_service_provider.dart';
import 'package:accurate_task/features/auth/login/data/graphQl/login_serviceProvider.dart';
import 'package:accurate_task/features/auth/login/presentation/login_controller.dart';
import 'package:accurate_task/features/create_request/data/graph_service_provider.dart';
import 'package:accurate_task/features/create_request/data/save_request_repo.dart';
import 'package:accurate_task/features/create_request/presentation/create_request_controller.dart';
import 'package:accurate_task/features/lobby/data/get_request_repo.dart';
import 'package:accurate_task/features/lobby/data/graph_ql_service_provider.dart';
import 'package:accurate_task/features/update_request/data/graph_ql_repo.dart';
import 'package:accurate_task/features/update_request/data/graph_ql_server_update.dart';
import 'package:accurate_task/features/update_request/presentation/update_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;
bool isLoginModuleInit = false;
void initLoginModule() {
  if (isLoginModuleInit) {
    return;
  }
  isLoginModuleInit = true;
  // FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  getIt.registerFactory(() => GraphServiceProvider());
  getIt.registerFactory(
      () => AuthRepo(graphServiceProvider: getIt<GraphServiceProvider>()));
  getIt.registerFactory<LoginController>(
      () => LoginController(authRepo: getIt()));
}

bool isSaveRequestModule = false;

void initCreateRequestModule() {
  if (isSaveRequestModule) {
    return;
  }
  isSaveRequestModule = true;
  getIt.registerFactory(() => SaveRequestGraphServiceProvider());
  getIt.registerFactory(
      () => SaveRequestRepo(saveRequestGraphServiceProvider: getIt()));
  getIt.registerFactory(() => (saveRequestRepo: getIt()));
  getIt
      .registerFactory(() => CreateRequestController(saveRequestRepo: getIt()));
}

bool isLobbyRequestCreated = false;
void initLobbyModule() {
  if (isLobbyRequestCreated) {
    return;
  }
  isLobbyRequestCreated = true;
  getIt.registerFactory(() => RequestsGraphServiceProvider());
  getIt.registerCachedFactory(
      () => RequestsRepo(requestsGraphServiceProvider: getIt()));
}

bool isUpateModelCreated = false;
void initUpdateModel() {
  if (isUpateModelCreated) {
    return;
  }
  isUpateModelCreated = true;
  getIt.registerFactory(() => updateRequestGraphServiceProvider());
  getIt.registerFactory(() => UpdateRepo(updateRequestProvider: getIt()));
  getIt.registerFactory(() => UpdateController(repo: getIt()));
}
