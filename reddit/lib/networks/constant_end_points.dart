/// @author Abdelaziz Salah
/// @date 3/11/2022
/// this is a file contaning the constant baseURL and the endpoints of the API
import 'package:flutter/foundation.dart' show kIsWeb, kReleaseMode;

const portNumber = String.fromEnvironment('FLUTTER_PORT', defaultValue: '5000');

const baseUrl = kReleaseMode
    ? '/api'
    // ? 'https://www.read-it.live/api'
    : kIsWeb
        // ? 'http://localhost:3000'
        ? 'https://www.read-it.live/api'
        // : 'http://10.0.2.2:3000'; // for mobile
        : 'https://www.read-it.live/api';

// : 'http://10.0.2.2:3000/';

const imagesBaseUrl =
    kReleaseMode ? 'https://www.read-it.live/' : 'http://192.168.1.8:3000/';

// login and signup
const signUp = '/signup';
const login = '/login';
const loginForgetPassword = '/login/forget-password';
const loginForgetUserName = '/login/forget-username';
const signInGoogle = '/signin/google';
const signInFacebook = '/signin/facebook';
const getRandom = '/random-username';

// settings endpoints
const changeEmail = '/change-email';
const changePassword = '/change-password';
const blockedAccounts = '/blocked-users';
const accountSettings =
    '/account-settings'; // this end point is used in multi requests.
const block = '/block-user';

// messages and inbox
const replyToMessage = '/message/compose';
const readAllMsgs = '/read-all-msgs';
const unreadMsgs = '/message/unread';
const messagesOnly = '/message/inbox';
const sentOnly = '/message/sent';

// notifications
const notificationPoint = '/notifications';
const markAllNotificationsAsRead = '/mark-all-notifications-read';
const hideNotification = '/hide-notification-read';

// messages and inbox
const messagesPoint = '/message/inbox';
const markMessageAsRead = '/unread-message';

// create community
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
const about = '/about';
const recentHistory = '/history';
const upvotedHistory = '/upvoted';
const downvotedHistory = '/downvoted';
const hiddenHistory = '/hidden';
const clearHistory = '/clear-history';
const userProfilePicture = '/profile-picture';
const userProfileBanner = '/banner-image';

const search = '/search';
const searchPosts = 'post';
const searchUsers = 'user';
const searchComments = 'comment';
const searchSubreddits = 'subreddit';
const postDetails = '/post-details';
const followUser = '/follow-user';
const joinCommunity = '/join-subreddit';
const leaveCommunity = '/leave-subreddit';
const unknownAvatar =
    'https://pbs.twimg.com/profile_images/1155645244563742721/tuCu6BT-_400x400.jpg';
// const savedPosts = ''
const ban = '/ban';
const unban = '/unban';
const inviteMod = '/moderator-invite';
const joinedSubreddits = '/joined-subreddits';
const moderatedSubreddits = '/moderated-subreddits';
// Note : after last / add the subreddit name
const subredditInfo = '/r';
const leaveSubreddit = '/leave-subreddit';
const joinSubreddit = '/join-subreddit';
const searchForSubreddit = '/search?type=subreddit';
const userDetails = '/user-details';
const homeBest = '/best';
const homeTop = '/top';
const homeHot = '/hot';
const homeTrending = '/trending';
const homeNew = '/new';
const subreddit = '/r';
const makeFavorite = '/make-favorite';
const removeFavorite = '/remove-favorite';
const socialLink = '/social-link';
