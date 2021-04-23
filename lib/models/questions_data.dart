// Packages:
import 'package:flutter/material.dart';

// Screens:

// Models:

// Components:

// Helpers:

// Utilities:

class QuestionsData {
  // Properties:
  int _questionIndex = 0;
  int _totalScore = 0;
  static const List<Map> _questions = const [
    {
      'questionText': 'What is your favorite color?',
      'answers': [
        {'text': 'Black', 'score': 10},
        {'text': 'Red', 'score': 7},
        {'text': 'Blue', 'score': 3},
        {'text': 'White', 'score': 1},
      ],
    },
    {
      'questionText': 'What is your favorite animal?',
      'answers': [
        {'text': 'Panther', 'score': 7},
        {'text': 'Horse', 'score': 10},
        {'text': 'Dolphin', 'score': 3},
        {'text': 'Whale', 'score': 1},
      ],
    },
    {
      'questionText': 'What is your favorite instructor?',
      'answers': [
        {'text': 'Angela', 'score': 10},
        {'text': 'Future Angela', 'score': 7},
        {'text': 'Future Maximilian', 'score': 3},
        {'text': 'Maximilian', 'score': 1},
      ],
    },
    {
      'questionText': 'What is your favorite food?',
      'answers': [
        {'text': 'Spaghetti', 'score': 10},
        {'text': 'Pizza', 'score': 7},
        {'text': 'Fried Chicken', 'score': 3},
        {'text': 'Salad', 'score': 1},
      ],
    },
  ];

  // Getters:
  List<Map> get questions {
    return _questions;
  }

  int get questionIndex {
    return _questionIndex;
  }

  int get totalScore {
    return _totalScore;
  }

  String quizInterpretation(int score) {
    String result = '';

    if (score >= 40) {
      result = 'You are awesome!';
    } else if (30 <= score && score < 40) {
      result = 'You are cool!';
    } else if (20 <= score && score < 30) {
      result = 'You are ok!';
    } else if (10 <= score && score < 20) {
      result = 'You could improve!';
    } else if (4 < score && score < 10) {
      result = 'You are boring!';
    } else if (score == 4) {
      result = 'You are very boring!';
    }

    return result;
  }

  // Public methods:
  String currentQuestionText() {
    return _questions[_questionIndex]['questionText'];
  }

  List<Map> currentAnswers() {
    return _questions[_questionIndex]['answers'];
  }

  void restartQuestionIndex() {
    _questionIndex = 0;
    _totalScore = 0;
  }

  void answerQuestion(int score) {
    // Do something else...
    // Increase index:
    _totalScore += score;
    _increaseIndex();
  }

  // Private methods:
  void _increaseIndex() {
    // if (_questionIndex == _questions.length - 1 || _questions.length == 0) {
    //   _questionIndex = 0;
    // } else {
    //   _questionIndex++;
    // }

    // if (_questionIndex < _questions.length - 1) {
    //   _questionIndex++;
    // }

    _questionIndex++;
  }
}
