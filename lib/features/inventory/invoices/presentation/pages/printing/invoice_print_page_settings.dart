import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';
import 'package:ngu_app/core/features/printing/presentation/bloc/printing_bloc.dart';
import 'package:ngu_app/core/widgets/custom_container.dart';
import 'package:ngu_app/core/widgets/custom_elevated_button.dart';
import 'package:ngu_app/core/widgets/loaders.dart';
import 'package:printing/printing.dart';

class InvoicePrintPageSettings extends StatelessWidget {
  const InvoicePrintPageSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        TableRow(
          children: [
            _customPrinterWidget(
                printerType: 'printerType',
                onPressed: () => Printing.pickPrinter(context: context)),
            _customPrinterWidget(printerType: ''),
          ],
        ),
      ],
    );
  }

  BlocProvider<PrintingBloc> _customPrinterWidget(
      {required String printerType, void Function()? onPressed}) {
    return BlocProvider(
      create: (context) => context.read<PrintingBloc>()
        ..add(GetPrinterEvent(printerType: printerType)),
      child: BlocBuilder<PrintingBloc, PrintingState>(
        builder: (context, state) {
          if (state is LoadedPrinterState) {
            return CustomContainer(
              child: CustomElevatedButton(
                color: AppColors.primaryColorLow,
                text: state.printerEntity.name,
                onPressed: onPressed,
              ),
            );
          }
          if (state is ErrorPrinterState) {
            return CustomContainer(
              child: CustomElevatedButton(
                color: AppColors.red,
                text: state.error,
                onPressed: onPressed,
              ),
            );
          }
          return Center(
            child: Loaders.loading(),
          );
        },
      ),
    );
  }
}
