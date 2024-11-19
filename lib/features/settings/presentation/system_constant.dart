import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/app/lang/cubit/language_cubit.dart';
import 'package:ngu_app/core/widgets/custom_dropdown.dart';
import 'package:ngu_app/core/widgets/dialogs/confirm_dialog.dart';
import 'package:ngu_app/features/home/presentation/cubits/tab_cubit/tab_cubit.dart';

class SystemConstant extends StatelessWidget {
  const SystemConstant({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text(
          'system_constant'.tr,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: Dimensions.primaryTextSize),
        ),
        const SizedBox(
          height: 10,
        ),
        BlocProvider(
          create: (context) => LanguageCubit()..getSavedLanguage(),
          child: BlocBuilder<LanguageCubit, LanguageState>(
            builder: (context, state) {
              if (state is ChangeLanguageState) {
                return CustomDropdown(
                  dropdownValue: const ['en', 'ar'],
                  onChanged: (value) {
                    _onChangeLanguage(context, value);
                  },
                  helper: 'language'.tr,
                  value: state.locale.toString(),
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ],
    );
  }

  void _onChangeLanguage(BuildContext context, String? value) {
    ConfirmDialog.showConfirmDialog(() {
      Get.back();
    }, () {
      BlocProvider.of<LanguageCubit>(context).changeLanguage(value!);
      context.read<TabCubit>().removeAll();
    });
  }
}
