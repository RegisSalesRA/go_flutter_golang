import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../app/constants/exception_http.dart';
import '../app/constants/handler_response.dart';
import 'http_interface.dart';
import 'dio.dart';
import '../app/constants/http_methods.dart';

class ClientHttpService implements IClientHttp {
  final defaultHeaders = ({
    "Content-Type": "application/json",
    "accept": "application/json",
  });

  @override
  Future get(String url) async {
    try {
      final response = await dio.request(
        url,
        options: Options(
          validateStatus: (status) => true,
          method: HttpMethods.get,
        ),
      );
      return handleResponse(response);
    } on DioError catch (error) {
      handleDioError(error);
    } on SocketException catch (error) {
      debugPrint('SocketException error: $error');
      throw NoInternetException('No internet connection');
    } catch (error) {
      debugPrint('Unhandled error: $error');
      rethrow;
    }
  }

  @override
  Future post(String url, data) async {
    final defaultHeaders = ({
      "Content-Type": "application/json",
      "accept": "application/json",
    });

    try {
      final response = await dio.request(url,
          options: Options(
              validateStatus: (status) => true,
              method: HttpMethods.post,
              headers: defaultHeaders),
          data: data);

      return handleResponse(response);
    } on DioError catch (error) {
      handleDioError(error);
    } on SocketException catch (error) {
      debugPrint('SocketException error: $error');
      throw NoInternetException('No internet connection');
    } catch (error) {
      debugPrint('Unhandled error: $error');
      rethrow;
    }
  }

  @override
  Future delete(String url) async {
    final defaultHeaders = ({
      "Content-Type": "application/json",
      "accept": "application/json",
    });
    try {
      final response = await dio.request(
        url,
        options: Options(
            validateStatus: (status) => true,
            method: HttpMethods.delete,
            headers: defaultHeaders),
      );
      print(response);
      return handleResponse(response);
    } on DioError catch (error) {
      handleDioError(error);
    } on SocketException catch (error) {
      debugPrint('SocketException error: $error');
      throw NoInternetException('No internet connection');
    } catch (error) {
      debugPrint('Unhandled error: $error');
      rethrow;
    }
  }

  @override
  Future update(String url, dynamic data) async {
    final defaultHeaders = ({
      "Content-Type": "application/json",
      "accept": "application/json",
    });
    try {
      final response = await dio.request(url,
          options: Options(
              validateStatus: (status) => true,
              method: HttpMethods.put,
              headers: defaultHeaders),
          data: data);
      return handleResponse(response);
    } on DioError catch (error) {
      handleDioError(error);
    } on SocketException catch (error) {
      debugPrint('SocketException error: $error');
      throw NoInternetException('No internet connection');
    } catch (error) {
      debugPrint('Unhandled error: $error');
      rethrow;
    }
  }
}
