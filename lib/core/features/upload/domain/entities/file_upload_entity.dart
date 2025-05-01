import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:ngu_app/core/features/upload/data/file_upload_model.dart';

class FileUploadEntity extends Equatable {
  final List<File> files;
  final List<String> filesToDelete;

  const FileUploadEntity({required this.files, required this.filesToDelete});

  @override
  List<Object?> get props => [files, filesToDelete];

  FileUploadModel toModel() {
    return FileUploadModel(files: files, filesToDelete: filesToDelete);
  }
}
