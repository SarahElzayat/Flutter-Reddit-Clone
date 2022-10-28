import 'package:reddit/posts/post_data.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

var textPost = Post(
  title: 'COME ON GUYS, KIDS ARE WATIN, MAKE ME MY Pizza',
  body: lorem(paragraphs: 1, words: 50),
  id: '123456789',
  userId: '557545467',
  subredditId: 'r/Flutter',
);

var imagePost = Post(
  title: 'COME ON GUYS, KIDS ARE WATIN, MAKE ME MY Pizza',
  body: lorem(paragraphs: 1, words: 50),
  id: '123456789',
  userId: '557545467',
  subredditId: 'r/Flutter',
  images: [
    'https://64.media.tumblr.com/9ea589bdca3e1f1040eb3c2c273b7dda/2301f59dbcdbbb03-da/s250x400/7091c7b7bbdaff9eb063d9ecc9aca8b095231ca8.pnj',
    'https://64.media.tumblr.com/9d3b0bcd09630bb3333acdfc0b01acdf/2301f59dbcdbbb03-5c/s250x400/16f00d0086c5323253637301a80fc8863e93bab2.jpg',
    'https://64.media.tumblr.com/c7b44e4a27755ea3c881c407be1a67e2/2301f59dbcdbbb03-a6/s250x400/9b9536084d945c46b26ba9775eb2d27663468e1f.pnj',
    'https://64.media.tumblr.com/5e21c9103fc32397c2db50a5b41a20ba/2301f59dbcdbbb03-bb/s250x400/dbbdacfe8e1110b50a98e317533fdb35dd6aed81.pnj'
  ],
);
