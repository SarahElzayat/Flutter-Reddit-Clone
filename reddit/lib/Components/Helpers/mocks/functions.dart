import 'package:dio/dio.dart';
// ignore: depend_on_referenced_packages
import 'package:mockito/annotations.dart';
// ignore: depend_on_referenced_packages
import 'package:mockito/mockito.dart';
import 'package:reddit/constants/constants.dart';
import 'package:reddit/components/helpers/mocks/post_cubit.mocks.dart';
import 'package:reddit/data/temp_data/tmp_data.dart';

@GenerateMocks([Dio])
MockDio mockDio = MockDio();

/// it's used to prepare the endpoints for the MockServer
void prepareMocks() {
  when(mockDio.get('$base/posts')).thenAnswer((_) => Future.value(Response(
      requestOptions: RequestOptions(path: '$base/posts'),
      data: [textPostS, oneImagePostS, manyImagePostS],
      statusCode: 200)));

  when(mockDio.post('$base/vote', data: anyNamed('data')))
      .thenAnswer((_) => Future.value(Response(
          requestOptions: RequestOptions(path: '$base/vote'),
          data: {
            'id': 1,
            'type': 'post',
          },
          statusCode: 200)));

  when(mockDio.post('$base/save', data: anyNamed('data')))
      .thenAnswer((_) => Future.value(Response(
          requestOptions: RequestOptions(path: '$base/save'),
          data: {
            'id': 1,
            'type': 'post',
          },
          statusCode: 200)));

  when(mockDio.post('$base/hide', data: anyNamed('data')))
      .thenAnswer((_) => Future.value(Response(
          requestOptions: RequestOptions(path: '$base/hide'),
          data: {
            'id': 1,
            'type': 'post',
          },
          statusCode: 200)));

  when(mockDio.post('$base/block', data: anyNamed('data')))
      .thenAnswer((_) => Future.value(Response(
          requestOptions: RequestOptions(path: '$base/block'),
          data: {
            'id': 1,
            'type': 'post',
          },
          statusCode: 200)));

  when(mockDio.post('$base/delete', data: anyNamed('data')))
      .thenAnswer((_) => Future.value(Response(
          requestOptions: RequestOptions(path: 'path'),
          data: {
            'id': 1,
            'type': 'post',
          },
          statusCode: 200)));
}
