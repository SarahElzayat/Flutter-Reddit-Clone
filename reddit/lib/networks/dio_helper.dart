/// @author Abdelaziz Salah
/// @date 3/11/2022
/// this is a DioHelper which is a class used to connect us to the backend
/// and deal with the server
import 'package:dio/dio.dart';
import 'constant_end_points.dart';

class DioHelper {
  static late Dio dio;

  /// this is the initializer function used to set the base options such as
  /// the base url value
  /// and the limits for the timeouts
  /// and the headers
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

  /// this is a function used to send post request with certain body.
  static Future<Response> postData({
    required String path, // the added path to the baseURL
    required Map<String, dynamic> data,

    /// which is the content of the JSON
    Map<String, dynamic>? query,

    /// aditional query
  }) async {
    return await dio.post(path, data: data, queryParameters: query);
  }

  /// this is a function used to send get request
  /// @param [query] which is the query we are asking for <optional>
  /// @param [path] string defining the end point
  static Future<Response> getData({
    Map<String, dynamic>? query,
    required String path,
  }) async {
    return await dio.get(path, queryParameters: query);
  }
}