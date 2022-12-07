import 'package:flutter_lorem/flutter_lorem.dart';

import '../post_model/flair.dart';
import '../post_model/image.dart';
import '../post_model/post_model.dart';

var textPost = PostModel(
  id: '1852',
  kind: 'text',
  title: 'this is the title',
  content: ''' This is a content <br />
      **This IS BOLD** <br />
      *this is italic* <br />
      ***THIS IS BOLD AND ITALIC***
      ''',
  subreddit: 'Flutter',
  postedBy: 'username',
  postedAt: '2019-08-24T14:15:22Z',
  editedAt: '2019-08-24T14:15:22Z',
  flair: Flair(
    flairId: '123',
    flairText: 'flair',
    backgroundColor: '#FFAA00',
    textColor: '#0E0EEE',
  ),
  saved: false,
  spoiler: true,
  inYourSubreddit: false,
  nsfw: false,
  votes: 100,
  comments: 10,
);

final textPostS = textPost.toJson();

var oneImagePost = PostModel(
  id: '12',
  kind: 'image',
  title: 'That\'s a Post with only image inside it',
  content: lorem(paragraphs: 1, words: 50),
  subreddit: 'Flutter',
  postedBy: 'username',
  postedAt: '2019-08-24T14:15:22Z',
  editedAt: '2019-08-24T14:15:22Z',
  nsfw: true,
  spoiler: true,
  saved: false,
  inYourSubreddit: true,
  votes: 100,
  images: [
    Image(
      path:
          'https://64.media.tumblr.com/7d77944920bae961e2a65f6d514a7f25/7540b63eed43b6ed-9f/s640x960/68699e754f8f1594af48a195ec689a3280ae7a86.jpg',
      caption: 'This is a caption',
      link: 'https://www.google.com',
    ),
  ],
  comments: 90,
);

final oneImagePostS = oneImagePost.toJson();

var manyImagePost = PostModel(
  id: '55',
  title: 'That\'s a Post with Many image inside it',
  kind: 'image',
  content: lorem(paragraphs: 1, words: 50),
  subreddit: 'Flutter',
  postedBy: 'username',
  postedAt: '2019-08-24T14:15:22Z',
  editedAt: '2019-08-24T14:15:22Z',
  flair: Flair(
    flairId: '123',
    flairText: 'many cats',
    backgroundColor: '#AA00A0',
    textColor: '#FFBBAA',
  ),
  saved: false,
  inYourSubreddit: false,
  votes: 100,
  images: [
    Image(
      path:
          'https://64.media.tumblr.com/9ea589bdca3e1f1040eb3c2c273b7dda/2301f59dbcdbbb03-da/s250x400/7091c7b7bbdaff9eb063d9ecc9aca8b095231ca8.pnj',
      caption: 'This is a caption',
      link: 'https://www.google.com',
    ),
    Image(
      path:
          'https://64.media.tumblr.com/9d3b0bcd09630bb3333acdfc0b01acdf/2301f59dbcdbbb03-5c/s250x400/16f00d0086c5323253637301a80fc8863e93bab2.jpg',
      caption: 'This is a caption',
    ),
    Image(
      path:
          'https://64.media.tumblr.com/a793d94cf38c3578abca78b4727d4103/2301f59dbcdbbb03-c8/s1280x1920/ef7033154e2846f3363707dc80d40ea1fda358ac.pnj',
      caption: 'This is a caption',
      link: 'https://www.google.com',
    ),
    Image(
      path:
          'https://64.media.tumblr.com/c7b44e4a27755ea3c881c407be1a67e2/2301f59dbcdbbb03-a6/s250x400/9b9536084d945c46b26ba9775eb2d27663468e1f.pnj',
    ),
    Image(
      path:
          'https://64.media.tumblr.com/5e21c9103fc32397c2db50a5b41a20ba/2301f59dbcdbbb03-bb/s250x400/dbbdacfe8e1110b50a98e317533fdb35dd6aed81.pnj',
      caption: 'This is a caption',
      link: 'https://www.google.com',
    ),
    Image(
      path:
          'https://64.media.tumblr.com/be349c2b88f4fe777738e7ceb4af7b03/2301f59dbcdbbb03-3a/s1280x1920/8f0ac6a9538222a4bded941953e0adc26dfb36d1.pnj',
    ),
  ],
  comments: 100,
);

final manyImagePostS = manyImagePost.toJson();

var linkPost = PostModel(
  id: '185223',
  kind: 'link',
  title: lorem(paragraphs: 1, words: 24),
  content: 'https://github.com/',
  subreddit: 'Flutter',
  postedBy: 'username',
  postedAt: '2019-08-24T14:15:22Z',
  editedAt: '2019-08-24T14:15:22Z',
  flair: Flair(
    flairId: '123',
    flairText: 'flair',
    backgroundColor: '#FFAA00',
    textColor: '#0E0EEE',
  ),
  saved: false,
  spoiler: true,
  inYourSubreddit: true,
  nsfw: false,
  votes: 100,
  comments: 10,
);

final linkPostS = linkPost.toJson();
