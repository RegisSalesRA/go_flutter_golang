import 'package:dio/dio.dart';

import 'exception_http.dart';

handleResponse(Response response) {
  if (response.statusCode == 200) {
    return response.data;
  } else if (response.statusCode == 401) {
    throw AuthenticationException('Your session has expired');
  } else if (response.statusCode == 404) {
    throw AuthenticationException('Not found');
  } else if (response.statusCode == 400) {
    throw BadRequestException('Wrong Data');
  } else {
    throw ApiException('Request failed with status: ${response.statusCode}');
  }
}

dynamic handleDioError(DioError error) {
  if (error.type == DioErrorType.connectionTimeout) {
    throw TimeoutException('Connection timeout');
  } else if (error.type == DioErrorType.sendTimeout) {
    throw TimeoutException('Send timeout');
  } else if (error.type == DioErrorType.receiveTimeout) {
    throw TimeoutException('Receive timeout');
  } else {
    throw ApiException('Request failed with error: ${error.message}');
  }
}
