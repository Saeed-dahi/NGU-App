class APIList {
  static const String baseUrl = "192.168.0.127:8000";
  static const String api = "api/v1/";
  static const String storageUrl = 'http://$baseUrl/storage/';

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
}
