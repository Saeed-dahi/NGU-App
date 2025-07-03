import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ngu_app/core/widgets/custom_input_filed.dart';
import 'package:ngu_app/core/widgets/snack_bar.dart';

class CustomDatePicker extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  Function? onPressed = () {};
  final bool enabled;
  final bool required;
  final bool readOnly;
  final bool autofocus;
  String? error;
  CustomDatePicker(
      {super.key,
      required this.controller,
      this.onPressed,
      required this.labelText,
      this.autofocus = false,
      this.required = true,
      this.enabled = true,
      this.readOnly = false,
      this.error});

  @override
  State<StatefulWidget> createState() {
    return _CustomDatePicker();
  }
}

class _CustomDatePicker extends State<CustomDatePicker> {
  void _initController() {
    if (widget.controller.text.isNotEmpty) {
      widget.controller.text = DateFormat('yyyy-MM-dd')
          .format(DateTime.parse(widget.controller.text));
    } else {
      widget.controller.text = DateTime.now().toString().substring(0, 10);
    }
  }

  @override
  Widget build(BuildContext context) {
    _initController();
    return CustomInputField(
        controller: widget.controller,
        inputType: TextInputType.datetime,
        autofocus: widget.autofocus,
        label: widget.labelText,
        format: FilteringTextInputFormatter.allow(RegExp(r'[0-9-]')),
        readOnly: widget.readOnly,
        enabled: widget.enabled,
        required: widget.required,
        error: widget.error,
        onChanged: (value) => _onChange(value),
        onTap: () async {
          DateTime? date = await _pickDate(context);
          _updateUiAfterChangeDate(date);
        },
        onEditingComplete: () {
          try {
            DateFormat format = DateFormat('dd-MM-yyyy');
            DateTime date = format.parseStrict(widget.controller.text);
            _updateUiAfterChangeDate(date);
          } catch (e) {
            ShowSnackBar.showValidationSnackbar(messages: ['error_date'.tr]);
            FocusScope.of(context).previousFocus();
          }
        });
  }

  _onChange(String value) {
    if (value.length == 2) {
      widget.controller.text += '-';
    }
    if (value.length == 5) {
      widget.controller.text += '-';
    }
  }

  void _updateUiAfterChangeDate(DateTime? date) {
    if (date != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(date);

      setState(() {
        widget.controller.text = formattedDate;
      });
    }
  }

  Future<DateTime?> _pickDate(BuildContext context) {
    return showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2050));
  }
}
