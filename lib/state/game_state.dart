import 'package:flutter/widgets.dart';
import 'package:flapp/utils/constants.dart';
import 'package:flapp/utils/key_value.dart';

class GameState extends ChangeNotifier {
  List<KeyValue<AnswerCategory, String>> _questions;
  int _currentQuestion;
  int _score;

  GameState(this._questions, [this._currentQuestion = 1, this._score = 0]);

  int get currentQuestion => _currentQuestion;
  int get score => _score;

  KeyValue<AnswerCategory, String> getQuestion() {
    return _questions.removeLast();
  }

  bool isLastQuestion() {
    return _questions.isEmpty;
  }

  void incrementQuestion() {
    _currentQuestion += 1;
    notifyListeners();
  }

  void incrementScore() {
    _score += 1;
  }

  void reset(List<KeyValue<AnswerCategory, String>> questions) {
    _currentQuestion = 1;
    _score = 0;
    _questions = questions;
  }
}
