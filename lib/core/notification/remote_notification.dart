// import 'dart:io';
//
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:go_router/go_router.dart';
// import 'package:lorry_driver_mini/core/routes/routes.dart';
//
//
// class FirebaseApi {
//   final messaging = FirebaseMessaging.instance;
//
//
//   Future<void> init() async {
//     // Request notification permissions
//     NotificationSettings settings = await messaging.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//
//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//
//
//       if(Platform.isAndroid){
//         String? fcmToken = await messaging.getToken();
//         print("FCM Token: $fcmToken");
//       }
//
//       String? apnsToken = await messaging.getAPNSToken();
//       print("APNs Token: $apnsToken");
//
//       initPushNotification();
//     } else {
//       print("Permission denied for notifications.");
//     }
//   }
//
//   void handleMessage(RemoteMessage? message) {
//     if (message == null) return;
//
//     rootNavigatorKey.currentState?.context.go(Routes.home);
//     // Handle message and navigate to a screen if needed
//
//   }
//
//   Future<void> initPushNotification() async {
//     FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
//
//     FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
//   }
// }
