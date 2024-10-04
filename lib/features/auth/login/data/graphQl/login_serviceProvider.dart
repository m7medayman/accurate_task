import 'package:accurate_task/core/Authentication/auth.dart';
import 'package:accurate_task/core/Authentication/graphConstants.dart';
import 'package:accurate_task/core/Di/di.dart';
import 'package:accurate_task/core/failure/failure.dart';
import 'package:accurate_task/core/success/success.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:graphql/client.dart';

class GraphServiceProvider {
  static String url = GraphConstant.apiUrl;
  static final HttpLink _httpLink = HttpLink(
    url,
    defaultHeaders: {},
  );

  static final GraphQLClient loginClient = GraphQLClient(
    link: _httpLink,
    cache: GraphQLCache(),
  );
  Future<Either<Failure, Success>> login(
      String username, String password) async {
    try {
      var user = await loginClient.mutate(
        MutationOptions(
          document: GraphConstant.loginMutation,
          variables: {
            "loginInput": {"username": username, "password": password}
          },
        ),
      );
      print(user);
      print(user.exception);

      print(user.data);

      if (user.exception != null) {
        print(user.exception!.graphqlErrors);
        return Left(Failure(
            message: user.exception!.graphqlErrors.first.message.toString()));
      }
      if (user.data == null) {
        return Left(Failure(message: "null api data"));
      }
      Map<String, dynamic> data = user.data!;
      if (data.containsKey("login")) {
        String token = data["login"]["token"];
        print(token);
        getIt.registerSingleton(() => Auth(token: token));
        return Right(Success(data: Auth(token: token)));
      }
      return Left(Failure(message: "unKnown Error"));
    } catch (e) {
      rethrow;
    }
  }
}
