import 'dart:math';

import 'package:flapp/utils/constants.dart';
import 'package:flapp/utils/key_value.dart';

List<KeyValue<AnswerCategory, String>> questionGenerator(int totalQuestions) {
  final random = Random();
  final questions = Set<KeyValue<AnswerCategory, String>>();
  while (questions.length < totalQuestions) {
    final question = KeyValue<AnswerCategory, String>();
    String imagePath = 'images/';
    final category = random.nextInt(2);
    if (category == 0) {
      imagePath += 'left/';
      question.key = AnswerCategory.left;
    } else {
      imagePath += 'right/';
      question.key = AnswerCategory.right;
    }
    final questionNumber = random.nextInt(totalQuestions);
    imagePath += '$questionNumber';
    question.value = imagePath;
    questions.add(question);
  }
  print(questions.length);
  return questions.toList();
}
