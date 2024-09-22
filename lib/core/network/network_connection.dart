import 'package:http/http.dart';
import 'package:ngu_app/app/config/api_list.dart';
import 'package:http/http.dart' as http;
import 'package:ngu_app/app/lang/localization_service.dart';

abstract class NetworkConnection {
  Future<Response> get(String apiUrl, Map<String, dynamic>? queryParams);
  Future<Response> put(String apiUrl, Map<String, dynamic> body);
  Future<Response> post(String apiUrl, Map<String, dynamic> body);
  Future<Response> delete(String apiUrl, Map<String, dynamic> body);
}

class HttpConnection implements NetworkConnection {
  final http.Client client;

  HttpConnection({required this.client});

  @override
  Future<Response> get(String apiUrl, Map<String, dynamic>? queryParams) async {
    final uri = Uri.http(APIList.baseUrl, APIList.api + apiUrl, queryParams);

    final response = await client.get(
      uri,
      headers: {
        "Accept": "application/json",
        "Accept-language": await LocalizationService().getCachedLanguage()
      },
    );

    return response;
  }

  @override
  Future<Response> delete(String apiUrl, Map<String, dynamic> body) async {
    final response = await http.delete(
        Uri.https(APIList.baseUrl, APIList.api + apiUrl),
        body: body,
        headers: {
          "Accept": "application/json",
          "Accept-language": await LocalizationService().getCachedLanguage()
        });
    return response;
  }

  @override
  Future<Response> post(String apiUrl, Map<String, dynamic> body) async {
    var response = await http.post(
        Uri.https(APIList.baseUrl, APIList.api + apiUrl),
        body: body,
        headers: {
          "Accept": "application/json",
          "Accept-language": await LocalizationService().getCachedLanguage()
        });
    return response;
  }

  @override
  Future<Response> put(String apiUrl, Map<String, dynamic> body) async {
    var response = await http.put(
        Uri.https(APIList.baseUrl, APIList.api + apiUrl),
        body: body,
        headers: {
          "Accept": "application/json",
          "Accept-language": await LocalizationService().getCachedLanguage()
        });
    return response;
  }
}
