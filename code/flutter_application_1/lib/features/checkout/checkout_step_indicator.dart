import 'package:flutter/material.dart';
import 'package:imat_app/core/theme/app_theme.dart';

class CheckoutStepIndicator extends StatelessWidget {
  final int currentStep; // 0–3

  static const _labels = [
    '1. Granskning',
    '2. Leverans',
    '3. Betalning',
    '4. Slutför',
  ];

  const CheckoutStepIndicator({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Låter den ta plats
      padding: const EdgeInsets.symmetric(
        vertical: AppTheme.paddingInset,
        horizontal: AppTheme.paddingMedium,
      ),
      color: Colors.white,
      child: Center(
        child: SingleChildScrollView(
          // Försäkrar att den inte kraschar på små skärmar
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(_labels.length, (index) {
              final bool isDoneOrActive = index <= currentStep;

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomPaint(
                    // Mycket bredare (160), men behåller slimmad höjd (14)
                    size: const Size(160, 14),
                    painter: _ChevronPainter(
                      color:
                          isDoneOrActive
                              ? const Color(0xFF4C8C4A)
                              : const Color(0xFFE0E0E0),
                      isFirst: index == 0,
                      isLast: index == _labels.length - 1,
                    ),
                  ),
                  const SizedBox(height: AppTheme.paddingCompact),
                  Text(
                    _labels[index],
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight:
                          index == currentStep
                              ? FontWeight.bold
                              : FontWeight.w500,
                      color:
                          index <= currentStep ? Colors.black : Colors.black45,
                    ),
                  ),
                ],
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
    const double arrowDepth = 12.0;
    const double gap = 2.5;

    if (isFirst) {
      path.moveTo(10, 0);
      path.lineTo(size.width - arrowDepth, 0);
      path.lineTo(size.width, size.height / 2);
      path.lineTo(size.width - arrowDepth, size.height);
      path.lineTo(10, size.height);
      path.quadraticBezierTo(0, size.height, 0, size.height - 10);
      path.lineTo(0, 10);
      path.quadraticBezierTo(0, 0, 10, 0);
    } else if (isLast) {
      path.moveTo(0, 0);
      path.lineTo(size.width - 10, 0);
      path.quadraticBezierTo(size.width, 0, size.width, 10);
      path.lineTo(size.width, size.height - 10);
      path.quadraticBezierTo(
        size.width,
        size.height,
        size.width - 10,
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
