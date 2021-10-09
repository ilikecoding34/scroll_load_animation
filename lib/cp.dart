import 'package:flutter/material.dart';

class RPSCustomPainter extends CustomPainter {
  final double meret;
  double eltolas = 20;

  RPSCustomPainter(this.meret);
  @override
  void paint(Canvas canvas, Size size) {
    /*
    Paint paint_0 = new Paint()
      ..color = Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    Path path_0 = Path();

    canvas.drawPath(path_0, paint_0);

    Paint paint_1 = new Paint()
      ..color = Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;

    Offset center = Offset(120, 60);

    canvas.drawCircle(center, (meret - 40) / 2, paint_1);

    Paint paint_2 = new Paint()
      ..color = Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;

    Offset center2 = Offset(260, 60);

    canvas.drawCircle(center2, (meret - 25) / 2, paint_2);

    Paint paint_3 = new Paint()
      ..color = Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;
    late double szam;
    if (meret < 80) {
      szam = 0.350000;
    } else {
      szam = 0.3500 + (((meret / 100) - 0.8) / 4);
    }

    Path path_3 = Path();
    path_3.moveTo(size.width * 0.3, size.height * 0.35000);
    path_3.quadraticBezierTo(size.width * 0.3, size.height * szam,
        size.width * 0.50000, size.height * szam);
    path_3.quadraticBezierTo(size.width * 0.7, size.height * szam,
        size.width * 0.700, size.height * 0.3500000);

    canvas.drawPath(path_3, paint_3);
*/
    Paint paint_0 = new Paint()
      ..color = Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.fill
      ..strokeWidth = 10;

    late double hullam;
    late double hullamiv;
    bool fel = true;
    bool le = false;
    hullam = (meret / 100) - (meret / 100).floorToDouble();
    if (hullam > 0.5) {
      hullamiv = ((0.5 - ((hullam - 0.5) * 2)) / 5);
    } else {
      hullamiv = -0.1 + ((hullam / 5) * 2);
    }
    // print('$hullamiv, $hullam');
    Path path_0 = Path();

    path_0.moveTo(0, size.height);
    path_0.lineTo(0, size.height * 0.1960000);
    path_0.quadraticBezierTo(
        size.width * 0.1828125,
        size.height * (0.1995000 - hullamiv),
        size.width * 0.3125000,
        size.height * 0.1980000);
    path_0.cubicTo(
        size.width * 0.4381250,
        size.height * (0.1995000 + hullamiv),
        size.width * 0.5393750,
        size.height * (0.1995000 + hullamiv),
        size.width * 0.6862500,
        size.height * 0.2040000);
    path_0.quadraticBezierTo(
        size.width * 0.8225000,
        size.height * (0.1995000 - hullamiv),
        size.width * 0.9675000,
        size.height * 0.2040000);
    path_0.lineTo(size.width * 0.9675000, size.height);

    canvas.drawPath(path_0, paint_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
