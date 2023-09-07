import 'package:flutter/material.dart';

class FileWidget extends StatelessWidget {
  final String fileName;

  const FileWidget({
    super.key,
    required this.fileName,
  });

  @override
  Widget build(BuildContext context) {
    return Text('File: $fileName');
  }
}
