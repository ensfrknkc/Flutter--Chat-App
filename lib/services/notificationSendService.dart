import 'package:kbu_app/model/message.dart';
import 'package:kbu_app/model/user_model.dart';
import 'package:http/http.dart' as http;

class NotificationSendService {
  Future<bool> sendNotification(
      Message notification, UserModel senderUser, String token) async {
    String endUrl = "https://fcm.googleapis.com/fcm/send";
    String firebaseKey =
        "AAAAJiIQUhc:APA91bG6d4b6McFdnOwddUcTLhTOAcb6BRyOjf9smqw1E1HhAFK4jEKvnT6qS4rpa4D7mCHOJgb4DjjvY3fNDDAhjEBPOK22zLK0OfcGnTw5vm_7BHIlmQS7Sme4Ol7_Vymwdzj2m_uA";
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": "key=$firebaseKey"
    };
    String json =
        '{"to":"$token","data":{"message":"${notification.message}","title":"${senderUser.userName} ","profilURL":"${senderUser.profileURL}","senderUserID":"${senderUser.userID}"}}';

    http.Response response =
        await http.post(endUrl, headers: headers, body: json);
    if (response.statusCode == 200) {
      print("işlem başarılı");
    } else {
      print("işlem başarısız :" + response.statusCode.toString());
      print("jsonumuz :" + json);
    }
    return true;
  }
}
