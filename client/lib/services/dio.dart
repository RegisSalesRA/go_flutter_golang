import 'package:dio/dio.dart';

final options = BaseOptions(
  baseUrl: "http://10.0.2.2:9000",
  connectTimeout: const Duration(seconds: 5),
);

  final dio = Dio(options);