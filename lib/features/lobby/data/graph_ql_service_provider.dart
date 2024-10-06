import 'package:accurate_task/core/Authentication/auth.dart';
import 'package:accurate_task/core/Authentication/graphConstants.dart';
import 'package:accurate_task/core/Di/di.dart';
import 'package:accurate_task/core/failure/failure.dart';
import 'package:accurate_task/core/success/success.dart';
import 'package:either_dart/either.dart';
import 'package:graphql/client.dart';

class RequestsGraphServiceProvider {
  static String url = GraphConstant.apiUrl;
  static Auth auth = getIt<Auth>();
  static final HttpLink _httpLink = HttpLink(
    url,
    defaultHeaders: {
      'Authorization': 'Bearer ${auth.token}',
      'AuthorizationSource': 'API',
    },
  );

  static final GraphQLClient getRequestClient = GraphQLClient(
    link: _httpLink,
    cache: GraphQLCache(store: InMemoryStore()),
  );
  Future<Either<Failure, Success>> getPunchOfRequest(List<String> ids) async {
    try {
      List<Map<String, dynamic>> punchOfRequests = [];
      for (int i = 0; i < ids.length; i++) {
        Map<String, dynamic> response = await getRequestData(ids[i]);
        punchOfRequests.add(response);
      }
      return Right(Success(data: punchOfRequests));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  Future<Map<String, dynamic>> getRequestData(String id) async {
    try {
      var response = await getRequestClient.query(QueryOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: GraphConstant.requestQuery,
          variables: {"id": num.parse(id).toInt()}));
      if (response.exception != null) {
        print(response.exception!.graphqlErrors);
        throw Exception(
            response.exception!.graphqlErrors.first.message.toString());
      }
      if (response.data == null) {
        throw Exception("null response data for request ");
      }
      print(response.data);
      var data = response.data!;
      return data["customerRequest"] as Map<String, dynamic>;
    } catch (e) {
      rethrow;
    }
  }
}
