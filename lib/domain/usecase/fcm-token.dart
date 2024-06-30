import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:realtbox/config/resources/constants/string_constants.dart';
import 'package:realtbox/config/services/local_storage.dart';
import 'package:realtbox/core/usecase/usecase.dart';

class GetFcmToken implements UseCase<String, String> {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  @override
  Future<String> call({String? params}) async {
    String fcmToken = LocalStorage.getString(StringConstants.fcmToken);
    if (fcmToken.isEmpty) {
      await firebaseMessaging.getToken().then((token) async => {
            fcmToken = token ?? "",
            await LocalStorage.setString(StringConstants.fcmToken, fcmToken),
          });
    }
    return fcmToken;
  }
}
