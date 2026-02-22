part of '../ticket_detail_view.dart';

class _TicketSeparator extends StatelessWidget {
  final double height;
  final Color color;

  const _TicketSeparator({this.height = 20.0, this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: CustomPaint(painter: _SeparatorPainter(color: color)),
    );
  }
}

class _SeparatorPainter extends CustomPainter {
  final Color color;

  _SeparatorPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final double radius = size.height / 2;

    final pathLeft = Path()
      ..moveTo(0, 0)
      ..arcToPoint(
        Offset(0, size.height),
        radius: Radius.circular(radius),
        clockwise: true,
      );
    canvas.drawPath(pathLeft, paint);

    final pathRight = Path()
      ..moveTo(size.width, 0)
      ..arcToPoint(
        Offset(size.width, size.height),
        radius: Radius.circular(radius),
        clockwise: false,
      );
    canvas.drawPath(pathRight, paint);

    final dashPaint = Paint()
      ..color = color
      ..strokeWidth = 1.0
      ..style = PaintingStyle.fill;

    double dashWidth = 5;
    double dashSpace = 5;
    double startX = radius + 5;
    double endX = size.width - radius - 5;
    double y = size.height / 2;

    while (startX < endX) {
      // Рисуем черточку
      canvas.drawLine(
        Offset(startX, y),
        Offset(startX + dashWidth > endX ? endX : startX + dashWidth, y),
        dashPaint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
