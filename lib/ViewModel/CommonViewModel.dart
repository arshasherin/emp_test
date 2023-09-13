import 'package:emp_test/services/WebService.dart';
import 'package:flutter/material.dart';

class CommonViewModel extends ChangeNotifier {
  late Map<String, dynamic> products1;
  late Map<String, dynamic> products2;
  Future<Map<String, dynamic>> getproduct() async {
    products1 = await webService().getproduct();
    print(">>>result $getproduct()");
    // notifyListeners();
    return products1;
    // notifyListeners();
  }
}
