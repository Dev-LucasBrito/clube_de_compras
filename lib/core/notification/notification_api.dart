import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';

class NotificaionApi {
  static final _notificaions = FlutterLocalNotificationsPlugin();
  static final onNotification = BehaviorSubject<String>();

  static Future _notificationDetails() async {
    return const NotificationDetails(
        android: AndroidNotificationDetails('channel id', 'channel name',
            channelDescription: 'channel description',
            importance: Importance.max),
        iOS: DarwinNotificationDetails());
  }

  static Future innit({bool initScheduled = false}) async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iOS = DarwinInitializationSettings();

    const settings = InitializationSettings(android: android, iOS: iOS);

    await _notificaions.initialize(
      settings,
      onDidReceiveBackgroundNotificationResponse: (payload) async {},
      onDidReceiveNotificationResponse: (payload) async {},
    );
  }

  static Future showNotification(
          {int id = 0, String? title, String? body, String? payload}) async =>
      _notificaions.show(id, title, body, await _notificationDetails(),
          payload: payload);
}
