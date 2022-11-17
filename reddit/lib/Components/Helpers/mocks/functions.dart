import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:reddit/constants/constants.dart';
import 'package:reddit/widgets/posts/cubit/post_cubit.mocks.dart';
import 'package:reddit/Data/temp_data/tmp_data.dart';

MockDio mockDio = MockDio();
@GenerateMocks([Dio])
void prepare_mocks() {
  when(mockDio.get('$base/posts')).thenAnswer((_) => Future.value(Response(
      requestOptions: RequestOptions(path: '$base/posts'),
      data: '''[
        $textPostS ,
      ]''',
      statusCode: 200)));
}
