import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../app/constants/exception_http.dart';
import '../interfaces/http_interface.dart';
import 'dio.dart';
import '../app/constants/http_methods.dart';

class ClientHttpService implements IClientHttp {
  @override
  Future get(String url) async {
    final defaultHeaders = ({
      "Content-Type": "application/json",
      "accept": "application/json",
    });
    try {
      final response = await dio.request(
        url,
        options: Options(
            validateStatus: (status) => true,
            method: HttpMethods.get,
            headers: defaultHeaders),
      );
      if (response.statusCode == 200) {
        return response.data;
      } else if (response.statusCode == 401) {
        throw AuthenticationException('Your session has expired');
      } else if (response.statusCode == 400) {
        throw BadRequestException('Wrong Data');
      } else {
        throw ApiException(
            'Request failed with status: ${response.statusCode}');
      }
    } on DioError catch (error) {
      if (error.type == DioErrorType.connectionTimeout) {
        throw TimeoutException('Connection timeout');
      } else if (error.type == DioErrorType.sendTimeout) {
        throw TimeoutException('Send timeout');
      } else if (error.type == DioErrorType.receiveTimeout) {
        throw TimeoutException('Receive timeout');
      } else {
        throw ApiException('Request failed with error: ${error.message}');
      }
    } on SocketException catch (error) {
      debugPrint('SocketException error: $error');
      throw NoInternetException('No internet connection');
    } catch (error) {
      debugPrint('Unhandled error: $error');
      rethrow;
    }
  }

  @override
  Future post(String url) async {}

  @override
  Future delete(String url) async {}
  @override
  Future update(String url) async {}
}
