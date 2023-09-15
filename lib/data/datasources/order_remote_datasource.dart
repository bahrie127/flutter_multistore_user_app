import 'package:dartz/dartz.dart';
import 'package:flutter_fic7_app/data/models/order_response_model.dart';
import 'package:flutter_fic7_app/data/models/request/order_request_model.dart';
import 'package:http/http.dart' as http;

import '../../common/global_variables.dart';
import 'auth_local_datasource.dart';

class OrderRemoteDatasource {
  Future<Either<String, OrderResponseModel>> order(
      OrderRequestModel orderRequestModel) async {
    final token = await AuthLocalDatasource().getToken();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.post(
        Uri.parse('${GlobalVariables.baseUrl}/api/orders'),
        headers: headers,
        body: orderRequestModel.toJson());

    if (response.statusCode == 200) {
      return Right(OrderResponseModel.fromJson(response.body));
    } else {
      return const Left('Server error');
    }
  }
}
