import 'package:flutter/material.dart';

class HeartView extends StatefulWidget {
  const HeartView({Key? key, required this.size, required this.heartColor})
      : super(key: key);

  final double size;
  final Color heartColor;

  @override
  HeartViewState createState() => HeartViewState();
}

class HeartViewState extends State<HeartView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        size: Size(widget.size - 10, widget.size),
        painter: HeartPainter(heartColor: widget.heartColor),
      ),
    );
  }
}

class HeartPainter extends CustomPainter {
  HeartPainter({Key? key, required this.heartColor}) : super();

  Color heartColor;

  @override
  void paint(Canvas canvas, Size size) {
    Paint hearthCircuit = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 6;

    Paint hearthFill = Paint()
      ..color = heartColor
      ..style = PaintingStyle.fill
      ..strokeWidth = 0;

    double width = size.width;
    double height = size.height;

    Path path = Path();
    path.moveTo(0.5 * width, height * 0.35);
    path.cubicTo(0.2 * width, height * 0.1, -0.25 * width, height * 0.6,
        0.5 * width, height);
    path.moveTo(0.5 * width, height * 0.35);
    path.cubicTo(0.8 * width, height * 0.1, 1.25 * width, height * 0.6,
        0.5 * width, height);

    canvas.drawPath(path, hearthFill);
    canvas.drawPath(path, hearthCircuit);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
