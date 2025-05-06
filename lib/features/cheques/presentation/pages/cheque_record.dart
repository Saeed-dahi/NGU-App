import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';
import 'package:ngu_app/app/dependency_injection/dependency_injection.dart';
import 'package:ngu_app/core/features/upload/domain/entities/file_upload_entity.dart';
import 'package:ngu_app/core/utils/enums.dart';
import 'package:ngu_app/core/widgets/custom_elevated_button.dart';
import 'package:ngu_app/core/widgets/custom_refresh_indicator.dart';
import 'package:ngu_app/core/widgets/loaders.dart';
import 'package:ngu_app/core/widgets/message_screen.dart';
import 'package:ngu_app/features/cheques/domain/entities/cheque_entity.dart';
import 'package:ngu_app/features/cheques/presentation/blocs/cheque_bloc/cheque_bloc.dart';
import 'package:ngu_app/features/cheques/presentation/blocs/cheque_form_cubit/cubit/cheque_form_cubit.dart';
import 'package:ngu_app/features/cheques/presentation/widgets/cheque_basic_from.dart';
import 'package:ngu_app/features/cheques/presentation/widgets/cheque_info_form.dart';
import 'package:ngu_app/features/cheques/presentation/widgets/cheque_toolbar.dart';

class ChequeRecord extends StatefulWidget {
  final int accountId;
  const ChequeRecord({super.key, this.accountId = 1});

  @override
  State<ChequeRecord> createState() => _ChequeRecordState();
}

class _ChequeRecordState extends State<ChequeRecord> {
  final _basicChequeFormKey = GlobalKey<FormState>();
  final _moreInfoChequeFormKey = GlobalKey<FormState>();

  late final ChequeBloc _chequeBloc;
  late ChequeFormCubit _chequeFormCubit;

  late bool _enableEditing;

  @override
  void initState() {
    _enableEditing = false;
    _chequeBloc = sl<ChequeBloc>()..add(ShowChequeEvent(id: widget.accountId));
    _chequeFormCubit = ChequeFormCubit();
    super.initState();
  }

  _initControllers(ChequeEntity cheque) {
    _chequeFormCubit = ChequeFormCubit()..initControllers(cheque);
  }

  @override
  void dispose() {
    _chequeBloc.close();
    _chequeFormCubit.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _chequeBloc,
        ),
        BlocProvider(
          create: (context) => _chequeFormCubit,
        ),
      ],
      child: BlocBuilder<ChequeBloc, ChequeState>(
        builder: (context, state) {
          if (state is LoadedChequeState) {
            _initControllers(state.cheque);
            _enableEditing = state.enableEditing;
            _chequeFormCubit.errors = {};
            return _pageBody(context);
          }

          if (state is ValidationChequeState) {
            _initControllers(_chequeBloc.chequeEntity);
            _chequeFormCubit.errors = state.errors;
            return _pageBody(context);
          }

          if (state is ErrorChequeState) {
            return Column(
              children: [
                ChequeToolbar(
                  enableEditing: _enableEditing,
                ),
                MessageScreen(
                  text: state.message,
                ),
              ],
            );
          }
          return Loaders.loading();
        },
      ),
    );
  }

  DefaultTabController _pageBody(
    BuildContext context,
  ) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Text(
            'cheque_card'.tr,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: Dimensions.primaryTextSize),
          ),
          ChequeToolbar(
            enableEditing: _enableEditing,
            chequeEntity: _chequeBloc.chequeEntity,
            onSave: () => _onSave(context),
          ),
          TabBar(
            labelColor: Colors.black,
            indicatorColor: AppColors.primaryColor,
            tabs: [
              Tab(text: 'cheque'.tr),
              Tab(text: 'cheque_info'.tr),
            ],
          ),
          const SizedBox(
            height: 2,
          ),
          Text(
            _chequeBloc.chequeEntity.status!.tr,
            style: const TextStyle(
              color: AppColors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                CustomRefreshIndicator(
                  onRefresh: _refresh,
                  child: ListView(
                    children: [
                      ChequeBasicForm(
                          basicChequeFormKey: _basicChequeFormKey,
                          chequeFormCubit: _chequeFormCubit,
                          enableEditing: _enableEditing,
                          context: context),
                      // CustomAccordion(
                      //   isOpen: false,
                      //   title: 'multiple_cheques'.tr,
                      //   icon: Icons.my_library_add_rounded,
                      //   contentWidget: const MultipleChequesForm(),
                      // ),
                    ],
                  ),
                ),
                CustomRefreshIndicator(
                  onRefresh: _refresh,
                  child: ChequeInfoFrom(
                      moreInfoChequeFormKey: _moreInfoChequeFormKey,
                      chequeFormCubit: _chequeFormCubit,
                      enableEditing: _enableEditing,
                      context: context),
                ),
              ],
            ),
          ),
          Visibility(
            visible: _enableEditing,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomElevatedButton(
                  color: AppColors.primaryColorLow,
                  text: 'save',
                  onPressed: () {
                    _onSave(context);
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _onSave(BuildContext context) {
    _chequeBloc.add(
      UpdateChequeEvent(
          cheque: _chequeFormCubit.getCheque(
            id: _chequeBloc.chequeEntity.id,
            status: ChequeStatus.received.name,
          ),
          fileUploadEntity: FileUploadEntity(
              files: _chequeFormCubit.imageController.files,
              filesToDelete: _chequeFormCubit.imageController.filesToDelete)),
    );
  }

  Future<void> _refresh() async {
    _chequeBloc.add(ShowChequeEvent(id: _chequeBloc.chequeEntity.id!));
  }
}
