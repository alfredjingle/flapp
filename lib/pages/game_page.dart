import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flapp/model/game_model.dart';
import 'package:flapp/pages/score_page.dart';
import 'package:flapp/state/game_state.dart';
import 'package:flapp/utils/constants.dart';
import 'package:flapp/utils/key_value.dart';
import 'package:flapp/widgets_ui/answer_button.dart';
import 'package:flapp/widgets_ui/playing_card.dart';
import 'package:flapp/widgets_ui/score_banner.dart';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage>
    with SingleTickerProviderStateMixin {
  final _playingCardKey = GlobalKey<FlipCardState>();
  AnimationController _controller;
  Animation<Offset> _offsetAnimation;
  Color _lButtonColour = Colors.white;
  Color _lButtonTextColour = Colors.black;
  VoidCallback _lButtonCallback;
  VoidCallback _rButtonCallback;
  Color _rButtonColour = Colors.white;
  Color _rButtonTextColour = Colors.black;
  KeyValue<AnswerCategory, String> _currentQuestion;

  @override
  void initState() {
    super.initState();
    _lButtonCallback = () async {
      await _selectAnswer(AnswerCategory.left);
    };
    _rButtonCallback = () async {
      await _selectAnswer(AnswerCategory.right);
    };
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(1.5, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));
    _currentQuestion =
        GameModel.of(context, listen: false).notifier.getQuestion();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.red, Colors.yellow])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ScoreBanner(),
            const SizedBox(height: 16.0),
            SlideTransition(
              position: _offsetAnimation,
              child: FlipCard(
                  key: _playingCardKey,
                  direction: FlipDirection.HORIZONTAL,
                  flipOnTouch: false,
                  front: PlayingCard(_currentQuestion.value + '_q.png'),
                  back: PlayingCard(_currentQuestion.value + '_a.png')),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 32.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      AnswerButton(
                          buttonColour: _lButtonColour,
                          buttonText: 'FERRARI',
                          buttonTextColour: _lButtonTextColour,
                          onPressed: _lButtonCallback),
                      AnswerButton(
                          buttonColour: _rButtonColour,
                          buttonText: 'LAMBO',
                          buttonTextColour: _rButtonTextColour,
                          onPressed: _rButtonCallback)
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _selectAnswer(AnswerCategory answer) async {
    final gameState = GameModel.of(context).notifier;
    _disableButtonTaps();
    _highlightSelectedAnswer(answer);
    await Future.delayed(Duration(seconds: 1));

    _playingCardKey.currentState.toggleCard();
    await Future.delayed(Duration(seconds: 1));

    _checkAnswer(gameState, answer);
    await Future.delayed(Duration(seconds: 2));

    _controller.forward();
    await Future.delayed(Duration(milliseconds: 500));

    if (gameState.isLastQuestion()) {
      Navigator.of(context).pushReplacement(PageRouteBuilder<void>(
          pageBuilder: (BuildContext context, animation, secondaryAnimation) {
        return ScorePage();
      }));
      return;
    }

    setState(() {
      _offsetAnimation = Tween<Offset>(
        begin: const Offset(-1.5, 0.0),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ));
      _currentQuestion = gameState.getQuestion();
    });
    _playingCardKey.currentState.toggleCard();
    _controller.reset();
    _controller.forward();
    await Future.delayed(Duration(milliseconds: 500));

    setState(() {
      _offsetAnimation = Tween<Offset>(
        begin: Offset.zero,
        end: const Offset(1.5, 0.0),
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ));
    });
    _controller.reset();

    gameState.incrementQuestion();
    _resetButtons();
  }

  void _disableButtonTaps() {
    setState(() {
      _lButtonCallback = () {};
      _rButtonCallback = () {};
    });
  }

  void _resetButtons() {
    setState(() {
      _lButtonColour = Colors.white;
      _lButtonTextColour = Colors.black;
      _lButtonCallback = () async {
        await _selectAnswer(AnswerCategory.left);
      };
      _rButtonColour = Colors.white;
      _rButtonTextColour = Colors.black;
      _rButtonCallback = () async {
        await _selectAnswer(AnswerCategory.right);
      };
    });
  }

  void _highlightSelectedAnswer(AnswerCategory answer) {
    switch (answer) {
      case AnswerCategory.left:
        {
          setState(() {
            _lButtonColour = Colors.yellow.shade700;
            _lButtonTextColour = Colors.white;
          });
        }
        break;
      case AnswerCategory.right:
        {
          setState(() {
            _rButtonColour = Colors.yellow.shade700;
            _rButtonTextColour = Colors.white;
          });
        }
    }
  }

  void _checkAnswer(GameState gameState, AnswerCategory answer) {
    if (answer == _currentQuestion.key) {
      gameState.incrementScore();
      switch (answer) {
        case AnswerCategory.left:
          {
            setState(() {
              _lButtonColour = Colors.green.shade700;
            });
          }
          break;
        case AnswerCategory.right:
          {
            setState(() {
              _rButtonColour = Colors.green.shade700;
            });
          }
      }
    } else {
      switch (answer) {
        case AnswerCategory.left:
          {
            setState(() {
              _lButtonColour = Colors.red.shade700;
            });
          }
          break;
        case AnswerCategory.right:
          {
            setState(() {
              _rButtonColour = Colors.red.shade700;
            });
          }
      }
    }
  }
}
