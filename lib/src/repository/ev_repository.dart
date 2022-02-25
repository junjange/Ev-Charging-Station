import 'dart:convert' as convert;
import 'package:ev_app/src/model/ev.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';

class EvRepository {
  var apiKey =
      "apiKey";

  var gpsApiKey = "gpsApiKey";

  Future<List<Ev>?> loadEvs(x, y) async {
    // 현재 좌표로 주소 구하기
    String gpsUrl =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${x},${y}&key=$gpsApiKey&language=ko';

    final responseGps = await http.get(Uri.parse(gpsUrl));
    String gpsBody =
        convert.jsonDecode(responseGps.body)['plus_code']["compound_code"];
    var gpsAddr = gpsBody.split(" ");
    var addr = gpsAddr[2]; // [0] => 코드 [1] => 대한민국 [2] => 지역명

    String baseUrl =
        "http://openapi.kepco.co.kr/service/EvInfoServiceV2/getEvSearchList?addr=$addr&pageNo=1&numOfRows=1000&ServiceKey=$apiKey";

    return await apiCall(baseUrl);
  }

  Future<List<Ev>?> searchEvs(addr) async {
    String baseUrl =
        "http://openapi.kepco.co.kr/service/EvInfoServiceV2/getEvSearchList?addr=$addr&pageNo=1&numOfRows=1000&ServiceKey=$apiKey";
    return await apiCall(baseUrl);
  }

  apiCall(baseUrl) async {
    while (true) {
      final response = await http.get(Uri.parse(baseUrl));

      // 정상적으로 데이터를 불러왔다면
      if (response.statusCode == 200) {
        // 데이터 가져오기
        final body = convert.utf8.decode(response.bodyBytes);
        // xml => json으로 변환
        final xml = Xml2Json()..parse(body);
        final json = xml.toParker();

        // 필요한 데이터 찾기
        Map<String, dynamic> jsonResult = convert.json.decode(json);
        final resultCode = jsonResult['response']['header']['resultCode'];

        // api error
        if (resultCode == "99") {
          continue;
        } else {
          print("ggg");

          // 필요한 데이터 그룹이 있다면
          if (jsonResult['response']['body']['items'] != null) {
            List<dynamic> list =
                jsonResult['response']['body']['items']['item'];
            return list.map<Ev>((item) => Ev.fromJson(item)).toList();
          } else {
            print("gg");
            return ;
          }
        }
      }
    }
  }
}
