/// @author Abdelaziz Salah
/// @date 3/11/2022
/// this is a file contaning the constant baseURL and the endpoints of the API

const portNumber = String.fromEnvironment('portNumber', defaultValue: '5000');
const baseUrl =
    String.fromEnvironment('baseURL', defaultValue: 'http://10.0.2.2:3000');

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
