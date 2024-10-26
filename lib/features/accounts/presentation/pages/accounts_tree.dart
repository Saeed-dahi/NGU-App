import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';
import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/app/dependency_injection/dependency_injection.dart';
import 'package:ngu_app/app/lang/localization_service.dart';
import 'package:ngu_app/core/widgets/custom_refresh_indicator.dart';
import 'package:ngu_app/core/widgets/loaders.dart';
import 'package:ngu_app/core/widgets/message_screen.dart';
import 'package:ngu_app/features/accounts/account_information/presentation/bloc/account_information_bloc.dart';
import 'package:ngu_app/features/accounts/domain/entities/account_entity.dart';
import 'package:ngu_app/features/accounts/presentation/blocs/accounts_bloc.dart';
import 'package:ngu_app/features/accounts/presentation/widgets/accounts_information_sidebar.dart';
import 'package:ngu_app/features/accounts/presentation/widgets/account_option_menu.dart';

class AccountsTree extends StatefulWidget {
  const AccountsTree({super.key});

  @override
  State<AccountsTree> createState() => _AccountsTreeState();
}

class _AccountsTreeState extends State<AccountsTree> {
  late final AccountsBloc _accountsBloc;
  late final AccountInformationBloc _accountInformationBloc;
  late TreeViewController _treeViewController;
  late AccountEntity _selectedAccount;

  @override
  void initState() {
    _accountsBloc = sl<AccountsBloc>()..add(GetAllAccountsEvent());
    _accountInformationBloc = sl<AccountInformationBloc>();
    super.initState();
  }

  @override
  void dispose() {
    _accountsBloc.close();
    _accountInformationBloc.close();
    super.dispose();
  }

  Future<void> _refresh(BuildContext context) async {
    _accountsBloc.add(GetAllAccountsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _accountsBloc,
        ),
        BlocProvider(
          create: (context) => _accountInformationBloc,
        ),
      ],
      child: Scaffold(
        body: CustomRefreshIndicator(
          onRefresh: () => _refresh(context),
          content: BlocBuilder<AccountsBloc, AccountsState>(
            builder: (context, state) {
              if (state is GetAllAccountsState) {
                return ListView(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.85,
                      child: _pageBody(context),
                    ),
                  ],
                );
              }
              if (state is ErrorAccountsState) {
                return MessageScreen(text: state.message);
              }
              return Center(child: Loaders.loading());
            },
          ),
        ),
      ),
    );
  }

  Row _pageBody(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _pageTree(context),
        _pageSidebar(
          context,
        )
      ],
    );
  }

  SizedBox _pageTree(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      child: TreeView.simpleTyped(
        tree: _accountsBloc.tree,
        shrinkWrap: false,
        showRootNode: false,
        expansionBehavior: ExpansionBehavior.collapseOthers,
        expansionIndicatorBuilder: (context, node) => ChevronIndicator.upDown(
          tree: node,
          color: AppColors.transparent,
          padding: const EdgeInsets.all(Dimensions.secondaryPadding),
        ),
        indentation: const Indentation(
            style: IndentStyle.squareJoint,
            color: AppColors.primaryColor,
            thickness: 1.4),
        onTreeReady: (controller) {
          _treeViewController = controller;
          controller.expandAllChildren(_accountsBloc.tree);
        },
        builder: (context, node) {
          String name = LocalizationService.isArabic
              ? node.data.arName
              : node.data.enName;
          return GestureDetector(
            excludeFromSemantics: true,
            onTap: () {
              _selectedAccount = node.data;
              _accountInformationBloc
                  .add(ShowAccountInformationEvent(accountId: node.data.id));
            },
            child: Card(
              color: node.level == 1
                  ? AppColors.transparent
                  : node.children.isEmpty
                      ? AppColors.white
                      : AppColors.secondaryColorLow,
              child: ListTile(
                title: Text(name),
                leading: AccountOptionMenu(accountEntity: node.data),
                trailing: IconButton(
                  icon: Icon(node.children.isEmpty || node.isExpanded
                      ? Icons.folder_copy_outlined
                      : Icons.folder),
                  onPressed: () {
                    node.isExpanded
                        ? _treeViewController.collapseNode(node)
                        : _treeViewController.expandNode(node);
                  },
                ),
                subtitle: Text(node.data.code),
              ),
            ),
          );
        },
      ),
    );
  }

  SizedBox _pageSidebar(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.25,
      child: BlocBuilder<AccountInformationBloc, AccountInformationState>(
        builder: (context, state) {
          if (state is LoadedAccountInformationState) {
            return Card(
              elevation: 1,
              color: AppColors.secondaryColorLow,
              child: AccountsInformationSidebar(
                account: _selectedAccount,
                accountInformation:
                    _accountInformationBloc.accountInformationEntity,
              ),
            );
          }
          if (state is ErrorAccountInformationState) {
            return Center(
              child: MessageScreen(text: state.message),
            );
          }
          if (state is LoadingAccountInformationState) {
            return Center(child: Loaders.loading());
          }
          return const SizedBox(
            child: Card(
              elevation: 1,
              color: AppColors.secondaryColorLow,
              child: Column(),
            ),
          );
        },
      ),
    );
  }
}
