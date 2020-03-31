import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

void main() async {

var link = "https://pub.dartlang.org/api/packages?compact=1";

var res = await http.get(Uri.encodeFull(link), headers: {"Accept": "application/vnd.pub.v2+json"});

var data = json.decode(res.body);

var pack = data["packages"] as List;
print(pack[0]);

var link2 = "https://pub.dartlang.org/api/packages/" + pack[0] + "/";

var res2 = await http.get(Uri.encodeFull(link2), headers: {"Accept": "application/vnd.pub.v2+json"});

var data2 = json.decode(res2.body);

var link3 = data2["latest"]["archive_url"] as String;

print(link3);

HttpClient client = new HttpClient();
client.getUrl(Uri.parse(link3))
  .then((HttpClientRequest request) {
    return request.close();
  })
  .then((HttpClientResponse response) {
      response.pipe(new File("./" + pack[0] + ".tar.gz").openWrite());
  });
}