import 'package:flutter/material.dart';

class CustomRoundSliderThumbShape extends SliderComponentShape {
  const CustomRoundSliderThumbShape({
    this.enabledThumbRadius = 10.0,
    this.disabledThumbRadius = 10.0,
  });

  final double enabledThumbRadius;

  final double disabledThumbRadius;
  double get _disabledThumbRadius => enabledThumbRadius;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(
        isEnabled == true ? enabledThumbRadius : _disabledThumbRadius);
  }

  @override
  void paint(PaintingContext context, Offset center,
      {required Animation<double> activationAnimation,
      required Animation<double> enableAnimation,
      required bool isDiscrete,
      required TextPainter labelPainter,
      required RenderBox parentBox,
      required SliderThemeData sliderTheme,
      required TextDirection textDirection,
      required double value,
      required double textScaleFactor,
      required Size sizeWithOverflow}) {
    {
      assert(sliderTheme.disabledThumbColor != null);
      assert(sliderTheme.thumbColor != null);

      final Canvas canvas = context.canvas;
      final Tween<double> radiusTween = Tween<double>(
        begin: _disabledThumbRadius,
        end: enabledThumbRadius,
      );
      final Tween<double> radiusTween1 = Tween<double>(
        begin: _disabledThumbRadius,
        end: enabledThumbRadius - 3,
      );
      final ColorTween colorTween = ColorTween(
        begin: sliderTheme.disabledThumbColor,
        end: sliderTheme.thumbColor,
      );
      final ColorTween colorTween1 = ColorTween(
        begin: sliderTheme.disabledThumbColor,
        end: Colors.blueAccent,
      );
      canvas.drawCircle(
        center,
        radiusTween.evaluate(enableAnimation),
        Paint()..color = colorTween.evaluate(enableAnimation)!,
      );
      canvas.drawCircle(center, radiusTween1.evaluate(enableAnimation),
          Paint()..color = colorTween1.evaluate(enableAnimation)!);
    }
  }
}
