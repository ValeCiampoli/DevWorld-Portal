
//Copy this CustomPainter code to the Bottom of the File
import 'package:flutter/material.dart';

class RPSCustomPainter extends CustomPainter {
    @override
    void paint(Canvas canvas, Size size) {
            
Path path_0 = Path();
    path_0.moveTo(size.width,size.height*0.8688563);
    path_0.lineTo(size.width,0);
    path_0.lineTo(0,0);
    path_0.lineTo(0,size.height);
    path_0.lineTo(size.width,size.height);
    path_0.lineTo(size.width,size.height*0.8602799);
    path_0.lineTo(size.width,size.height*0.8688563);
    path_0.close();

Paint paint_0_fill = Paint()..style=PaintingStyle.fill;
paint_0_fill.color = Color(0xffffde00).withOpacity(1.0);
canvas.drawPath(path_0,paint_0_fill);

Path path_1 = Path();
    path_1.moveTo(size.width*0.8585163,size.height);
    path_1.lineTo(size.width,size.height*0.8688563);
    path_1.lineTo(size.width*0.8585163,size.height*0.8602799);
    path_1.lineTo(size.width*0.8585163,size.height);
    path_1.close();

Paint paint_1_fill = Paint()..style=PaintingStyle.fill;
paint_1_fill.color = Color(0xfff9b233).withOpacity(1.0);
canvas.drawPath(path_1,paint_1_fill);

}

@override
bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
}
}