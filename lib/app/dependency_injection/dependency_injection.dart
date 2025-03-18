import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:ngu_app/core/features/printing/data/data_sources/printing_local_data_sources.dart';
import 'package:ngu_app/core/features/printing/data/database/printing_data_base.dart';
import 'package:ngu_app/core/features/printing/data/repositories/printing_repositories_impl.dart';
import 'package:ngu_app/core/features/printing/domain/repositories/printing_repository.dart';
import 'package:ngu_app/core/features/printing/domain/use_cases/add_new_printer_use_case.dart';
import 'package:ngu_app/core/features/printing/domain/use_cases/get_printer_use_case.dart';
import 'package:ngu_app/core/features/printing/domain/use_cases/get_printers_use_case.dart';
import 'package:ngu_app/core/features/printing/domain/use_cases/update_printer_use_case.dart';
import 'package:ngu_app/core/features/printing/presentation/bloc/printing_bloc.dart';
import 'package:ngu_app/core/helper/api_helper.dart';
import 'package:ngu_app/core/helper/data_base_helper.dart';
import 'package:ngu_app/core/network/network_connection.dart';
import 'package:ngu_app/core/network/network_info.dart';
import 'package:ngu_app/features/accounts/account_information/data/data_sources/account_information_data_source.dart';
import 'package:ngu_app/features/accounts/account_information/data/repositories/account_information_repository_impl.dart';
import 'package:ngu_app/features/accounts/account_information/domain/repositories/account_information_repository.dart';
import 'package:ngu_app/features/accounts/account_information/domain/use_cases/show_account_information_use_case.dart';
import 'package:ngu_app/features/accounts/account_information/domain/use_cases/update_account_information_use_case.dart';
import 'package:ngu_app/features/accounts/account_information/presentation/bloc/account_information_bloc.dart';
import 'package:ngu_app/features/accounts/data/data_sources/account_data_source.dart';
import 'package:ngu_app/features/accounts/data/repositories/account_repository_impl.dart';
import 'package:ngu_app/features/accounts/domain/repositories/account_repository.dart';
import 'package:ngu_app/features/accounts/domain/use_cases/account_statement_use_case.dart';
import 'package:ngu_app/features/accounts/domain/use_cases/create_account_use_case.dart';
import 'package:ngu_app/features/accounts/domain/use_cases/get_all_accounts_use_case.dart';
import 'package:ngu_app/features/accounts/domain/use_cases/get_suggestion_code_use_case.dart';
import 'package:ngu_app/features/accounts/domain/use_cases/search_in_accounts_use_case.dart';
import 'package:ngu_app/features/accounts/domain/use_cases/show_account_use_case.dart';
import 'package:ngu_app/features/accounts/domain/use_cases/update_account_use_case.dart';
import 'package:ngu_app/features/accounts/presentation/blocs/accounts_bloc.dart';
import 'package:ngu_app/features/closing_accounts/data/data_sources/closing_account_data_source.dart';
import 'package:ngu_app/features/closing_accounts/data/repositories/closing_account_repository_impl.dart';
import 'package:ngu_app/features/closing_accounts/domain/repositories/closing_account_repository.dart';
import 'package:ngu_app/features/closing_accounts/domain/use_cases/add_new_closing_account_use_case.dart';
import 'package:ngu_app/features/closing_accounts/domain/use_cases/closing_account_statement_use_case.dart';
import 'package:ngu_app/features/closing_accounts/domain/use_cases/get_all_closing_accounts_use_case.dart';
import 'package:ngu_app/features/closing_accounts/domain/use_cases/show_closing_account_use_case.dart';
import 'package:ngu_app/features/closing_accounts/domain/use_cases/update_closing_account_use_case.dart';
import 'package:ngu_app/features/closing_accounts/presentation/bloc/closing_accounts_bloc.dart';
import 'package:ngu_app/features/home/presentation/cubits/home_cubit/home_cubit.dart';
import 'package:ngu_app/features/inventory/categories/data/data_sources/category_data_source.dart';
import 'package:ngu_app/features/inventory/categories/data/repositories/category_repository_impl.dart';
import 'package:ngu_app/features/inventory/categories/domain/repositories/category_repository.dart';
import 'package:ngu_app/features/inventory/categories/domain/use_cases/create_category_use_case.dart';
import 'package:ngu_app/features/inventory/categories/domain/use_cases/get_categories_use_case.dart';
import 'package:ngu_app/features/inventory/categories/domain/use_cases/update_category_use_case.dart';
import 'package:ngu_app/features/inventory/categories/presentation/bloc/category_bloc.dart';
import 'package:ngu_app/features/inventory/invoices/data/data_sources/invoice_data_source.dart';
import 'package:ngu_app/features/inventory/invoices/data/repositories/invoice_repository_impl.dart';
import 'package:ngu_app/features/inventory/invoices/domain/repositories/invoice_repository.dart';
import 'package:ngu_app/features/inventory/invoices/domain/use_cases/create_invoice_use_case.dart';
import 'package:ngu_app/features/inventory/invoices/domain/use_cases/get_all_invoices_use_case.dart';
import 'package:ngu_app/features/inventory/invoices/domain/use_cases/get_create_invoice_form_data_use_case.dart';
import 'package:ngu_app/features/inventory/invoices/domain/use_cases/preview_invoice_item_use_case.dart';
import 'package:ngu_app/features/inventory/invoices/domain/use_cases/show_invoice_use_case.dart';
import 'package:ngu_app/features/inventory/invoices/domain/use_cases/update_invoice_use_case.dart';
import 'package:ngu_app/features/inventory/invoices/presentation/blocs/invoice_bloc/invoice_bloc.dart';
import 'package:ngu_app/features/inventory/invoices/presentation/blocs/preview_invoice_item_cubit/preview_invoice_item_cubit.dart';
import 'package:ngu_app/features/inventory/products/data/data_sources/product_data_source.dart';
import 'package:ngu_app/features/inventory/products/data/repositories/product_repository_impl.dart';
import 'package:ngu_app/features/inventory/products/domain/repositories/product_repository.dart';
import 'package:ngu_app/features/inventory/products/domain/use_cases/create_product_unit_use_case.dart';
import 'package:ngu_app/features/inventory/products/domain/use_cases/create_product_use_case.dart';
import 'package:ngu_app/features/inventory/products/domain/use_cases/get_products_use_case.dart';
import 'package:ngu_app/features/inventory/products/domain/use_cases/show_product_use_case.dart';
import 'package:ngu_app/features/inventory/products/domain/use_cases/update_product_unit_use_case.dart';
import 'package:ngu_app/features/inventory/products/domain/use_cases/update_product_use_case.dart';
import 'package:ngu_app/features/inventory/products/presentation/bloc/product_bloc.dart';
import 'package:ngu_app/features/inventory/stores/data/data_sources/store_data_source.dart';
import 'package:ngu_app/features/inventory/stores/data/repositories/store_repository_impl.dart';
import 'package:ngu_app/features/inventory/stores/domain/repositories/store_repository.dart';
import 'package:ngu_app/features/inventory/stores/domain/use_cases/create_store_use_case.dart';
import 'package:ngu_app/features/inventory/stores/domain/use_cases/get_stores_use_case.dart';
import 'package:ngu_app/features/inventory/stores/domain/use_cases/update_store_use_case.dart';
import 'package:ngu_app/features/inventory/stores/presentation/bloc/store_bloc.dart';
import 'package:ngu_app/features/inventory/units/data/data_sources/unit_data_source.dart';
import 'package:ngu_app/features/inventory/units/data/repositories/unit_repository_impl.dart';
import 'package:ngu_app/features/inventory/units/domain/repositories/unit_repository.dart';
import 'package:ngu_app/features/inventory/units/domain/use_cases/create_unit_use_case.dart';
import 'package:ngu_app/features/inventory/units/domain/use_cases/get_units_use_case.dart';
import 'package:ngu_app/features/inventory/units/domain/use_cases/update_unit_use_case.dart';
import 'package:ngu_app/features/inventory/units/presentation/bloc/unit_bloc.dart';
import 'package:ngu_app/features/journals/data/data_sources/journal_data_source.dart';
import 'package:ngu_app/features/journals/data/repositories/journal_repository_impl.dart';
import 'package:ngu_app/features/journals/domain/repositories/journal_repository.dart';
import 'package:ngu_app/features/journals/domain/use_cases/create_journal_use_case.dart';
import 'package:ngu_app/core/features/accounts/domain/use_cases/get_accounts_name_use_case.dart';
import 'package:ngu_app/features/journals/domain/use_cases/get_all_journals_use_case.dart';
import 'package:ngu_app/features/journals/domain/use_cases/show_journal_use_case.dart';
import 'package:ngu_app/features/journals/domain/use_cases/update_journal_use_case.dart';
import 'package:ngu_app/features/journals/presentation/bloc/journal_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;
Future<void> init() async {
  /// Closing Accounts
  _closingAccount();

  /// Accounts
  _account();

  /// Accounts
  _accountInformation();

  _journal();

  // Core
  _core();

  // Category
  _category();

  // Store
  _store();

  // Unit
  _unit();

  _product();

  _invoice();

  _printing();

  // External
  await _external();
}

