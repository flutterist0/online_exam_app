import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';

class JwtInterceptor extends Interceptor {
  late FlutterSecureStorage _storage;
  String? token;

  JwtInterceptor() {
    _init();
  }

  Future<void> _init() async {
    _storage = const FlutterSecureStorage();
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    debugPrint("Requestumuz: $options");
    token = await _storage.read(key: 'token');
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    return handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    return handler.next(response);
  }
}
