/// @author Abdelaziz Salah
/// @date 3/11/2022
/// this is a file contaning the constant baseURL and the endpoints of the API
import 'package:flutter/foundation.dart' show kIsWeb, kReleaseMode;

const portNumber = String.fromEnvironment('FLUTTER_PORT', defaultValue: '5000');
// const baseUrl = String.fromEnvironment('BASE_URL',
//     defaultValue: 'http://localhost:3000'); // for the web
// String.fromEnvironment('BASE_URL', defaultValue: 'http://10.0.2.2:3000'); // for mobile
// const portNumber = 5000;
const baseUrl = kReleaseMode
    ? 'http://www.read-it.live/api'
    : kIsWeb
        ? 'http://localhost:3000'
        : 'http://10.0.2.2:3000';

const signUp = '/signup';
const login = '/login';
const loginForgetPassword = '/login/forget-password';
const loginForgetUserName = '/login/forget-username';
const createCommunity = '/create-subreddit';
const savedCategories = '/saved-categories';
const markSpoiler = '/mark-spoiler';
const unmarkSpoiler = '/unmark-spoiler';
const markNSFW = '/mark-nsfw';
const unmarkNSFW = '/unmark-nsfw';
const lock = '/lock';
const unlock = '/unlock';
const pinPost = '/pin-post';
const remove = '/remove';
const approve = '/approve';
const submitPost = '/submit';
const user = '/user';
const recentHistory = '/history';
const upvotedHistory = '/upvoted';
const downvotedHistory = '/downvoted';
const hiddenHistory = '/hidden';
const clearHistory = '/clear-history';
const search = '/search';
const searchPosts = 'post';
const searchUsers = 'user';
const searchComments = 'comment';
const searchCommunities = 'community';
const postDetails = '/post-details';

const unknownAvatar =
    'https://www.investopedia.com/thmb/qDGHg2MCiUni812bkWihr-qdBbM=/1600x900/filters:no_upscale():max_bytes(150000):strip_icc()/Reddit-Logo-e9537b96b55349ac8eb77830f8470c95.jpg';
// const savedPosts = ''
