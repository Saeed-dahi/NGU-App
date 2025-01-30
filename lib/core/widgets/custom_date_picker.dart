// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ngu_app/core/widgets/custom_input_filed.dart';

class CustomDatePicker extends StatefulWidget {
  final TextEditingController dateInput;
  final String labelText;
  Function? onPressed = () {};

  final bool enabled;
  final bool required;
  final bool readOnly;
  final bool autofocus;
  CustomDatePicker(
      {super.key,
      required this.dateInput,
      this.onPressed,
      required this.labelText,
      this.autofocus = false,
      this.required = true,
      this.enabled = true,
      this.readOnly = false});

  @override
  State<StatefulWidget> createState() {
    return _CustomDatePicker();
  }
}

class _CustomDatePicker extends State<CustomDatePicker> {
  @override
  void initState() {
    if (widget.dateInput.text.isNotEmpty) {
      widget.dateInput.text = DateFormat('yyyy-MM-dd')
          .format(DateTime.parse(widget.dateInput.text));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomInputField(
      controller: widget.dateInput,
      inputType: TextInputType.datetime,
      autofocus: widget.autofocus,
      label: widget.labelText,
      readOnly: widget.readOnly,
      enabled: widget.enabled,
      required: widget.required,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime(2050));

        if (pickedDate != null) {
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);

          setState(() {
            widget.dateInput.text = formattedDate;
            FocusScope.of(context).nextFocus();
          });
        } else {}
      },
    );
  }
}
