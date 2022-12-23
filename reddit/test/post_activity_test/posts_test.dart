import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:reddit/data/temp_data/tmp_data.dart';
import 'package:reddit/components/helpers/mocks/mock_functions.dart';
import 'package:reddit/networks/dio_helper.dart';
import 'package:reddit/widgets/posts/actions_cubit/post_comment_actions_cubit.dart';

@GenerateMocks([DioHelper])
void main() {
  prepareMocks();

  group('Actions in posts', () {
    prepareMocks();

    var post = textPost;
    test('upvote', () async {
      var cubit = PostAndCommentActionsCubit(post: post);
      expect(post.votes, 100);

      await cubit.vote(oldDir: 1, isTesting: true).then((value) {
        expect(post.votes, 101);
      });

      await cubit.vote(oldDir: 1, isTesting: true).then((value) {
        expect(post.votes, 100);
      });

      // testing an invalid status code
      when(mockDio.post('/vote', data: anyNamed('data')))
          .thenAnswer((_) => Future.value(Response(
              requestOptions: RequestOptions(path: '/vote'),
              data: {
                'id': 1,
                'type': 'post',
              },
              statusCode: 400)));

      await cubit.vote(oldDir: 1, isTesting: true).then((value) {
        expect(post.votes, 100);
      });
    });

    test('downvote', () async {
      prepareMocks();

      var post = oneImagePost;
      var cubit = PostAndCommentActionsCubit(post: post);
      expect(post.votes, 100);

      await cubit.vote(oldDir: -1, isTesting: true).then((value) {
        expect(post.votes, 99);
      });

      await cubit.vote(oldDir: -1, isTesting: true).then((value) {
        expect(post.votes, 100);
      });

      // testing an invalid status code
      when(mockDio.post('/vote', data: anyNamed('data')))
          .thenAnswer((_) => Future.value(Response(
              requestOptions: RequestOptions(path: '/vote'),
              data: {
                'id': 71,
                'type': 'post',
              },
              statusCode: 400)));

      await cubit.vote(oldDir: -1, isTesting: true).then((value) {
        expect(post.votes, 100);
      });
    });

    test('save posts', () async {
      var cubit = PostAndCommentActionsCubit(post: post);
      expect(post.saved, false);

      when(mockDio.post('/save', data: anyNamed('data')))
          .thenAnswer((_) => Future.value(Response(
              requestOptions: RequestOptions(path: '/vote'),
              data: {
                'id': 1,
                'type': 'post',
              },
              statusCode: 200)));

      await cubit.save(isTesting: true).then((value) {
        expect(post.saved, true);
      });

      when(mockDio.post('/unsave', data: anyNamed('data')))
          .thenAnswer((_) => Future.value(Response(
              requestOptions: RequestOptions(path: '/vote'),
              data: {
                'id': 1,
                'type': 'post',
              },
              statusCode: 200)));

      await cubit.save(isTesting: true).then((value) {
        expect(post.saved, false);
      });
    });

    test('hide posts', () async {
      var cubit = PostAndCommentActionsCubit(post: post);
      expect(post.hidden, false);

      when(mockDio.post('/hide', data: anyNamed('data')))
          .thenAnswer((_) => Future.value(Response(
              requestOptions: RequestOptions(path: '/vote'),
              data: {
                'id': 1,
                'type': 'post',
              },
              statusCode: 200)));

      await cubit.hide(isTesting: true).then((value) {
        expect(post.hidden, true);
      });

      when(mockDio.post('/unhide', data: anyNamed('data')))
          .thenAnswer((_) => Future.value(Response(
              requestOptions: RequestOptions(path: '/vote'),
              data: {
                'id': 1,
                'type': 'post',
              },
              statusCode: 200)));

      await cubit.hide(isTesting: true).then((value) {
        expect(post.hidden, false);
      });
    });

    test('follow post', () async {
      var cubit = PostAndCommentActionsCubit(post: post);
      expect(post.followed, false);

      when(mockDio.post('/follow-post', data: anyNamed('data')))
          .thenAnswer((_) => Future.value(Response(
              requestOptions: RequestOptions(path: '/follow-post'),
              data: {
                'id': 1,
                'type': 'post',
              },
              statusCode: 200)));

      await cubit.follow(isTesting: true).then((value) {
        expect(post.followed, true);
      });

      await cubit.follow(isTesting: true).then((value) {
        expect(post.followed, false);
      });
    });
  });
}
