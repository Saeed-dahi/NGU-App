import 'package:ngu_app/app/dependency_injection/dependency_injection.dart';
import 'package:shared_preferences/shared_preferences.dart';

class APIList {
  static String baseUrl = "192.168.137.155:8000";
  static const String api = "api/v1/";
  static String storageUrl = 'http://$baseUrl/storage/';

  static const String login = "login";
  static const String register = "register";
  static const String closingAccounts = "closing-account";
  static const String closingAccountsStatement = "closing-account-sts";
  static const String account = "account";
  static const String accountStatement = "account-statement";

  static const String searchAccount = "search-account";
  static const String getSuggestionCode = "get-suggestion-code";
  static const String accountInformation = "account-information";

  static const String journal = "journal";

  static const String store = "store";
  static const String category = "category";
  static const String unit = "unit";
  static const String product = "product";
  static const String productUnit = "product-unit";
  static const String invoice = "invoice";
  static const String previewInvoiceItem = "get-invoice-item-data";

  static const String adjustmentNote = "adjustment-note";
  static const String previewAdjustmentNoteItem = "get-adjustment-note-item-data";

  static const String cheque = "cheque";
  static const String depositCheque = "deposit-cheque";
  static const String accountCheques = "account-cheques";
  static const String createMultipleCheques = "create-multiple-cheques";

  static Future<void> saveBaseUrl(String url) async {
    final prefs = sl<SharedPreferences>();
    await prefs.setString('baseUrl', '$url:8000');
    baseUrl = '$url:8000';
  }

  static Future<void> loadBaseUrl() async {
    final prefs = sl<SharedPreferences>();
    baseUrl = prefs.getString('baseUrl') ?? "192.168.137.155:8000";
  }
}
