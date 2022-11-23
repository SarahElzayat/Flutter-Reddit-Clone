/// @author Abdelaziz Salah
/// @date 3/11/2022
/// this is a file contaning the constant baseURL and the endpoints of the API

const portNumber = String.fromEnvironment('portNumber', defaultValue: '5000');
// const baseUrl = String.fromEnvironment('baseURL',
//     defaultValue: 'https://54efd1bb-baf6-4622-9692-b43958dee9f0.mock.pstmn.io');
const baseUrl = 'https://56518a9b-3e47-4235-8283-e465893f3f94.mock.pstmn.io';
const signUp = '/signup';
const login = '/login';
const loginForgetPassword = '/login/forget-password';
const loginForgetUserName = '/login/forget-username';
const createCommunity = '/create-subreddit';
