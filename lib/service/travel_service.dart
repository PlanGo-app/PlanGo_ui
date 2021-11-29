import 'package:http/http.dart' as http;
import 'package:plango_front/util/constant.dart';
import 'package:plango_front/util/storage.dart';

class TravelService {
  Future<dynamic> getTravels() async {
    return Storage.getToken().then((token) async {
      print(token);
      return await http.get(
        Uri.parse(HTTP + "user/travels"),
        headers: {'Authorization': 'Bearer $token'},
      );
    }).then((value) {
      print(value.body);
      return;
    });
  }
}
