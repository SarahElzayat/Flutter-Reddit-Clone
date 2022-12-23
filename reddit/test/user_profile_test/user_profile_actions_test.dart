import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:reddit/cubit/user_profile/cubit/user_profile_cubit.dart';
import 'package:reddit/data/temp_data/tmp_data.dart';
import 'package:reddit/components/helpers/mocks/mock_functions.dart';
import 'package:reddit/networks/dio_helper.dart';

@GenerateMocks([DioHelper])
void main() {
  prepareMocks();

  group('User Profile Actions ', () {
    prepareMocks();
    test('Follow', () async {
      var userProfileCubit = UserProfileCubit();
      userProfileCubit.userData = userProfileData;
      userProfileCubit.username = 'haitham';

      when(mockDio.post('/follow-user', data: anyNamed('data'))).thenAnswer(
          (_) => Future.value(Response(
              requestOptions: RequestOptions(path: '/follow-user'),
              data: {},
              statusCode: 200)));
      expect(userProfileCubit.userData!.followed, false);

      await userProfileCubit
          .followOrUnfollowUser(true, isTesting: true)
          .then((value) {
        expect(userProfileCubit.userData!.followed, true);
      });
    });

    test('Unfollow', () async {
      var userProfileCubit = UserProfileCubit();
      userProfileCubit.userData = userProfileData;
      userProfileCubit.username = 'haitham';
      userProfileCubit.userData!.followed = true;

      when(mockDio.post('/follow-user', data: anyNamed('data'))).thenAnswer(
          (_) => Future.value(Response(
              requestOptions: RequestOptions(path: '/follow-user'),
              data: {},
              statusCode: 200)));
      expect(userProfileCubit.userData!.followed, true);

      await userProfileCubit
          .followOrUnfollowUser(false, isTesting: true)
          .then((value) {
        expect(userProfileCubit.userData!.followed, false);
      });
    });
  });
}
