import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';
import 'package:ngu_app/core/features/upload/domain/entities/file_upload_entity.dart';
import 'package:ngu_app/core/utils/enums.dart';
import 'package:ngu_app/core/widgets/custom_accordion.dart';
import 'package:ngu_app/core/widgets/custom_elevated_button.dart';
import 'package:ngu_app/core/widgets/loaders.dart';
import 'package:ngu_app/core/widgets/message_screen.dart';
import 'package:ngu_app/features/cheques/presentation/blocs/cheque_bloc/cheque_bloc.dart';
import 'package:ngu_app/features/cheques/presentation/blocs/cheque_form_cubit/cubit/cheque_form_cubit.dart';
import 'package:ngu_app/features/cheques/presentation/blocs/multiple_cheques_cubit/multiple_cheques_cubit.dart';
import 'package:ngu_app/features/cheques/presentation/widgets/cheque_basic_from.dart';
import 'package:ngu_app/features/cheques/presentation/widgets/cheque_info_form.dart';
import 'package:ngu_app/features/cheques/presentation/widgets/cheque_toolbar.dart';
import 'package:ngu_app/features/cheques/presentation/widgets/multiple_cheques_form.dart';

class CreateCheque extends StatefulWidget {
  const CreateCheque({super.key});

  @override
  State<CreateCheque> createState() => _CreateChequeState();
}

class _CreateChequeState extends State<CreateCheque> {
  final _basicChequeFormKey = GlobalKey<FormState>();
  final _moreInfoChequeFormKey = GlobalKey<FormState>();

  late bool _enableEditing;

  late ChequeFormCubit _chequeFormCubit;
  late MultipleChequesCubit _multipleChequesCubit;

  @override
  void initState() {
    _enableEditing = true;
    _chequeFormCubit = ChequeFormCubit();
    _multipleChequesCubit = MultipleChequesCubit();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _multipleChequesCubit,
        ),
        BlocProvider(
          create: (context) => _chequeFormCubit,
        ),
      ],
      child: BlocBuilder<ChequeBloc, ChequeState>(
        builder: (context, state) {
          if (state is LoadingChequeState) {
            return Loaders.loading();
          }
          if (state is ValidationChequeState) {
            _chequeFormCubit.errors = state.errors;
            return _pageBody(context);
          }
          if (state is ErrorChequeState) {
            return MessageScreen(
              text: state.message,
            );
          }
          return _pageBody(context);
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
          ChequeToolbar(enableEditing: _enableEditing),
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
          Expanded(
            child: TabBarView(
              children: [
                ListView(
                  children: [
                    // General Account info
                    ChequeBasicForm(
                      basicChequeFormKey: _basicChequeFormKey,
                      chequeFormCubit: _chequeFormCubit,
                      multipleChequesCubit: _multipleChequesCubit,
                      context: context,
                      enableEditing: _enableEditing,
                    ),
                    CustomAccordion(
                      isOpen: false,
                      title: 'multiple_cheques'.tr,
                      icon: Icons.my_library_add_rounded,
                      contentWidget: MultipleChequesForm(
                        multipleChequesCubit: _multipleChequesCubit,
                      ),
                    ),
                  ],
                ),
                ChequeInfoFrom(
                  moreInfoChequeFormKey: _moreInfoChequeFormKey,
                  chequeFormCubit: _chequeFormCubit,
                  context: context,
                  enableEditing: _enableEditing,
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
    if (_basicChequeFormKey.currentState!.validate()) {
      if (_multipleChequesCubit.paymentWay != null) {
        context.read<ChequeBloc>().add(CreateMultipleChequeEvent(
            cheque:
                _chequeFormCubit.getCheque(status: ChequeStatus.received.name),
            chequesParamsEntity:
                _multipleChequesCubit.getMultipleChequeParamsEntity()));
      } else {
        context.read<ChequeBloc>().add(
              CreateChequeEvent(
                cheque: _chequeFormCubit.getCheque(
                    status: ChequeStatus.received.name),
                fileUploadEntity: FileUploadEntity(
                    files: _chequeFormCubit.imageController.files,
                    filesToDelete:
                        _chequeFormCubit.imageController.filesToDelete),
              ),
            );
      }
    }
  }
}
