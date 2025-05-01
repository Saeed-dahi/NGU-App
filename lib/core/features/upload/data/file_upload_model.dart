import 'package:ngu_app/core/features/upload/domain/entities/file_upload_entity.dart';

class FileUploadModel extends FileUploadEntity {
  const FileUploadModel({required super.files, required super.filesToDelete});

  Map<String, dynamic> toJson() {
    return {'files': files, 'files_to_delete': filesToDelete};
  }
}
