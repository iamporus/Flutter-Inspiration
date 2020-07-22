import 'package:flutter/material.dart';
import 'package:flutter_design_challenge/designs/DesignListing.dart';
import 'package:flutter_design_challenge/widgets/DesignWidget.dart';

class DesignListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomPaint(
      painter: BackgroundPaint(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: new AppBar(
          elevation: 0.0,
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Flutter Design Gallery",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: Container(
          child: ListView.builder(
              itemCount: DesignListing.getAvailableDesignCount(),
              itemBuilder: (context, i) {
                return _buildDesignListItem(i);
              }),
        ),
      ),
    ));
  }

  Widget _buildDesignListItem(int i) {
    return DesignWidget(design: DesignListing.getAvailableDesigns()[i]);
  }
}

class BackgroundPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    final paint = Paint();

    //paint blue-gray background
    final path = Path();
    path.addRect(Rect.fromLTRB(0, 0, width, height));
    paint.color = Colors.blueGrey.shade800;
    canvas.drawPath(path, paint);
    path.close();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
