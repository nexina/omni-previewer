import 'package:flutter/material.dart';
import 'package:omni_previewer/core/class/working_file.dart';
import 'package:omni_previewer/core/utililty/utility.dart';

class InitialFileLauncher extends StatefulWidget {
  final String filePath;
  final Widget child;

  const InitialFileLauncher({
    super.key,
    required this.filePath,
    required this.child,
  });

  @override
  State<InitialFileLauncher> createState() => _InitialFileLauncherState();
}

class _InitialFileLauncherState extends State<InitialFileLauncher> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      WorkingFile file = WorkingFile(
        path: widget.filePath,
        workingPath: widget.filePath,
      );
      openScreenForFile(context, file);
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
