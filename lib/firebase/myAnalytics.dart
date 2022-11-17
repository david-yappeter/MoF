import 'package:firebase_analytics/firebase_analytics.dart';

class MyFirebaseAnalytics {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  Future<void> maketransactionlogEvent() async {
    await analytics.logEvent(name: "user_make_transaction");
    print("Send Event");
  }

  Future<void> setUserID(_value) async {
    await analytics.setUserId(id: '$_value');
    print("Send User ID");
  }

  Future<void> testAppInstanceId() async {
    String? id = await analytics.appInstanceId;
    if (id != null) {
      print('appInstanceId succeeded: $id');
    } else {
      print('appInstanceId failed, consent declined');
    }
  }

  Future<void> newUserIDlogEvent(_value) async {
    await analytics.logEvent(name: "welcome_$_value");
    print("Welcome user$_value");
  }

  Future<void> setUserId(_value) async {
    await analytics.setUserId(id: '$_value');
    print("Set User ID");
  }
}
