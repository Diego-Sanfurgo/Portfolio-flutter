import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:push_app/main.dart';

class PushNotificationsProvider {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final _mensajesStreamController = StreamController<String>.broadcast();
  Stream<String> get mensajesStream => _mensajesStreamController.stream;

  static Future<void> onBackgroundMessage(RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    await Firebase.initializeApp();

    print("Handling a background message: ${message.messageId}");
  }

  Future<void> onLaunch(RemoteMessage message) async {
    await Firebase.initializeApp();

    final argumento = message.data['data']['comida'] ?? 'no-data';
    _mensajesStreamController.sink.add(argumento);
  }

  Future<void> onMessage(RemoteMessage message) async {
    await Firebase.initializeApp();
    String argumento = 'no-data';

    if (Platform.isAndroid) {
      argumento = message.data['data']['comida'] ?? 'no-data';
    } else {
      argumento = message.data['comida'] ?? 'no-data';
    }
    _mensajesStreamController.sink.add(argumento);
  }

  Future<void> onResume(RemoteMessage message) async {
    await Firebase.initializeApp();

    String argumento = 'no-data';

    if (Platform.isAndroid) {
      argumento = message.data['data']['comida'] ?? 'no-data';
    } else {
      argumento = message.data['comida'] ?? 'no-data';
    }
    _mensajesStreamController.sink.add(argumento);
  }

  void main() {
    FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);
    runApp(MyApp());
  }

  initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final token = await _firebaseMessaging.getToken();
    _firebaseMessaging.getNotificationSettings();
  }

  @override
  void dispose() {
    _mensajesStreamController?.close();
  }
}