Future<void> _external() async {
  // External
  final sharedPref = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPref);

  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}

void _core() {
  // Core
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(internetConnectionChecker: sl()));
  sl.registerLazySingleton<NetworkConnection>(
      () => HttpConnection(client: sl()));
  sl.registerLazySingleton(() => ApiHelper(networkInfo: sl()));
  sl.registerLazySingleton(() => DataBaseHelper());
  sl.registerFactory(() => HomeCubit());
}

void _account() {
  // bloc
  sl.registerFactory(
    () => AccountsBloc(
        createAccountUseCase: sl(),
        getAllAccountsUseCase: sl(),
        searchInAccountsUseCase: sl(),
        getSuggestionCodeUseCase: sl(),
        showAccountUseCase: sl(),
        updateAccountUseCase: sl(),
        accountStatementUseCase: sl(),
        getAccountsNameUseCase: sl()),
  );
  // Use Cases
  sl.registerLazySingleton(
      () => GetAllAccountsUseCase(accountRepository: sl()));
  sl.registerLazySingleton(
      () => SearchInAccountsUseCase(accountRepository: sl()));
  sl.registerLazySingleton(() => ShowAccountUseCase(accountRepository: sl()));
  sl.registerLazySingleton(() => CreateAccountUseCase(accountRepository: sl()));
  sl.registerLazySingleton(() => UpdateAccountUseCase(accountRepository: sl()));
  sl.registerLazySingleton(
      () => GetSuggestionCodeUseCase(accountRepository: sl()));
  sl.registerLazySingleton(
      () => AccountStatementUseCase(accountRepository: sl()));
  sl.registerLazySingleton(
      () => GetAccountsNameUseCase(accountRepository: sl()));

  // repository
  sl.registerLazySingleton<AccountRepository>(
      () => AccountRepositoryImpl(accountDataSource: sl(), apiHelper: sl()));
  // Data Source
  sl.registerLazySingleton<AccountDataSource>(
      () => AccountDataSourceWithHttp(networkConnection: sl()));
}

