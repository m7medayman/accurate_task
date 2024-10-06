import 'package:accurate_task/core/Authentication/auth.dart';
import 'package:accurate_task/core/Authentication/graphConstants.dart';
import 'package:accurate_task/core/Di/di.dart';
import 'package:accurate_task/core/failure/failure.dart';
import 'package:accurate_task/core/success/success.dart';
import 'package:accurate_task/features/create_request/data/graphQl_request_mdel.dart';
import 'package:either_dart/either.dart';
import 'package:graphql/client.dart';

class updateRequestGraphServiceProvider {
  static String url = GraphConstant.apiUrl;
  static Auth auth = getIt<Auth>();
  static final HttpLink _httpLink = HttpLink(
    url,
    defaultHeaders: {
      'Authorization': 'Bearer ${auth.token}',
      'AuthorizationSource': 'API',
    },
  );

  static final GraphQLClient updateRequestClient = GraphQLClient(
    link: _httpLink,
    cache: GraphQLCache(),
  );
  Future<Either<Failure, Success>> updateRequest(
      GraphqlRequestModel model) async {
    try {
      var response = await updateRequestClient.mutate(MutationOptions(
          document: GraphConstant.updateRequestMutation,
          variables: model.toGQLRequestWithId()));

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
      String id = response.data!["saveCustomerRequest"]["id"].toString();
      return Right(Success(data: id));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
