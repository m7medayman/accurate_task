import 'package:accurate_task/core/Authentication/auth.dart';
import 'package:accurate_task/core/Authentication/graphConstants.dart';
import 'package:accurate_task/core/Di/di.dart';
import 'package:accurate_task/core/failure/failure.dart';
import 'package:accurate_task/core/success/success.dart';
import 'package:accurate_task/features/create_request/data/graphQl_request_mdel.dart';
import 'package:either_dart/either.dart';
import 'package:graphql/client.dart';

class SaveRequestGraphServiceProvider {
  static String url = GraphConstant.apiUrl;
  static Auth auth = getIt<Auth>();
  static final HttpLink _httpLink = HttpLink(
    url,
    defaultHeaders: {
      'Authorization': 'Bearer ${auth.token}',
      'AuthorizationSource': 'API',
    },
  );

  static final GraphQLClient saveRequestClient = GraphQLClient(
    link: _httpLink,
    cache: GraphQLCache(),
  );
  Future<Either<Failure, Success>> saveRequest(
      GraphqlRequestModel model) async {
    try {
      var response = await saveRequestClient.mutate(MutationOptions(
          document: GraphConstant.saveRequestMutation,
          variables: model.toGQLRequest()));

      if (response.exception != null) {
        print(response.exception!.graphqlErrors);
        return Left(Failure(
            message:
                response.exception!.graphqlErrors.first.message.toString()));
      }
      if (response.data == null) {
        return Left(Failure(message: "null api data"));
      }
      print(response.data);
      String id = response.data!["id"];
      return Right(Success(data: id));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
