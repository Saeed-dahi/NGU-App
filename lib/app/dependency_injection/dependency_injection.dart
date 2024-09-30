import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:ngu_app/core/helper/api_helper.dart';
import 'package:ngu_app/core/network/network_connection.dart';
import 'package:ngu_app/core/network/network_info.dart';
import 'package:ngu_app/features/accounts/data/data_sources/account_data_source.dart';
import 'package:ngu_app/features/accounts/data/repositories/account_repository_impl.dart';
import 'package:ngu_app/features/accounts/domain/repositories/account_repository.dart';
import 'package:ngu_app/features/accounts/domain/use_cases/create_account_use_case.dart';
import 'package:ngu_app/features/accounts/domain/use_cases/get_all_accounts_use_case.dart';
import 'package:ngu_app/features/accounts/domain/use_cases/get_suggestion_code_use_case.dart';
import 'package:ngu_app/features/accounts/domain/use_cases/show_account_use_case.dart';
import 'package:ngu_app/features/accounts/domain/use_cases/update_account_use_case.dart';
import 'package:ngu_app/features/accounts/presentation/blocs/accounts_bloc.dart';
import 'package:ngu_app/features/closing_accounts/data/data_sources/closing_account_data_source.dart';
import 'package:ngu_app/features/closing_accounts/data/repositories/closing_account_repository_impl.dart';
import 'package:ngu_app/features/closing_accounts/domain/repositories/closing_account_repository.dart';
import 'package:ngu_app/features/closing_accounts/domain/use_cases/add_new_closing_account_use_case.dart';
import 'package:ngu_app/features/closing_accounts/domain/use_cases/get_all_closing_accounts_use_case.dart';
import 'package:ngu_app/features/closing_accounts/domain/use_cases/show_closing_account_use_case.dart';
import 'package:ngu_app/features/closing_accounts/domain/use_cases/update_closing_account_use_case.dart';
import 'package:ngu_app/features/closing_accounts/presentation/bloc/closing_accounts_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;
Future<void> init() async {
  /// Closing Accounts
  // Bloc
  sl.registerFactory(() => ClosingAccountsBloc(
      showClosingAccountUseCase: sl(),
      createClosingAccountUseCase: sl(),
      updateClosingAccountUseCase: sl(),
      getAllClosingAccountsUseCase: sl()));
  // UseCases
  sl.registerLazySingleton(
      () => GetAllClosingAccountsUseCase(closingAccountRepository: sl()));
  sl.registerLazySingleton(
      () => CreateClosingAccountUseCase(closingAccountRepository: sl()));
  sl.registerLazySingleton(
      () => UpdateClosingAccountUseCase(closingAccountRepository: sl()));
  sl.registerLazySingleton(
      () => ShowClosingAccountUseCase(closingAccountRepository: sl()));
  // Repository
  sl.registerLazySingleton<ClosingAccountRepository>(() =>
      ClosingAccountRepositoryImpl(
          closingAccountDataSource: sl(), networkInfo: sl(), apiHelper: sl()));
  // DataSource
  sl.registerLazySingleton<ClosingAccountDataSource>(
      () => ClosingAccountDataSourceImpl(networkConnection: sl()));

  //////////////////////////////////////////////////////////////////////////////////////////////////
  /// Accounts
  // bloc
  sl.registerFactory(() => AccountsBloc(
      createAccountUseCase: sl(),
      getAllAccountsUseCase: sl(),
      getSuggestionCodeUseCase: sl(),
      showAccountUseCase: sl(),
      updateAccountUseCase: sl()));
  // Use Cases
  sl.registerLazySingleton(
      () => GetAllAccountsUseCase(accountRepository: sl()));
  sl.registerLazySingleton(() => ShowAccountUseCase(accountRepository: sl()));
  sl.registerLazySingleton(() => CreateAccountUseCase(accountRepository: sl()));
  sl.registerLazySingleton(() => UpdateAccountUseCase(accountRepository: sl()));
  sl.registerLazySingleton(
      () => GetSuggestionCodeUseCase(accountRepository: sl()));
  // repository
  sl.registerLazySingleton<AccountRepository>(
      () => AccountRepositoryImpl(accountDataSource: sl(), apiHelper: sl()));
  // Data Source
  sl.registerLazySingleton<AccountDataSource>(
      () => AccountDataSourceWithHttp(networkConnection: sl()));
  //////////////////////////////////////////////////////////////////////////////////////////////////
  // Core
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(internetConnectionChecker: sl()));
  sl.registerLazySingleton<NetworkConnection>(
      () => HttpConnection(client: sl()));

  sl.registerLazySingleton(() => ApiHelper(networkInfo: sl()));

  // External
  final sharedPref = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPref);

  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
