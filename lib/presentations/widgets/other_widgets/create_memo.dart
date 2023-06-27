import 'package:flutter/material.dart';
 import 'package:portal/presentations/widgets/other_widgets/memo_painter.dart';

class CreateMemo extends StatelessWidget {
  const CreateMemo({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController memoController = TextEditingController();
    return Material(
      child: SizedBox(
        width: 200,
        height: 200,
        child: Stack(
          children: [
            CustomPaint(
              size: Size(
                  200,
                  (200 * 1.0516378413201843)
                      .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
              painter: RPSCustomPainter(),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: SizedBox(
                  width: 170,
                  height: 170,
                  child: TextField(
                    controller: memoController,
                    style: const TextStyle(fontSize: 14),
                    maxLines: 7,
                    decoration: const InputDecoration(
                        isDense: false, border: InputBorder.none),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
