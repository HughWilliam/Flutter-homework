// cat_service.dart
import 'cat_model.dart';
import 'package:dio/dio.dart';

class CatService {
  final Dio _dio = Dio();

  Future<List<Cat>> fetchCatImages() async {
    final response =
        await _dio.get('https://api.thecatapi.com/v1/images/search?limit=50');

    if (response.statusCode == 200) {
      List<dynamic> data = response.data;
      List<Cat> cats = data.map((cat) => Cat.fromJson(cat)).toList();
      return cats;
    } else {
      throw Exception('Failed to load cat images');
    }
  }
}
