/// @author Abdelaziz Salah
/// @date 3/11/2022
/// this is a file contaning the constant baseURL and the endpoints of the API

const portNumber = String.fromEnvironment('portNumber', defaultValue: '3000');
const baseUrl = String.fromEnvironment('baseURL',
    defaultValue: 'http://localhost:3000');
const signUp = '/signup';
const login = '/login';
const loginForgetPassword = '/login/forget-password';
const loginForgetUserName = '/login/forget-username';