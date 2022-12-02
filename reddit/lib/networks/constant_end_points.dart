/// @author Abdelaziz Salah
/// @date 3/11/2022
/// this is a file contaning the constant baseURL and the endpoints of the API
import 'package:flutter/foundation.dart' show kIsWeb, kReleaseMode;

const portNumber = String.fromEnvironment('portNumber', defaultValue: '5000');
const baseUrl = kReleaseMode
    ? 'http://read-it.francecentral.cloudapp.azure.com/api/'
    : kIsWeb
        ? 'http://localhost:3000'
        : 'http://10.0.2.2:3000';

const signUp = '/signup';
const login = '/login';
const loginForgetPassword = '/login/forget-password';
const loginForgetUserName = '/login/forget-username';
const createCommunity = '/create-subreddit';
