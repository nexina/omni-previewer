import 'dart:typed_data';

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:omni_preview/core/config/values.dart';

class BackgroundBuilder extends StatefulWidget {
  final Widget child;
  const BackgroundBuilder({super.key, required this.child});

  @override
  State<BackgroundBuilder> createState() => _BackgroundBuilderState();
}

class _BackgroundBuilderState extends State<BackgroundBuilder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Uint8List>(
        future: Values.backgroundImage,
        builder: (context, snapshot) {
          return Container(
            decoration: BoxDecoration(
              image: snapshot.hasData
                  ? DecorationImage(
                      image: MemoryImage(snapshot.data!),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: const Color(0x00242424).withValues(alpha: 0.5),
                child: SafeArea(child: widget.child),
              ),
            ),
          );
        },
      ),
    );
  }
}
