import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:emp_test/ProductList.dart';
import 'package:emp_test/Model/ProductModel.dart';

class webService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://dummyjson.com',
      connectTimeout: const Duration(seconds: 5000),
      receiveTimeout: const Duration(seconds: 5000),
    ),
  );
  Future<Map<String, dynamic>> getproduct() async {
    var result;

    final response = await dio.get("/products");
    if (response.statusCode == 200) {
      log("response data==" + response.data.toString());

      var webData = response.data;
      log("lll" + webData.toString());
      ProductData ws = ProductData.fromJson(webData);
      log("sssss" + webData.toString());

      result = {'status': true, 'message': 'Succcessful', 'WebService': ws};
    } else {
      result = {
        'status': false,
        'message': json.decode(response.data)['error']
      };
    }

    return result;
  }
}
