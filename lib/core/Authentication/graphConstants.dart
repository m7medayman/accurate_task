import 'package:graphql/client.dart';

class GraphConstant {
  static String apiUrl = "https://accurate.accuratess.com:8001/graphql";
  static var loginMutation = gql(r'''
mutation($loginInput:LoginInput!) {
  login(input:$loginInput){
    token
  }
}''');
  static var saveRequestMutation =
      gql(r'''mutation($input:CustomerRequestInput!){
  saveCustomerRequest(input:$input){
    id
    date
    notes
    paymentAccountNumber
  }
}''');
  static var updateRequestMutation =
      gql(r'''mutation($input:CustomerRequestInput!){
  saveCustomerRequest(input:$input){
    id
    date
    notes
    paymentAccountNumber
  }
}''');
  static var requestQuery = gql(r'''query($id:Int!){
  customerRequest(id:$id){
    id,
    date,
    payeeName,
    deliveryType{
      code
    },
    type{
    code
    },
  notes
  }
}''');
}
