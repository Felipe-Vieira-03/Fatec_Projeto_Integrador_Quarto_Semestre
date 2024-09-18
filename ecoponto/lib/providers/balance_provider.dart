import 'package:flutter_ecommerce/model/product_model.dart';
import 'package:flutter_ecommerce/providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

final balanceProvider = FutureProvider<List<MaterialModel>>((ref) async {
  final userId = await AuthService().getUserId();

  final response = await http.get(Uri.parse(
      'http://127.0.0.1:8000/materials/recycle_balance/?user_id_occurrence=$userId'));
  // 'http://10.0.2.2:8000/materials/recycle_balance/?user_id_occurrence=$userId'));
  if (response.statusCode == 200) {
    List<dynamic> responseData = json.decode(utf8.decode(response.bodyBytes));
    if (responseData.isNotEmpty) {
      List<dynamic> recicleBalanceArray =
          responseData[0]['recicle_balance_array'];
      List<MaterialModel> materials = recicleBalanceArray
          .map((json) => MaterialModel.fromJson(json))
          .toList();
      print('Materials: $materials');
      return materials;
    } else {
      return [];
    }
  } else {
    throw Exception('Failed to load materials');
  }
});
