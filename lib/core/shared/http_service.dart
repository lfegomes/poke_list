import 'package:dio/dio.dart';

import '../utils/constants.dart';

class HttpService {
  final _httpService = Dio();

  HttpService() {
    _httpService.options.baseUrl = Constant.BASE_URL;
    _httpService.options.connectTimeout = 5000;
    _httpService.options.sendTimeout = 5000;
    _httpService.options.receiveTimeout = 5000;
  }

  Future<Response> get(String url) => _httpService.get(url);
}
