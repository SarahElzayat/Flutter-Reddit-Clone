import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:reddit/Data/temp_data/tmp_data.dart';
import 'package:reddit/components/helpers/mocks/functions.dart';
import 'package:reddit/constants/constants.dart';
import 'package:reddit/networks/dio_helper.dart';
import 'package:reddit/widgets/posts/cubit/post_cubit.dart';

@GenerateMocks([DioHelper])
void main() {
  prepareMocks();

  group('votes in posts', () {
    test('upvote', () async {
      prepareMocks();

      var post = textPost;
      var cubit = PostCubit(post);
      expect(post.votes, 100);

      await cubit.vote(direction: 1).then((value) {
        expect(post.votes, 101);
      });

      await cubit.vote(direction: 1).then((value) {
        expect(post.votes, 100);
      });

      // testing an invalid status code
      when(mockDio.post('$base/vote', data: anyNamed('data')))
          .thenAnswer((_) => Future.value(Response(
              requestOptions: RequestOptions(path: '$base/vote'),
              data: {
                'id': 1,
                'type': 'post',
              },
              statusCode: 400)));

      await cubit.vote(direction: 1).then((value) {
        expect(post.votes, 100);
      });
    });
    test('downvote', () async {
      prepareMocks();

      var post = oneImagePost;
      var cubit = PostCubit(post);
      expect(post.votes, 100);

      await cubit.vote(direction: -1).then((value) {
        expect(post.votes, 99);
      });

      await cubit.vote(direction: -1).then((value) {
        expect(post.votes, 100);
      });

      // testing an invalid status code
      when(mockDio.post('$base/vote', data: anyNamed('data')))
          .thenAnswer((_) => Future.value(Response(
              requestOptions: RequestOptions(path: '$base/vote'),
              data: {
                'id': 71,
                'type': 'post',
              },
              statusCode: 400)));

      await cubit.vote(direction: -1).then((value) {
        expect(post.votes, 100);
      });
    });
  });
}
