import 'package:dio/dio.dart';
// ignore: depend_on_referenced_packages
import 'package:mockito/annotations.dart';
// ignore: depend_on_referenced_packages
import 'package:mockito/mockito.dart';
import 'package:reddit/components/helpers/mocks/post_cubit.mocks.dart';
import 'package:reddit/data/temp_data/tmp_data.dart';

@GenerateMocks([Dio])
MockDio mockDio = MockDio();

/// it's used to prepare the endpoints for the MockServer
void prepareMocks() {
  when(mockDio.get('/posts')).thenAnswer((_) => Future.value(Response(
      requestOptions: RequestOptions(path: '/posts'),
      data: [textPostS, oneImagePostS, manyImagePostS],
      statusCode: 200)));

  when(mockDio.post('/vote', data: anyNamed('data')))
      .thenAnswer((_) => Future.value(Response(
          requestOptions: RequestOptions(path: '/vote'),
          data: {
            'id': 1,
            'type': 'post',
          },
          statusCode: 200)));

  when(mockDio.post('/save', data: anyNamed('data')))
      .thenAnswer((_) => Future.value(Response(
          requestOptions: RequestOptions(path: '/save'),
          data: {
            'id': 1,
            'type': 'post',
          },
          statusCode: 200)));

  when(mockDio.post('/hide', data: anyNamed('data')))
      .thenAnswer((_) => Future.value(Response(
          requestOptions: RequestOptions(path: '/hide'),
          data: {
            'id': 1,
            'type': 'post',
          },
          statusCode: 200)));

  when(mockDio.post('/block-user', data: anyNamed('data')))
      .thenAnswer((_) => Future.value(Response(
          requestOptions: RequestOptions(path: '/block'),
          data: {
            'id': 1,
            'type': 'post',
          },
          statusCode: 200)));

  when(mockDio.post('/delete', data: anyNamed('data')))
      .thenAnswer((_) => Future.value(Response(
          requestOptions: RequestOptions(path: 'path'),
          data: {
            'id': 1,
            'type': 'post',
          },
          statusCode: 200)));
}