void _closingAccount() {
  // bloc
  sl.registerFactory(() => ClosingAccountsBloc(
      showClosingAccountUseCase: sl(),
      createClosingAccountUseCase: sl(),
      updateClosingAccountUseCase: sl(),
      getAllClosingAccountsUseCase: sl(),
      closingAccountStatementUseCase: sl()));
  // UseCases
  sl.registerLazySingleton(
      () => GetAllClosingAccountsUseCase(closingAccountRepository: sl()));
  sl.registerLazySingleton(
      () => CreateClosingAccountUseCase(closingAccountRepository: sl()));
  sl.registerLazySingleton(
      () => UpdateClosingAccountUseCase(closingAccountRepository: sl()));
  sl.registerLazySingleton(
      () => ShowClosingAccountUseCase(closingAccountRepository: sl()));
  sl.registerLazySingleton(
      () => ClosingAccountStatementUseCase(closingAccountRepository: sl()));
  // Repository
  sl.registerLazySingleton<ClosingAccountRepository>(() =>
      ClosingAccountRepositoryImpl(
          closingAccountDataSource: sl(), networkInfo: sl(), apiHelper: sl()));
  // DataSource
  sl.registerLazySingleton<ClosingAccountDataSource>(
      () => ClosingAccountDataSourceImpl(networkConnection: sl()));
}

