import 'package:onesignal_flutter/onesignal_flutter.dart';

void handleSendNotification(
    {required String playerId,
    required String msg,
    required String sender}) async {
  var deviceState = await OneSignal.shared.getDeviceState();

  if (deviceState == null || deviceState.userId == null) return;

  var playerId = deviceState.userId!;

  var notification = OSCreateNotification(
    playerIds: [playerId],
    content: msg,
    heading: sender,
    // buttons: [
    //   OSActionButton(text: "test1", id: "id1"),
    //   OSActionButton(text: "test2", id: "id2")
    // ],
  );
  // var response =
  await OneSignal.shared.postNotification(notification);
  // print("Sent notification with response: $response");
}
