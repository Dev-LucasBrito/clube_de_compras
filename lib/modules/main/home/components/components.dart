import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeComponent(),
    );
  }
}

class HomeComponent extends StatefulWidget {
  @override
  _HomeComponentState createState() => _HomeComponentState();
}

class _HomeComponentState extends State<HomeComponent> {
  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin!.initialize(initializationSettings,);
  }

  Future onSelectNotification(String payload) async {
    // Implemente a lógica desejada ao clicar na notificação
    print("Notificação clicada! Payload: $payload");
  }

 

   Future _showNotification2() async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      channelDescription: 'channel_description',
      importance: Importance.max,
      priority: Priority.high,
    );

    var iOSPlatformChannelSpecifics = DarwinNotificationDetails(
      attachments: []
    );

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin!.show(
      0,
      'Cashback recebido!',
      'Você recebeu R\$33,00 do Petit Poá.',
      platformChannelSpecifics,
      payload: 'Custom_Sound',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Local Notifications'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: ()async {
           
            
             await Future.delayed(const Duration(seconds: 20), (){
              _showNotification2();
             });
               
          },
          child: Text('Mostrar Notificação'),
        ),
      ),
    );
  }
}
