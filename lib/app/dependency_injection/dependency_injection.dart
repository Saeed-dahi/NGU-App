import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:ngu_app/core/helper/api_helper.dart';
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
import 'package:ngu_app/features/closing_accounts/domain/use_cases/get_all_closing_accounts_use_case.dart';
import 'package:ngu_app/features/closing_accounts/domain/use_cases/show_closing_account_use_case.dart';
import 'package:ngu_app/features/closing_accounts/domain/use_cases/update_closing_account_use_case.dart';
import 'package:ngu_app/features/closing_accounts/presentation/bloc/closing_accounts_bloc.dart';
import 'package:ngu_app/features/home/presentation/cubits/home_cubit/home_cubit.dart';
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
