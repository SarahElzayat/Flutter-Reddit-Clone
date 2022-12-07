import 'package:dio/dio.dart';
// ignore: depend_on_referenced_packages
import 'package:mockito/annotations.dart';
// ignore: depend_on_referenced_packages
import 'package:mockito/mockito.dart';
import 'package:reddit/components/helpers/mocks/post_cubit.mocks.dart';
import 'package:reddit/data/temp_data/tmp_data.dart';

import '../../../networks/constant_end_points.dart';

@GenerateMocks([Dio])
MockDio mockDio = MockDio();

/// it's used to prepare the endpoints for the MockServer
void prepareMocks() {
  when(mockDio.get('$baseUrl/posts')).thenAnswer((_) => Future.value(Response(
      requestOptions: RequestOptions(path: '$baseUrl/posts'),
      data: [textPostS, oneImagePostS, manyImagePostS],
      statusCode: 200)));

  when(mockDio.post('$baseUrl/vote', data: anyNamed('data')))
      .thenAnswer((_) => Future.value(Response(
          requestOptions: RequestOptions(path: '$baseUrl/vote'),
          data: {
            'id': 1,
            'type': 'post',
          },
          statusCode: 200)));

  when(mockDio.post('$baseUrl/save', data: anyNamed('data')))
      .thenAnswer((_) => Future.value(Response(
          requestOptions: RequestOptions(path: '$baseUrl/save'),
          data: {
            'id': 1,
            'type': 'post',
          },
          statusCode: 200)));

  when(mockDio.post('$baseUrl/hide', data: anyNamed('data')))
      .thenAnswer((_) => Future.value(Response(
          requestOptions: RequestOptions(path: '$baseUrl/hide'),
          data: {
            'id': 1,
            'type': 'post',
          },
          statusCode: 200)));

  when(mockDio.post('$baseUrl/block-user', data: anyNamed('data')))
      .thenAnswer((_) => Future.value(Response(
          requestOptions: RequestOptions(path: '$baseUrl/block'),
          data: {
            'id': 1,
            'type': 'post',
          },
          statusCode: 200)));

  when(mockDio.post('$baseUrl/delete', data: anyNamed('data')))
      .thenAnswer((_) => Future.value(Response(
          requestOptions: RequestOptions(path: 'path'),
          data: {
            'id': 1,
            'type': 'post',
          },
          statusCode: 200)));
}
