// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ngu_app/core/widgets/custom_input_filed.dart';

class CustomDatePicker extends StatefulWidget {
  final TextEditingController dateInput;
  final String labelText;
  Function? onPressed = () {};
  CustomDatePicker(
      {super.key,
      required this.dateInput,
      this.onPressed,
      required this.labelText});

  @override
  State<StatefulWidget> createState() {
    return _CustomDatePicker();
  }
}

class _CustomDatePicker extends State<CustomDatePicker> {
  @override
  void initState() {
    DateTime currentDate = DateTime.now();
    widget.dateInput.text = widget.dateInput.text.isEmpty
        ? DateFormat('yyyy-MM-dd').format(currentDate)
        : DateFormat('yyyy-MM-dd')
            .format(DateTime.parse(widget.dateInput.text));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomInputField(
      controller: widget.dateInput,
      inputType: TextInputType.datetime,
      autofocus: false,
      label: widget.labelText,
      readOnly: false,
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
