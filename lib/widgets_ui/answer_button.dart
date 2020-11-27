import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AnswerButton extends StatelessWidget {
  final String buttonText;
  final Color buttonTextColour;
  final Color buttonColour;
  final VoidCallback onPressed;

  AnswerButton(
      {@required this.buttonText,
      @required this.buttonTextColour,
      @required this.buttonColour,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      height: 60,
      minWidth: 120,
      buttonColor: buttonColour,
      child: RaisedButton(
        onPressed: onPressed,
        elevation: 2.0,
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 18, color: buttonTextColour),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    );
  }
}
