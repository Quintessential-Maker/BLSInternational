import 'package:flutter/material.dart';

class NumberStepper extends StatelessWidget {
  final double width;
  final totalSteps;
  final int curStep;
  final Color stepCompleteColor;
  final Color currentStepColor;
  final Color inactiveColor;
  final double lineWidth;

  NumberStepper({
    Key? key,
    required this.width,
    required this.curStep,
    required this.stepCompleteColor,
    required this.totalSteps,
    required this.inactiveColor,
    required this.currentStepColor,
    required this.lineWidth,
  })  : assert(curStep > 0 == true && curStep <= totalSteps + 1),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 10.0,
        left: 5.0,
        right: 5.0,
      ),
      width: this.width,
      child: Row(
        children: _steps(),
      ),
    );
  }

  getCircleColor(i) {
    var color;
    if (i + 1 < curStep) {
      color = stepCompleteColor;
    } else if (i + 1 == curStep)
      color = currentStepColor;
    else
      color = Colors.white;
    return color;
  }

  getBorderColor(i) {
    var color;
    if (i + 1 < curStep) {
      color = stepCompleteColor;
    } else if (i + 1 == curStep)
      color = currentStepColor;
    else
      color = inactiveColor;

    return color;
  }

  getLineColor(i) {
    var color =
        curStep > i + 1 ? Colors.blue.withOpacity(0.4) : Colors.grey[200];
    return color;
  }

  List<Widget> _steps() {
    var list = <Widget>[];
    for (int i = 0; i < totalSteps; i++) {
      //colors according to state

      var circleColor = getCircleColor(i);
      var borderColor = getBorderColor(i);
      var lineColor = getLineColor(i);

      // step circles
      list.add(
        Column(
          children: [
            Container(
              width: 28.0,
              height: 28.0,
              child: getInnerElementOfStepper(i),
              decoration: new BoxDecoration(
                color: circleColor,
                borderRadius: new BorderRadius.all(new Radius.circular(25.0)),
                border: new Border.all(
                  color: borderColor,
                  width: 1.0,
                ),
              ),
            ),
            labelName(i)
          ],
        ),
      );

      //line between step circles
      if (i != totalSteps - 1) {
        list.add(
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: 30),
              height: lineWidth,
              color: lineColor,
            ),
          ),
        );
      }
    }

    return list;
  }

  Widget labelName(index) {
    if (index == 0) {
      return Text(
        "File An \nApplication",
        style: TextStyle(fontSize: 10),
        textAlign: TextAlign.center,
      );
    } else if (index == 1) {
      return Text(
        "File An \nApplication",
        style: TextStyle(fontSize: 10),
        textAlign: TextAlign.center,
      );
    } else if (index == 2) {
      return Text(
        "File An \nApplication",
        style: TextStyle(fontSize: 10),
        textAlign: TextAlign.center,
      );
    } else if (index == 3) {
      return Text(
        "File An \nApplication",
        style: TextStyle(fontSize: 10),
        textAlign: TextAlign.center,
      );
    } else
      return Container();
  }

  Widget getInnerElementOfStepper(index) {
    if (index + 1 < curStep) {
      return Icon(
        Icons.check,
        color: Colors.white,
        size: 16.0,
      );
    } else if (index + 1 == curStep) {
      return Center(
        child: Text(
          '$curStep',
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto',
          ),
        ),
      );
    } else
      return Container();
  }
}
