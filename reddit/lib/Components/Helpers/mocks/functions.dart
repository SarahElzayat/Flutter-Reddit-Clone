import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:reddit/constants/constants.dart';
import 'package:reddit/components/helpers/mocks/post_cubit.mocks.dart';
import 'package:reddit/data/temp_data/tmp_data.dart';

MockDio mockDio = MockDio();
@GenerateMocks([Dio])

/// it's used to prepare the endpoints for the MockServer
void prepareMocks() {
  when(mockDio.get('$base/posts')).thenAnswer((_) => Future.value(Response(
      requestOptions: RequestOptions(path: '$base/posts'),
      data: [textPostS, oneImagePostS, manyImagePostS],
      statusCode: 200)));
}
