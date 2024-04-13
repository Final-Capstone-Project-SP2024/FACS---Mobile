import 'package:facs_mobile/services/user_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:facs_mobile/utils/notification_database.dart';
import 'package:facs_mobile/firebase_options.dart';
import 'package:facs_mobile/themes/theme.dart';
import 'package:facs_mobile/routes/routes.dart';
import 'package:facs_mobile/pages/sign_in.dart';
import 'package:facs_mobile/pages/onBoarding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:facs_mobile/routeObserver.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

Future<void> _saveNotificationToStorage(RemoteMessage message) async {
  try {
    final notificationData = {
      'title': message.notification?.title ?? '',
      'body': message.notification?.body ?? '',
    };
    await NotificationDatabase.instance.insertNotification(notificationData);
  } catch (e) {
    print("Error saving notification to storage: $e");
  }
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  DatabaseReference databaseReference = FirebaseDatabase.instance.reference();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print(
          'Message also contained a notification: ${message.notification.toString()}');
      _saveNotificationToStorage(message);
      flutterLocalNotificationsPlugin.show(
        0,
        message.notification!.title,
        message.notification!.body,
        NotificationDetails(
          android: AndroidNotificationDetails('facs_channel', 'FACS Alarm',
              channelDescription:
                  "Receive notifications about fire related information.",
              importance: Importance.max,
              priority: Priority.high,
              icon: 'ic_launcher'),
        ),
      );
    }
  });
  String? token = await messaging.getToken();
  print('Token: $token');
  if (token != null) {
    UserServices.fcmToken = token;
    await databaseReference.child('tokens').push().set({'token': token});
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FACS Mobile',
      themeMode: ThemeMode.system,
      theme: customLightTheme,
      navigatorObservers: [routeObserver],
      home: FutureBuilder<bool>(
        future: checkOnboardingCompleted(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Or any loading indicator
          } else {
            if (snapshot.data == true) {
              return SignIn(); // Skip onboarding if completed
            } else {
              return OnBoarding(); // Show onboarding if not completed
            }
          }
        },
      ),
      darkTheme: customDarkTheme,
      //initialRoute: "/onboarding",
      onGenerateRoute: generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
  Future<bool> checkOnboardingCompleted() async {
     false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? onboardingCompleted = prefs.getBool('onboardingCompleted');
    return onboardingCompleted ?? false;
  }
}
