/// @author Abdelaziz Salah
/// @date 3/11/2022
/// this is a file contaning the constant baseURL and the endpoints of the API

const portNumber = String.fromEnvironment('portNumber', defaultValue: '5000');
const baseUrl = String.fromEnvironment('baseURL',
    defaultValue: 'https://dbc799b3-c5d4-4dc1-8421-8e8fd01421ef.mock.pstmn.io');
const signUp = '/signup';
const login = '/login';
const loginForgetPassword = '/login/forget-password';
const loginForgetUserName = '/login/forget-username';
