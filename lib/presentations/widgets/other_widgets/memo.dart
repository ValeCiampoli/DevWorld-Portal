import 'package:flutter/material.dart';
import 'package:portal/data/models/memo_model.dart';
import 'package:portal/presentations/widgets/other_widgets/memo_painter.dart';

class Memo extends StatelessWidget {
  final MemoModel memo;
  const Memo({super.key, required this.memo});

  @override
  Widget build(BuildContext context) {
    TextEditingController memoController = TextEditingController();
    memoController.text = memo.body;
    return Material(
      child: SizedBox(
        width: 200,
        height: 200,
        child: Stack(
          children: [
            Container(
              width: 200,
              height: 200 * 1.0516378413201843,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: CustomPaint(
                size: Size(
                    200,
                    (200 * 1.0516378413201843)
                        .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                painter: RPSCustomPainter(),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: SizedBox(
                  width: 170,
                  height: 170,
                  child: Text(
                    memo.body,
                    style: const TextStyle(fontSize: 14),
                    maxLines: 7,
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
