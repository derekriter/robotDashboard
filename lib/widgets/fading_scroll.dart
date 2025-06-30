import 'package:flutter/material.dart';

class FadingSingleChildScrollView extends StatelessWidget {
  final Color? fadeColor;
  final double fadePercentage;
  final Widget child;
  final EdgeInsets? padding;

  const FadingSingleChildScrollView({
    super.key,
    this.fadeColor,
    this.fadePercentage = 0.1,
    this.padding,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (rect) {
        return LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.center,
          colors: [
            fadeColor ?? Colors.white,
            Colors.transparent,
            Colors.transparent,
          ],
          tileMode: TileMode.mirror,
          stops: [0, fadePercentage, 1],
        ).createShader(rect);
      },
      blendMode: fadeColor == null ? BlendMode.dstOut : BlendMode.srcOver,
      child: SingleChildScrollView(padding: padding, child: child),
    );
  }
}

class FadingListView extends StatelessWidget {
  final Color? fadeColor;
  final double fadePercentage;
  final List<Widget> children;
  final EdgeInsets? padding;

  const FadingListView({
    super.key,
    this.fadeColor,
    this.fadePercentage = 0.1,
    this.padding,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (rect) {
        return LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.center,
          colors: [
            fadeColor ?? Colors.white,
            Colors.transparent,
            Colors.transparent,
          ],
          tileMode: TileMode.mirror,
          stops: [0, fadePercentage, 1],
        ).createShader(rect);
      },
      blendMode: fadeColor == null ? BlendMode.dstOut : BlendMode.srcOver,
      child: ListView(padding: padding, children: children),
    );
  }
}
