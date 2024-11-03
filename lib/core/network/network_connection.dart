import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:ngu_app/app/app_config/api_list.dart';
import 'package:http/http.dart' as http;
import 'package:ngu_app/app/lang/localization_service.dart';

abstract class NetworkConnection {
  Future<Response> get(String apiUrl, Map<String, dynamic>? queryParams);
  Future<Response> put(String apiUrl, Map<String, dynamic> body);
  Future<Response> post(String apiUrl, Map<String, dynamic> body);
  Future<Response> delete(String apiUrl, Map<String, dynamic> body);
  Future<http.StreamedResponse> httpPostMultipartRequestWithFields(
    String apiURL,
    List<File?> file,
    String key,
    Map data,
    List<String> filesToDelete,
  );
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
        Uri.http(APIList.baseUrl, APIList.api + apiUrl),
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
        Uri.http(APIList.baseUrl, APIList.api + apiUrl),
        body: jsonEncode(body),
        headers: {
          'Content-Type': 'application/json',
          "Accept": "application/json",
          "Accept-language": await LocalizationService().getCachedLanguage(),
        });
    return response;
  }

  @override
  Future<Response> put(String apiUrl, Map<String, dynamic> body) async {
    var response = await http.put(
        Uri.http(APIList.baseUrl, APIList.api + apiUrl),
        body: jsonEncode(body),
        headers: {
          'Content-Type': 'application/json',
          "Accept": "application/json",
          "Accept-language": await LocalizationService().getCachedLanguage()
        });
    return response;
  }

  @override
  Future<http.StreamedResponse> httpPostMultipartRequestWithFields(
    String apiURL,
    List<File?> files,
    String key,
    Map data,
    List<String> filesToDelete,
  ) async {
    var uri = Uri.http(APIList.baseUrl, APIList.api + apiURL);

    var request = http.MultipartRequest('POST', uri);
    request.headers["Accept"] = "application/json";
    request.headers["Accept-Language"] =
        await LocalizationService().getCachedLanguage();

    if (files.isNotEmpty) {
      for (var element in files) {
        request.files
            .add(await http.MultipartFile.fromPath(key, element!.path));
      }
    }

    data.forEach((key, value) {
      request.fields[key] = value;
    });

    if (filesToDelete.isNotEmpty) {
      request.fields['files_to_delete'] = filesToDelete.join(',');
    }

    return request.send();
  }
}
