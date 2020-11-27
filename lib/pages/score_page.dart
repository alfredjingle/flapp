import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flapp/model/game_model.dart';
import 'package:flapp/pages/game_page.dart';
import 'package:flapp/utils/constants.dart';
import 'package:flapp/utils/question_generator.dart';

class ScorePage extends StatefulWidget {
  @override
  _ScorePageState createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _scale;
  Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2500));
    _scale = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _controller, curve: Interval(0.0, 0.4, curve: Curves.linear)));
    _fadeIn = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _controller, curve: Interval(0.6, 1.0, curve: Curves.linear)));
    Future.delayed(Duration(milliseconds: 500), () => _controller.forward());
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gameState = GameModel.of(context, listen: false);
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.red, Colors.yellow])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ScaleTransition(
                scale: _scale,
                child: Column(
                  children: <Widget>[
                    Text(
                      'Your score',
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${gameState.notifier.score} / ${Constants.kTotalQuestions}',
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    )
                  ],
                ),
              ),
              SizedBox(height: 24.0),
              FadeTransition(
                opacity: _fadeIn,
                child: RaisedButton(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    'Play agian',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    gameState.notifier
                        .reset(questionGenerator(Constants.kTotalQuestions));
                    Navigator.of(context).pushReplacement(
                        PageRouteBuilder<void>(pageBuilder:
                            (BuildContext context, animation,
                                secondaryAnimation) {
                      return GamePage();
                    }));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
