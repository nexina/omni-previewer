import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:omni_previewer/core/class/working_file.dart';
import 'package:omni_previewer/core/utililty/utility.dart';
import 'package:omni_previewer/features/viewer/presentation/widget/omni_footer.dart';
import 'package:omni_previewer/features/viewer/presentation/widget/viewer-appbar.dart';

class ImageViewer extends StatelessWidget {
  final WorkingFile workingFile;
  const ImageViewer({super.key, required this.workingFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/default.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            color: const Color(0x00242424).withValues(alpha: 0.5),
            child: SafeArea(
              child: Column(
                children: [
                  AppBarViewer(
                    title: getFileName(workingFile.path),
                    desc: getFilePathWithoutFileName(workingFile.path),
                  ),
                  ImageView(filePath: workingFile.workingPath),
                  OmniFooter(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ImageView extends StatelessWidget {
  final String filePath;
  const ImageView({super.key, required this.filePath});

  @override
  Widget build(BuildContext context) {
    final ext = getExtension(filePath);
    return Expanded(
      child: InteractiveViewer(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: (ext == "svg")
                ? SvgPicture.file(File(filePath), fit: BoxFit.contain)
                : Image.file(File(filePath), fit: BoxFit.contain),
          ),
        ),
      ),
    );
  }
}
