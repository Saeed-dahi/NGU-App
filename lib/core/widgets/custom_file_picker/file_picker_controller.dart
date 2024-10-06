import 'dart:io';

import 'package:file_picker/file_picker.dart';

class FilePickerController {
  List<String> _initialFiles = []; // List of URLs from API
  final List<PlatformFile> _newFiles = []; // Newly picked files
  final List<String> _filesToDelete = [];

  FilePickerController({List<String>? initialFiles}) {
    if (initialFiles != null) {
      _initialFiles = List.from(initialFiles);
    }
  }

  // Get combined list of URLs (initial) and local files (new)
  // List<dynamic> get files => [..._initialFiles, ..._newFiles];
  List<File> get files {
    List<File> allFiles = [];

    // // Convert initial files (URLs) to File objects (placeholder)
    // for (String url in _initialFiles) {
    //   allFiles.add(File(APIList.storageUrl +
    //       url)); // You might want to modify this if you need something else
    // }

    // // Add new local files
    for (PlatformFile file in _newFiles) {
      allFiles.add(File(file.path!));
    }

    return allFiles;
  }

  // Get initial files only
  List<String> get initialFiles => _initialFiles;

  // Get new files only
  List<PlatformFile> get newFiles => _newFiles;

  // Get the list of files marked for deletion
  List<String> get filesToDelete => _filesToDelete;

  // Add files to the deletion list
  void markFileForDeletion(String filename) {
    _filesToDelete.add(filename);
  }

  // Add a newly picked file
  void addFiles(List<PlatformFile> files) {
    _newFiles.addAll(files);
  }

  // Remove a file (by index) from either initial or new list
  void removeFile(int index, bool isInitialFile) {
    if (isInitialFile) {
      String removedFile = _initialFiles.removeAt(index);
      markFileForDeletion(removedFile); // Mark the removed file for deletion
    } else {
      _newFiles.removeAt(index);
    }
  }

  // Clear all files
  void clear() {
    _initialFiles.clear();
    _newFiles.clear();
    _filesToDelete.clear();
  }
}
