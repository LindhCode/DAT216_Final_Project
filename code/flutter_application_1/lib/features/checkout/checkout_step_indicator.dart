import 'package:flutter/material.dart';
import 'package:imat_app/core/theme/app_theme.dart';

class CheckoutStepIndicator extends StatelessWidget {
  final int currentStep;
  final ValueChanged<int>? onStepTap;

  static const _labels = [
    '1. Granskning',
    '2. Leverans',
    '3. Betalning',
    '4. Slutför',
  ];

  const CheckoutStepIndicator({
    super.key,
    required this.currentStep,
    this.onStepTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: AppTheme.paddingInset,
        horizontal: AppTheme.paddingMedium,
      ),
      color: AppTheme.cardBackground,
      child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(_labels.length, (index) {
              final bool isDoneOrActive = index <= currentStep;

              final bool isClickable = index <= currentStep && onStepTap != null;
              return GestureDetector(
                onTap: isClickable ? () => onStepTap!(index) : null,
                child: MouseRegion(
                  cursor:
                      isClickable
                          ? SystemMouseCursors.click
                          : SystemMouseCursors.basic,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomPaint(
                        size: const Size(
                          AppTheme.stepChevronWidth,
                          AppTheme.stepChevronHeight,
                        ),
                        painter: _ChevronPainter(
                          color:
                              isDoneOrActive
                                  ? AppTheme.stepChevronActive
                                  : AppTheme.grey300,
                          isFirst: index == 0,
                          isLast: index == _labels.length - 1,
                        ),
                      ),
                      const SizedBox(height: AppTheme.paddingCompact),
                      Text(
                        _labels[index],
                        style: TextStyle(
                          fontSize: AppTheme.fontSizeSmall,
                          fontWeight:
                              index == currentStep
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                          color:
                              index <= currentStep
                                  ? AppTheme.colorBlack
                                  : AppTheme.textMutedMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _ChevronPainter extends CustomPainter {
  final Color color;
  final bool isFirst;
  final bool isLast;

  _ChevronPainter({
    required this.color,
    required this.isFirst,
    required this.isLast,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color
          ..style = PaintingStyle.fill
          ..isAntiAlias = true;

    final path = Path();
    const double arrowDepth = AppTheme.paddingMediumSmall;
    const double gap = AppTheme.paddingMicro;

    if (isFirst) {
      path.moveTo(AppTheme.paddingCompact, 0);
      path.lineTo(size.width - arrowDepth, 0);
      path.lineTo(size.width, size.height / 2);
      path.lineTo(size.width - arrowDepth, size.height);
      path.lineTo(AppTheme.paddingCompact, size.height);
      path.quadraticBezierTo(0, size.height, 0, size.height - AppTheme.paddingCompact);
      path.lineTo(0, AppTheme.paddingCompact);
      path.quadraticBezierTo(0, 0, AppTheme.paddingCompact, 0);
    } else if (isLast) {
      path.moveTo(0, 0);
      path.lineTo(size.width - AppTheme.paddingCompact, 0);
      path.quadraticBezierTo(size.width, 0, size.width, AppTheme.paddingCompact);
      path.lineTo(size.width, size.height - AppTheme.paddingCompact);
      path.quadraticBezierTo(
        size.width,
        size.height,
        size.width - AppTheme.paddingCompact,
        size.height,
      );
      path.lineTo(0, size.height);
      path.lineTo(arrowDepth, size.height / 2);
      path.close();
    } else {
      path.moveTo(0, 0);
      path.lineTo(size.width - arrowDepth, 0);
      path.lineTo(size.width, size.height / 2);
      path.lineTo(size.width - arrowDepth, size.height);
      path.lineTo(0, size.height);
      path.lineTo(arrowDepth, size.height / 2);
      path.close();
    }

    canvas.save();
    if (!isFirst) canvas.translate(gap, 0);
    canvas.drawPath(path, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_ChevronPainter oldDelegate) => oldDelegate.color != color;
}
