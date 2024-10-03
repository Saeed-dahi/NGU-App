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

  late int selectedNode = 0;

  @override
  void initState() {
    _accountsBloc = sl<AccountsBloc>()..add(GetAllAccountsEvent());
    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
    await _accountsBloc.close();
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
        _pageSidebar(context, _accountsBloc.accounts[0])
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
          expansionIndicatorBuilder: (context, node) => ChevronIndicator.upDown(
                tree: node,
                color: AppColors.transparent,
                padding: const EdgeInsets.all(Dimensions.secondaryPadding),
              ),
          indentation: const Indentation(
              style: IndentStyle.squareJoint,
              color: AppColors.primaryColor,
              thickness: 1.4),
          onItemTap: (item) {},
          onTreeReady: (controller) {
            controller.expandAllChildren(_accountsBloc.tree);
            controller.scrollToIndex(selectedNode);
          },
          builder: (context, node) {
            String name = LocalizationService.isArabic
                ? node.data.arName
                : node.data.enName;
            return Card(
              color: node.level == 1
                  ? AppColors.transparent
                  : node.children.isEmpty
                      ? AppColors.white
                      : AppColors.secondaryColorLow,
              child: ListTile(
                title: Text(name),
                leading: AccountOptionMenu(selectedId: node.data.id),
                trailing: Icon(
                  node.children.isEmpty || node.isExpanded
                      ? Icons.folder_copy_outlined
                      : Icons.folder,
                ),
                subtitle: Text(node.data.code),
              ),
            );
          }),
    );
  }

  SizedBox _pageSidebar(BuildContext context, AccountEntity account) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.25,
      child: Card(
          elevation: 1,
          color: AppColors.secondaryColorLow,
          child: AccountsInformationSidebar(
            account: account,
          )),
    );
  }
}
