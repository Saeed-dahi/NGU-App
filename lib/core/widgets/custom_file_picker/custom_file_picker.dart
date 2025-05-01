import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_config/api_list.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';
import 'package:ngu_app/core/widgets/custom_file_picker/file_picker_controller.dart';
import 'package:ngu_app/core/widgets/custom_icon_button.dart';
import 'package:ngu_app/core/widgets/custom_input_filed.dart';
import 'package:open_file/open_file.dart'; // For opening local files
import 'package:url_launcher/url_launcher.dart'; // For opening URLs

class CustomFilePicker extends StatefulWidget {
  final FilePickerController controller; // File picker controller
  final bool enableEditing;
  final String? error;

  const CustomFilePicker(
      {super.key,
      required this.controller,
      required this.enableEditing,
      this.error});

  @override
  State<CustomFilePicker> createState() => _CustomFilePickerState();
}

class _CustomFilePickerState extends State<CustomFilePicker> {
  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc', 'jpeg'],
    );

    if (result != null) {
      setState(() {
        widget.controller.addFiles(result.files); // Add files to controller
      });
    }
  }

  void removeFile(int index, bool isUrl) {
    setState(() {
      widget.controller.removeFile(index, isUrl);
    });
  }

  Future<void> openFile(String? filePath, String? url) async {
    if (filePath != null) {
      await OpenFile.open(filePath); // Open local file
    } else if (url != null) {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri); // Open URL
      }
    }
  }

  Widget _buildFilePreview({String? url, PlatformFile? localFile}) {
    if (url != null && (url.endsWith('.jpg') || url.endsWith('.png'))) {
      return GestureDetector(
        onTap: () => openFile(null, url),
        child: Image.network(
          url,
          width: 60,
          height: 60,
          fit: BoxFit.cover,
        ),
      );
    } else if (localFile != null &&
        (localFile.extension == 'jpg' || localFile.extension == 'png')) {
      return GestureDetector(
        onTap: () => openFile(localFile.path, null),
        child: Image.file(
          File(localFile.path!),
          width: 60,
          height: 60,
          fit: BoxFit.cover,
        ),
      );
    } else if (url != null) {
      return GestureDetector(
        onTap: () => openFile(null, url),
        child: Text(url.split('/').last, style: const TextStyle(fontSize: 16)),
      );
    } else {
      return GestureDetector(
        onTap: () => openFile(localFile.path, null),
        child: Text(localFile!.name, style: const TextStyle(fontSize: 16)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.controller.initialFiles.isNotEmpty)
          _buildFilesList(widget.controller.initialFiles, false),
        if (widget.controller.newFiles.isNotEmpty)
          _buildFilesList(widget.controller.newFiles, true),
        CustomInputField(
          inputType: TextInputType.name,
          enabled: widget.enableEditing,
          label: 'file'.tr,
          onTap: () => pickFile(),
          autofocus: false,
          error: widget.error,
          required: false,
          // error: _errors['phone']?.join('\n'),
        ),
      ],
    );
  }

  Padding _buildFilesList(List files, bool isLocal) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: files.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Row(
            children: [
              if (isLocal)
                _buildFilePreview(localFile: files[index])
              else
                _buildFilePreview(url: APIList.storageUrl + files[index]),
              const SizedBox(width: 10),
              CustomIconButton(
                icon: Icons.delete_outline_outlined,
                tooltip: 'delete'.tr,
                color: AppColors.red,
                onPressed: widget.enableEditing
                    ? () => removeFile(index, !isLocal)
                    : null,
              ),
            ],
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 10);
        },
      ),
    );
  }
}
