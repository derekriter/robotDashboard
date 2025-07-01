import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:smooth_scroll_multiplatform/smooth_scroll_multiplatform.dart';
import 'package:status_display/data/theme_data.dart';
import 'package:status_display/widgets/status_indicator.dart';

class FadingText extends Text {
  const FadingText(
    super.data, {
    super.key,
    super.style,
    super.strutStyle,
    super.textAlign,
    super.textDirection,
    super.locale,
    super.textScaler,
    super.maxLines,
    super.semanticsLabel,
    super.textWidthBasis,
    super.textHeightBehavior,
    super.selectionColor,
  }) : super(softWrap: false, overflow: TextOverflow.fade);
}

class LargeStatusIndicator extends StatusIndicator {
  LargeStatusIndicator.status({
    super.key,
    required super.status,
    required super.label,
    super.showBackground,
  }) : super.status(
         indicatorSize: 25,
         indicatorRadius: 8,
         labelStyle: titleMedium,
       );
  LargeStatusIndicator.alliance({
    super.key,
    required super.alliance,
    required super.label,
    super.showBackground,
  }) : super.alliance(
         indicatorSize: 25,
         indicatorRadius: 8,
         labelStyle: titleMedium,
       );
  LargeStatusIndicator.robotMode({
    super.key,
    required super.robotMode,
    required super.label,
    super.showBackground,
  }) : super.robotMode(
         indicatorSize: 25,
         indicatorRadius: 8,
         labelStyle: titleMedium,
       );
  LargeStatusIndicator.bool({
    super.key,
    required super.boolean,
    required super.label,
    super.showBackground,
  }) : super.bool(
         indicatorSize: 25,
         indicatorRadius: 8,
         labelStyle: titleMedium,
       );
  LargeStatusIndicator.canCoderMagnetHealth({
    super.key,
    required super.health,
    required super.label,
    super.showBackground,
  }) : super.canCoderMagnetHealth(
         indicatorSize: 25,
         indicatorRadius: 8,
         labelStyle: titleMedium,
       );
}

class SmallStatusIndicator extends StatusIndicator {
  SmallStatusIndicator.status({
    super.key,
    required super.status,
    required super.label,
    super.showBackground,
  }) : super.status(
         indicatorSize: 15,
         indicatorRadius: 4,
         labelStyle: bodySmall,
       );
  SmallStatusIndicator.alliance({
    super.key,
    required super.alliance,
    required super.label,
    super.showBackground,
  }) : super.alliance(
         indicatorSize: 15,
         indicatorRadius: 4,
         labelStyle: bodySmall,
       );
  SmallStatusIndicator.robotMode({
    super.key,
    required super.robotMode,
    required super.label,
    super.showBackground,
  }) : super.robotMode(
         indicatorSize: 15,
         indicatorRadius: 4,
         labelStyle: bodySmall,
       );
  SmallStatusIndicator.bool({
    super.key,
    required super.boolean,
    required super.label,
    super.showBackground,
  }) : super.bool(indicatorSize: 15, indicatorRadius: 4, labelStyle: bodySmall);
  SmallStatusIndicator.canCoderMagnetHealth({
    super.key,
    required super.health,
    required super.label,
    super.showBackground,
  }) : super.canCoderMagnetHealth(
         indicatorSize: 15,
         indicatorRadius: 4,
         labelStyle: bodySmall,
       );
}

class ContainerCard extends Container {
  ContainerCard({
    super.key,
    super.alignment,
    super.width,
    super.height,
    super.constraints,
    super.margin,
    super.transform,
    super.transformAlignment,
    super.child,
    super.clipBehavior,
  }) : super(
         decoration: BoxDecoration(
           color: themeData.colorScheme.secondaryContainer,
           borderRadius: BorderRadius.circular(8),
         ),
         padding: EdgeInsets.all(8),
       );
}

class CustomDivider extends Divider {
  CustomDivider({super.key, super.height, super.indent, super.endIndent})
    : super(color: themeData.colorScheme.onSecondaryContainer, thickness: 0.25);
}

class SmoothSingleChildScrollView extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final Widget? child;

  const SmoothSingleChildScrollView({super.key, this.padding, this.child});

  @override
  Widget build(BuildContext context) {
    // return WebSmoothScroll(
    //   controller: _controller,
    //   scrollSpeed: 1,
    //   scrollAnimationLength: 200,
    //   curve: Curves.easeOutCubic,
    //   child: SingleChildScrollView(
    //     physics: const NeverScrollableScrollPhysics(),
    //     controller: _controller,
    //     padding: padding,
    //     child: child,
    //   ),
    // );
    return DynMouseScroll(
      durationMS: 150,
      scrollSpeed: 1,
      animationCurve: Curves.easeOutCubic,
      builder:
          (_, controller, physics) => SingleChildScrollView(
            controller: controller,
            physics: physics,
            padding: padding,
            child: child,
          ),
    );
  }
}

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
      child: SmoothSingleChildScrollView(padding: padding, child: child),
    );
  }
}

class Throbber extends SpinKitWave {
  const Throbber({super.key, super.color = Colors.white, super.size = 20})
    : super();
}
