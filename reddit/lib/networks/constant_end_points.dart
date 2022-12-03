/// @author Abdelaziz Salah
/// @date 3/11/2022
/// this is a file contaning the constant baseURL and the endpoints of the API

const portNumber = String.fromEnvironment('FLUTTER_PORT', defaultValue: '5000');
const baseUrl = String.fromEnvironment('BASE_URL',
    defaultValue: 'http://localhost:3000'); // for the web
// String.fromEnvironment('BASE_URL', defaultValue: 'http://10.0.2.2:3000'); // for mobile

const signUp = '/signup';
const login = '/login';
const loginForgetPassword = '/login/forget-password';
const loginForgetUserName = '/login/forget-username';
const createCommunity = '/create-subreddit';
