import 'package:graphql/client.dart';

class GraphConstant {
  static String apiUrl = "https://accurate.accuratess.com:8001/graphql";
  static var loginMutation = gql(r'''
mutation($loginInput:LoginInput!) {
  login(input:$loginInput){
    token
  }
}''');
}
