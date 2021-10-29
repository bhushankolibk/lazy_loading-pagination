import 'package:http/http.dart' as http;

Future getRequest({String url}) async {
  final response = await http.get(
    Uri.parse(url),
  );
  print("response Code >> ${response.statusCode}");
  print("response >> ${response.body}");
  if (response.statusCode != 200) {
    throw 'Server Error. Status Code:${response.statusCode}';
  }
  var resBody = response.body;
  return resBody;
}
