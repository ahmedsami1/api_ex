import 'dart:developer';



import 'package:api_ex/models/product_model.dart';
import 'package:dio/dio.dart';

class ProductService {

  ProductService(this.dio);
  final Dio dio;

  Future<List<ProductModel>> getAllProducts() async {
    try {
      final response = await dio.get(
        'https://fakestoreapi.com/products',
      );

      if (response.statusCode == 200) {
        final List data = response.data;

        return data
            .map((e) => ProductModel.fromJson(e))
            .toList();
      } else {
        throw Exception('Unexpected status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      log(e.toString());

      rethrow;
    } catch (e) {
        log(e.toString());
      throw Exception('Something went wrong');
    }
  }
}