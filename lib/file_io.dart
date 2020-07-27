import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileIO {

  bool _fileExists;

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.txt');
  }

  Future<bool> get _localFileExist async {
    final path = await _localPath;
    return File('$path/counter.txt').existsSync();
  }

  Future<File> writeCounter(int counter) async {
    final file = await _localFile;
    return file.writeAsString('{counter: $counter}');
  }

  Future<String> readCounter() async {
    try {
      String contents;
      final file = await _localFile;

      if(await _localFileExist) {
        contents = await file.readAsString();
      }
      else {
        contents = '0';
      }

      return contents;
    } catch (e) {
      // If encountering an error, return 0.
      return '0';
    }
  }
}