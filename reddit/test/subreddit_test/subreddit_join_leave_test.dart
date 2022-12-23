import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:reddit/cubit/subreddit/cubit/subreddit_cubit.dart';
import 'package:reddit/data/temp_data/tmp_data.dart';
import 'package:reddit/components/helpers/mocks/mock_functions.dart';
import 'package:reddit/networks/dio_helper.dart';

@GenerateMocks([DioHelper])
void main() {
  prepareMocks();

  group('Join And Leave Community ', () {
    prepareMocks();
    test('join', () async {
      var subredditCubit = SubredditCubit();
      subredditCubit.subreddit = subredditTempData;
      subredditCubit.subredditName = 'News';

      when(mockDio.post('/join-subreddit', data: anyNamed('data'))).thenAnswer(
          (_) => Future.value(Response(
              requestOptions: RequestOptions(path: '/join-subreddit'),
              data: {},
              statusCode: 200)));
      expect(subredditCubit.subreddit!.isMember, false);

      await subredditCubit.joinCommunity(isTesting: true).then((value) {
        expect(subredditCubit.subreddit!.isMember, true);
      });
    });

    test('leave', () async {
      var subredditCubit = SubredditCubit();
      subredditCubit.subreddit = subredditTempData;
      subredditCubit.subreddit!.isMember = true;

      subredditCubit.subredditName = 'News';

      when(mockDio.post('/leave-subreddit', data: anyNamed('data'))).thenAnswer(
          (_) => Future.value(Response(
              requestOptions: RequestOptions(path: '/leave-subreddit'),
              data: {},
              statusCode: 200)));
      expect(subredditCubit.subreddit!.isMember, true);

      await subredditCubit.leaveCommunity(isTesting: true).then((value) {
        expect(subredditCubit.subreddit!.isMember, false);
      });
    });
  });
}
