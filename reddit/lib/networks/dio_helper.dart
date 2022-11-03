import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'constant_end_points.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        /// this is the base url for our dio connections
        baseUrl: baseUrl,

        /// this allow receving data even if the status was error
        /// also allows be to read the debug errors if any has occured
        receiveDataWhenStatusError: true,

        /// this allows me to define how much time I should wait
        /// before ending the connection, depending on the internet speed
        /// note that time is in milli.
        /// I want it to wait 10 seconds before ending
        connectTimeout: 10 * 1000,

        /// time waited to recieve something from the server
        receiveTimeout: 20 * 1000,

        /// this is a map of headers
        headers: {'Content-Type': 'application/json; charset=utf-8'},
      ),
    );
  }

  /// now we need to define the web Services

  /// this is for the post request
  static Future<Response> postData({
    required String path, // the added path to the baseURL
    required Map<String, dynamic> data,

    /// which is the content of the JSON
    Map<String, dynamic>? query,

    /// aditional query
  }) async {
    return await dio.post(path, data: data, queryParameters: query);
  }

  /// for the get request
  static Future<Response> getData({
    Map<String, dynamic>? query,
    required String path,
    String? token,
  }) async {
    return await dio.get(path, queryParameters: query);
  }
}
