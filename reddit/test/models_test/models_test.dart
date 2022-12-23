import 'package:flutter_test/flutter_test.dart';
import 'package:reddit/data/home/drawer_communities_model.dart';
import 'package:reddit/data/mod_in_post_models/lock_model.dart';
import 'package:reddit/data/mod_in_post_models/mark_nsfw_model.dart';
import 'package:reddit/data/post_model/approve.dart';
import 'package:reddit/data/post_model/flair.dart';
import 'package:reddit/data/post_model/image.dart';
import 'package:reddit/data/post_model/insights_model.dart';
import 'package:reddit/data/post_model/remove.dart';
import 'package:reddit/data/saved/saved_comments_model.dart';
import 'package:reddit/data/search/search_result_profile_model.dart';
import 'package:reddit/data/search/search_result_subbredit_model.dart';

void main() {
  group('models test', () {
    test('drawer model test', () {
      final data = {
        'title': 'sarsora',
        'picture': 'string',
        'members': 0,
        'isFavorite': true
      };

      final DrawerCommunitiesModel model =
          DrawerCommunitiesModel.fromJson(data);

      expect(model.title, 'sarsora');
      expect(model.members, 0);
      expect(model.picture, 'string');
      expect(model.isFavorite, true);
      Map<String, dynamic> m = model.toJson();

      expect(m, data);
    });
    test('search result profile test', () {
      final data = {
        'id': '13245678',
        'data': {
          'id': 'string',
          'username': 'string',
          'karma': 0,
          'nsfw': true,
          'joinDate': '2019-08-24T14:15:22Z',
          'following': true,
          'avatar': 'avatar'
        }
      };

      final SearchResultProfileModel model =
          SearchResultProfileModel.fromJson(data);

      expect(model.id, '13245678');
      expect(model.data?.avatar, 'avatar');
      expect(model.data?.username, 'string');
      expect(model.data?.karma, 0);
      expect(model.data?.nsfw, true);
      expect(model.data?.joinDate, '2019-08-24T14:15:22Z');
      expect(model.data?.following, true);

      Map<String, dynamic> m = model.toJson();

      expect(m, data);
    });
    test('saved comments profile test', () {
      final data = {
        'commentId': '13245678',
        'commentedBy': 'string',
        'points': 0,
        'publishTime': '2019-08-24T14:15:22Z',
        'saved': true,
        'inYourSubreddit': true,
      };

      final SavedCommentModel model = SavedCommentModel.fromJson(data);

      expect(model.commentId, '13245678');
      expect(model.commentedBy, 'string');
      expect(model.points, 0);
      expect(model.publishTime, '2019-08-24T14:15:22Z');
      expect(model.inYourSubreddit, true);
      expect(model.saved, true);
    });

    test('search  results subreddit model test', () {
      final data = {
        'id': '123',
        'data': {
          'id': 'string',
          'subredditName': 'string',
          'numberOfMembers': 0,
          'nsfw': true,
          'description': 'string',
          'joined': true,
          'profilePicture': 'profilePicture'
        }
      };

      final SearchResultSubredditModel model =
          SearchResultSubredditModel.fromJson(data);

      expect(model.id, '123');
      expect(model.data?.id, 'string');
      expect(model.data?.subredditName, 'string');
      expect(model.data?.numberOfMembers, 0);
      expect(model.data?.nsfw, true);
      expect(model.data?.description, 'string');
      expect(model.data?.joined, true);
      expect(model.data?.profilePicture, 'profilePicture');
      Map<String, dynamic> m = model.toJson();

      expect(m, data);
    });

    test('search profile results model test', () {
      final data = {
        'id': '123',
        'data': {
          'id': 'string',
          'username': 'string',
          'karma': 0,
          'nsfw': true,
          'joinDate': '2019-08-24T14:15:22Z',
          'following': true,
          'avatar': 'string'
        }
      };

      final SearchResultProfileModel model =
          SearchResultProfileModel.fromJson(data);

      expect(model.id, '123');
      expect(model.data?.id, 'string');
      expect(model.data?.username, 'string');
      expect(model.data?.karma, 0);
      expect(model.data?.nsfw, true);
      expect(model.data?.joinDate, '2019-08-24T14:15:22Z');
      expect(model.data?.following, true);
      expect(model.data?.avatar, 'string');
      Map<String, dynamic> m = model.toJson();

      expect(m, data);
    });

    test('approve model test', () {
      final data = {
        'approvedBy': 'sarah',
        'approvedDate': '2019-08-24T14:15:22Z',
      };

      final Approve model = Approve.fromJson(data);

      expect(model.approvedBy, 'sarah');

      expect(model.approvedDate, '2019-08-24T14:15:22Z');

      Map<String, dynamic> m = model.toJson();

      expect(m, data);
    });

    test('Lock model test', () {
      final data = {
        'id': '3ad165sa',
        'type': 'type',
      };

      final LockModel model = LockModel.fromJson(data);

      expect(model.id, '3ad165sa');

      expect(model.type, 'type');

      Map<String, dynamic> m = model.toJson();

      expect(m, data);
    });
    test('MarkNSFW model test', () {
      final data = {
        'id': '3ad165sa',
      };

      final MarkNSFWModel model = MarkNSFWModel.fromJson(data);

      expect(model.id, '3ad165sa');

      Map<String, dynamic> m = model.toJson();

      expect(m, data);
    });

    test('Insights model test', () {
      final data = {
        'totalViews': 5,
        'upvoteRate': 4,
        'communityKarma': 3,
        'totalShares': 2
      };

      final InsightsModel model = InsightsModel.fromJson(data);

      expect(model.totalViews, 5);
      expect(model.upvoteRate, 4);
      expect(model.communityKarma, 3);
      expect(model.totalShares, 2);

      Map<String, dynamic> m = model.toJson();

      expect(m, data);
    });
    test('Image model test', () {
      final data = {'path': 'string', 'caption': 'string', 'link': 'string'};

      final Image model = Image.fromJson(data);

      expect(model.path, 'string');
      expect(model.caption, 'string');
      expect(model.link, 'string');

      Map<String, dynamic> m = model.toJson();

      expect(m, data);
    });
    test('Remove model test', () {
      final data = {'removedBy': 'sarah', 'removedDate': '2019-08-24T14:15:22Z'};

      final Remove model = Remove.fromJson(data);

      expect(model.removedBy, 'sarah');
      expect(model.removedDate, '2019-08-24T14:15:22Z');

      Map<String, dynamic> m = model.toJson();

      expect(m, data);
    });

    test('flair model test', () {
      final data = {
        'id': '13245',
        'flairName': 'redFlair',
        'order': 2,
        'backgroundColor': 'blue',
        'textColor': 'red'
      };

      final Flair model = Flair.fromJson(data);

      expect(model.id, '13245');
      expect(model.flairName, 'redFlair');
      expect(model.order, 2);
      expect(model.backgroundColor, 'blue');
      expect(model.textColor, 'red');

      Map<String, dynamic> m = model.toJson();

      expect(m, data);
    });
  });
}
