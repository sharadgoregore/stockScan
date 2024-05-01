import 'package:dio/dio.dart';
import 'package:stockscan/Model/stockmodel.dart';

class Repository {
  var dio = Dio();

  fetchData() async {
    try {
      final response =
          await dio.get("http://coding-assignment.bombayrunning.com/data.json");
      if (response.statusCode == 200) {
        var data =
            (response.data as List).map((e) => StockModel.fromJson(e)).toList();

        return data;
      }
    } catch (error) {
      print(error);
    }
  }
}
