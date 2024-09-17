import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:flutter/material.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';
import 'package:ngu_app/app/config/constant.dart';
import 'package:ngu_app/features/accounts/presentation/widgets/accounts_information_sidebar.dart';

class AccountsTree extends StatefulWidget {
  const AccountsTree({super.key});

  @override
  AccountsTreeState createState() => AccountsTreeState();
}

class AccountsTreeState extends State<AccountsTree> {
  TreeViewController? _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ValueListenableBuilder<bool>(
        valueListenable: sampleTree.expansionNotifier,
        builder: (context, isExpanded, _) {
          return FloatingActionButton.extended(
            onPressed: () {
              if (sampleTree.isExpanded) {
                _controller?.collapseNode(sampleTree);
              } else {
                _controller?.expandAllChildren(sampleTree);
              }
            },
            label: isExpanded
                ? const Text("إغلاق الكل")
                : const Text("توسيع الكل"),
          );
        },
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // tree
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: TreeView.simple(
              tree: sampleTree,
              shrinkWrap: false,
              expansionIndicatorBuilder: (context, node) =>
                  ChevronIndicator.upDown(
                tree: node,
                color: AppColors.transparent,
                padding: const EdgeInsets.all(Dimensions.secondaryPadding),
                // icon:
                //     node.isExpanded ? Icons.folder_copy_outlined : Icons.folder,
              ),
              indentation: const Indentation(
                  style: IndentStyle.squareJoint,
                  color: AppColors.primaryColor,
                  thickness: 1.4),
              onItemTap: (item) {},
              onTreeReady: (controller) {
                _controller = controller;
              },
              builder: (context, node) => Card(
                color: node.children.isEmpty
                    ? AppColors.white
                    : AppColors.secondaryColorLow,
                child: ListTile(
                  title: Text(node.key),
                  trailing: Icon(
                    node.children.isEmpty || node.isExpanded
                        ? Icons.folder_copy_outlined
                        : Icons.folder,
                  ),
                  subtitle: Text('${100 * node.level}'),
                ),
              ),
            ),
          ),
          //  side bar

          // Text('data'),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.25,
            child: const Card(
                elevation: 1,
                color: AppColors.secondaryColorLow,
                child: AccountsInformationSidebar()),
          )
        ],
      ),
    );
  }
}

final sampleTree = TreeNode(key: 'شجرة الحسابات')
  ..addAll([
    TreeNode(key: "الموجودات")
      ..addAll([
        TreeNode(key: "الموجودات الثابتة"),
        TreeNode(key: "المخزون"),
        TreeNode(key: "مدينون"),
        TreeNode(key: "حسابات مدينة مختلفة")
          ..addAll([TreeNode(key: "مدينون مختلفون")]),
      ]),
    TreeNode(key: "الخصوم")
      ..addAll([
        TreeNode(key: "راس المال"),
        TreeNode(key: "احتياطات"),
        TreeNode(key: "دائنون")..addAll([TreeNode(key: "موردون طويلة الأجل")]),
      ]),
    TreeNode(key: "الاستخدامات")
      ..addAll([
        TreeNode(key: "الأجور"),
        TreeNode(key: "صافي المشتريات")..addAll([TreeNode(key: "حسم ممنوح")]),
      ]),
    TreeNode(key: "الموارد")
      ..addAll([
        TreeNode(key: "خدمات مباعة"),
        TreeNode(key: "ايرادات بضائع بغرض البيع")
          ..addAll([TreeNode(key: "صافي مبيعات بضائع بغرض البيع")]),
      ]),
  ]);
