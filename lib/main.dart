import 'package:flapp/model/game_model.dart';
import 'package:flapp/pages/welcome_page.dart';
import 'package:flapp/state/game_state.dart';
import 'package:flapp/utils/constants.dart';
import 'package:flapp/utils/question_generator.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Flapp());
}

class Flapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final questions = questionGenerator(Constants.kTotalQuestions);
    final gameState = GameState(questions);

    return GameModel(
      notifier: gameState,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flapp',
        home: WelcomePage(),
      ),
    );
  }
}