void _accountInformation() {
  // bloc
  sl.registerFactory(() => AccountInformationBloc(
      showAccountInformationUseCase: sl(),
      updateAccountInformationUseCase: sl()));

  // use cases
  sl.registerLazySingleton(
      () => ShowAccountInformationUseCase(accountInformationRepository: sl()));
  sl.registerLazySingleton(() =>
      UpdateAccountInformationUseCase(accountInformationRepository: sl()));

  // repository
  sl.registerLazySingleton<AccountInformationRepository>(() =>
      AccountInformationRepositoryImpl(
          apiHelper: sl(), accountInformationDataSource: sl()));

  // dataSource
  sl.registerLazySingleton<AccountInformationDataSource>(
      () => AccountInformationDataSourceWithHttp(networkConnection: sl()));
}

void _journal() {
  // bloc
  sl.registerFactory(
    () => JournalBloc(
      getAllJournalsUseCase: sl(),
      showJournalUseCase: sl(),
      createJournalUseCase: sl(),
      updateJournalUseCase: sl(),
      getAccountNameUseCase: sl(),
    ),
  );

  // use cases
  sl.registerLazySingleton(
      () => GetAllJournalsUseCase(journalRepository: sl()));
  sl.registerLazySingleton(() => ShowJournalUseCase(journalRepository: sl()));
  sl.registerLazySingleton(() => CreateJournalUseCase(journalRepository: sl()));
  sl.registerLazySingleton(() => UpdateJournalUseCase(journalRepository: sl()));

  // repository
  sl.registerLazySingleton<JournalRepository>(
      () => JournalRepositoryImpl(apiHelper: sl(), journalDataSource: sl()));

  // data sources
  sl.registerLazySingleton<JournalDataSource>(
      () => JournalDataSourceImpl(networkConnection: sl()));
}

void _category() {
  sl.registerFactory(
    () => CategoryBloc(
      getCategoriesUseCase: sl(),
      createCategoryUseCase: sl(),
      updateCategoryUseCase: sl(),
    ),
  );

  sl.registerLazySingleton(
      () => GetCategoriesUseCase(categoryRepository: sl()));
  sl.registerLazySingleton(
      () => CreateCategoryUseCase(categoryRepository: sl()));
  sl.registerLazySingleton(
      () => UpdateCategoryUseCase(categoryRepository: sl()));

  sl.registerLazySingleton<CategoryRepository>(
      () => CategoryRepositoryImpl(categoryDataSource: sl(), apiHelper: sl()));

  sl.registerLazySingleton<CategoryDataSource>(
      () => CategoryDataSourceImpl(networkConnection: sl()));
}

void _store() {
  sl.registerFactory(
    () => StoreBloc(
      storesUseCase: sl(),
      createStoreUseCase: sl(),
      updateStoreUseCase: sl(),
    ),
  );

  sl.registerLazySingleton(() => GetStoresUseCase(storeRepository: sl()));
  sl.registerLazySingleton(() => CreateStoreUseCase(storeRepository: sl()));
  sl.registerLazySingleton(() => UpdateStoreUseCase(storeRepository: sl()));

  sl.registerLazySingleton<StoreRepository>(
      () => StoreRepositoryImpl(storeDataSource: sl(), apiHelper: sl()));

  sl.registerLazySingleton<StoreDataSource>(
      () => StoreDataSourceWithHttp(networkConnection: sl()));
}

