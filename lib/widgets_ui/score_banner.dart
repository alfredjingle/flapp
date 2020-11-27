import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flapp/model/game_model.dart';
import 'package:flapp/utils/constants.dart';

class ScoreBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gameState = GameModel.of(context).notifier;
    final headerTextStyle = TextStyle(color: Colors.white, fontSize: 20);
    return Container(
      height: kToolbarHeight,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(
              '${gameState.currentQuestion} / ${Constants.kTotalQuestions}',
              style: headerTextStyle,
            ),
            Expanded(
              child: Container(),
            ),
            Text(
              'Score: ${gameState.score}',
              style: headerTextStyle,
            )
          ],
        ),
      ),
    );
  }
}
