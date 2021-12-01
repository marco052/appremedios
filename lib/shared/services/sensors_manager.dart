import 'package:pharmacy_wiki/shared/services/local_notification.dart';
import 'package:sensors/sensors.dart';
import 'dart:async';

class SensorManager {
  static StreamSubscription<AccelerometerEvent>? accelerometerSubscription;
  static int subscribes = 0;
  static bool notificationSended = false;

  void accelerometerSubscribe() {
    subscribes++;
    if (accelerometerSubscription == null) {
      accelerometerSubscription = accelerometerEvents.listen((AccelerometerEvent event) {
        if (event.x + event.z >= 10 && !notificationSended) {
          LocalNotification().displayNotification('Você está dirigindo?!', 'Você recentemente tomou um remédio que pode atrapalhar o seu desempenho cognitivo no trânsito, por favor tome cuidado!');
          notificationSended = true;
          timeoutForNextNotification();
        }
      });
    }
  }

  void accelerometerUnsubscribe() {
    subscribes--;
    if (subscribes < 1 && accelerometerSubscription != null) {
      accelerometerSubscription!.cancel();
    }
  }

  void scheduleSubscribe(Duration duration) async {
    Timer(duration, accelerometerSubscribe);
  }

  void scheduleUnsubscribe(Duration duration) async {
    Timer(duration, accelerometerUnsubscribe);
  }

  void activateNotification() {
    notificationSended = false;
  }

  void timeoutForNextNotification() async {
    Timer(Duration(minutes: 15), activateNotification);
  }





}