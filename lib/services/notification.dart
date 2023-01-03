import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:app_shipper/core/constants/key_constant.dart';
import 'package:app_shipper/services/share_preferences_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> onBackgroundMessage(RemoteMessage message) async {
  await Firebase.initializeApp();

  if (message.data.containsKey('data')) {
    // Xử lý thông báo dữ liệu
    final data = message.data['data'];
  }

  if (message.data.containsKey('notification')) {
    final notification = message.data['notification'];
  }
}

class FCM {
  final streamController = StreamController<String>.broadcast();
  final titleController = StreamController<String>.broadcast();
  final bodyController = StreamController<String>.broadcast();
  final _preferences = PreferencesService();

  setNotifications() {
    FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);

    // Xử lý khi ứng dụng ở trạng thái hoạt động
    foregroundNotification();

    // Xử lý khi ứng dụng đang chạy trong nền
    backgroundNotification();

    // Xử lý khi người dùng đóng ứng dụng hoặc chấm dứt
    terminateNotification();
  }

  foregroundNotification() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('message: $message');
      print('mess'+ message.data.toString());
      if (message.data.containsKey('data')) {
        // Xử lý thông báo dữ liệu
        final data = message.data['data'];
        streamController.sink.add(data);
      }
      if (message.data.containsKey('notification')) {
        final notification = message.data['notification'];
        streamController.sink.add(notification);
      }
      titleController.sink.add(message.notification!.title!);
      bodyController.sink.add(message.notification!.body!);
    });
  }

  backgroundNotification() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('message: $message');
      print('mess'+ message.data.toString());
      if (message.data.containsKey('data')) {
        // Xử lý thông báo dữ liệu
        final data = message.data['data'];
        streamController.sink.add(data);
      }
      if (message.data.containsKey('notification')) {
        final notification = message.data['notification'];
        streamController.sink.add(notification);
      }
      titleController.sink.add(message.notification!.title!);
      bodyController.sink.add(message.notification!.body!);
    });
  }

  terminateNotification() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      if (initialMessage.data.containsKey('data')) {
        // Xử lý thông báo dữ liệu
        final data = initialMessage.data['data'];
        streamController.sink.add(data);
      }
      if (initialMessage.data.containsKey('notification')) {
        final notification = initialMessage.data['notification'];
        streamController.sink.add(notification);
      }
      titleController.sink.add(initialMessage.notification!.title!);
      bodyController.sink.add(initialMessage.notification!.body!);
    }
  }

  getToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // use the returned token to send messages to users from your custom server
    String? token = await messaging.getToken(
      vapidKey: KeyConstant.KEY_VAPID_KEY,
    );
    _preferences.setTokenFirebase(token!);
    print('token: $token');
  }
}
