import 'package:flutter_dotenv/flutter_dotenv.dart';

class ListAPI {
  ListAPI._();

  static const String baseUrl = "http://192.168.1.126:8001/api/v1/";
  // static const String BASE_URL = "http://192.168.1.143:8001/api/v1/";



  static const String accessToken = 'access-token';


  // static String get baseUrl => dotenv.env['TASK_BASE_URL'] ?? '';

  static String get sentryDsn => dotenv.env['SENTRY_DSN'] ?? '';


  static const String verify = 'auth/verify-registration';
  static const String login = 'users/login/employee/';
  static const String getOtp = 'auth/login';
  static const yandexApiKey = 'add463f9-4251-48c0-bc81-b50118e14589';
  static const googleDirectionApi = 'AIzaSyBkKTsCUTP3biLpL8FeHv__IsQK_nGgIyo';







}