void _unit() {
  sl.registerFactory(
    () => UnitBloc(
      getUnitsUseCase: sl(),
      createUnitUseCase: sl(),
      updateUnitUseCase: sl(),
    ),
  );

  sl.registerLazySingleton(() => GetUnitsUseCase(unitRepository: sl()));
  sl.registerLazySingleton(() => CreateUnitUseCase(unitRepository: sl()));
  sl.registerLazySingleton(() => UpdateUnitUseCase(unitRepository: sl()));

  sl.registerLazySingleton<UnitRepository>(
      () => UnitRepositoryImpl(unitDataSource: sl(), apiHelper: sl()));

  sl.registerLazySingleton<UnitDataSource>(
      () => UnitDataSourceImpl(networkConnection: sl()));
}

void _product() {
  sl.registerFactory(
    () => ProductBloc(
      getProductsUseCase: sl(),
      showProductUseCase: sl(),
      createProductUseCase: sl(),
      updateProductUseCase: sl(),
      createProductUnitUseCase: sl(),
      updateProductUnitUseCase: sl(),
    ),
  );

  sl.registerLazySingleton(() => GetProductsUseCase(productRepository: sl()));
  sl.registerLazySingleton(() => ShowProductUseCase(productRepository: sl()));
  sl.registerLazySingleton(() => CreateProductUseCase(productRepository: sl()));
  sl.registerLazySingleton(() => UpdateProductUseCase(productRepository: sl()));
  sl.registerLazySingleton(
      () => CreateProductUnitUseCase(productRepository: sl()));
  sl.registerLazySingleton(
      () => UpdateProductUnitUseCase(productRepository: sl()));

  sl.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(productDataSource: sl(), apiHelper: sl()));

  sl.registerLazySingleton<ProductDataSource>(
      () => ProductDataSourceImpl(networkConnection: sl()));
}

void _invoice() {
  sl.registerFactory(
    () => InvoiceBloc(
      getAllInvoicesUseCase: sl(),
      showInvoiceUseCase: sl(),
      createInvoiceUseCase: sl(),
      updateInvoiceUseCase: sl(),
      getAccountsNameUseCase: sl(),
      getCreateInvoiceFormDataUseCase: sl(),
    ),
  );

  sl.registerFactory(() => PreviewInvoiceItemCubit(sl()));

  sl.registerLazySingleton(
      () => GetAllInvoicesUseCase(invoiceRepository: sl()));
  sl.registerLazySingleton(() => ShowInvoiceUseCase(invoiceRepository: sl()));
  sl.registerLazySingleton(() => CreateInvoiceUseCase(invoiceRepository: sl()));
  sl.registerLazySingleton(() => UpdateInvoiceUseCase(invoiceRepository: sl()));
  sl.registerLazySingleton(
      () => GetCreateInvoiceFormDataUseCase(invoiceRepository: sl()));
  sl.registerLazySingleton(
      () => PreviewInvoiceItemUseCase(invoiceRepository: sl()));

  sl.registerLazySingleton<InvoiceRepository>(
      () => InvoiceRepositoryImpl(apiHelper: sl(), invoiceDataSource: sl()));

  sl.registerLazySingleton<InvoiceDataSource>(
      () => InvoiceDataSourceImpl(networkConnection: sl()));
}

void _printing() {
  sl.registerFactory(
    () => PrintingBloc(
      getPrinterUseCase: sl(),
      getPrintersUseCase: sl(),
      addNewPrinterUseCase: sl(),
      updatePrinterUseCase: sl(),
    ),
  );

  sl.registerLazySingleton(() => GetPrinterUseCase(printingRepository: sl()));
  sl.registerLazySingleton(() => GetPrintersUseCase(printingRepository: sl()));
  sl.registerLazySingleton(
      () => AddNewPrinterUseCase(printingRepository: sl()));
  sl.registerLazySingleton(
      () => UpdatePrinterUseCase(printingRepository: sl()));

  sl.registerLazySingleton<PrintingRepository>(() =>
      PrintingRepositoryImpl(printingDataSource: sl(), dataBaseHelper: sl()));

  sl.registerLazySingleton<PrintingDataSource>(
      () => PrintingDataSourceImpl(printingDataBase: sl()));
  sl.registerLazySingleton<PrintingDataBase>(() => PrintingDataBaseImpl());
}
