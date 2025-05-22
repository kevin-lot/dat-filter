import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<String> get homeDirectory async {
  final Directory directory = await getApplicationDocumentsDirectory();
  return directory.path;
}
