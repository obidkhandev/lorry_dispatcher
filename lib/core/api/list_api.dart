import 'package:flutter_dotenv/flutter_dotenv.dart';

class ListAPI {
  ListAPI._();

  // static const String baseUrl = "https://location.globalgreentour.uz/api/v1/";
  // static const String BASE_URL = "http://192.168.1.143:8001/api/v1/";



  static String get baseUrl => dotenv.env['TASK_BASE_URL'] ?? '';
  static String get TaskBaseUrl => dotenv.env['TASK_BASE_URL'] ?? '';

  static String get sentryDsn => dotenv.env['SENTRY_DSN'] ?? '';


  static const String verify = 'auth/verify-registration';
  static const String login = 'users/login/employee/';
  static const String getMe = 'users/getme/';





}

