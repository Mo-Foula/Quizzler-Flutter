import 'dart:math';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/material.dart';
import 'package:quizzler/Question.dart';
import 'package:quizzler/Quiz.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int T = 0, F = 0;
  static Quiz quiz = Quiz();

  List<Question> MyQuestions = []..addAll(quiz.Questions);

//  Map<String , bool> QuestionsAnswers = {
//    'You can lead a cow down stairs but not up stairs.': false,
//    'Approximately one quarter of human bones are in the feet.': true,
//    'A slug\'s blood is green.': true,
//  };

//  List<String> Questions = [
//    'You can lead a cow down stairs but not up stairs.',
//    'Approximately one quarter of human bones are in the feet.',
//    'A slug\'s blood is green.'
//  ];
//
//  List<bool> Answers = [false, true, true];

  void Checker(Question Q, bool userans) {
    if (!finished) {
      if (Q.A == userans) {
        setState(() {
          score.add(makeIcon(Colors.green, Icons.check));
          T++;
        });
      } else {
        setState(() {
          F++;
          score.add(makeIcon(Colors.red, Icons.close));
        });
      }
      generate();
    }
  }

//  void ADDTRUE() {
//    setState(() {
//
//      truee++;
//      if (truee + falsee >= 3)
//        QQ = 'You scored $truee correct answers and $falsee wrong answers';
//      else
//        QQ = Questions[truee + falsee];
//      score.add(makeIcon(Colors.green, Icons.check));
//    });
//  }
//
//  void ADDFALSE() {
//    setState(() {
//      falsee++;
//      if (truee + falsee >= 3)
//        QQ = 'You scored $truee correct answers and $falsee wrong answers';
//      else
//        QQ = Questions[truee + falsee];
//      score.add(makeIcon(Colors.red, Icons.close));
//    });
//  }

  Icon makeIcon(Color a, IconData b) {
    return Icon(
      b,
      color: a,
    );
  }

  void generate() {
    if (MyQuestions.isEmpty) {
      showResult();
      _enabled = true;
      finished = true;
    } else {
      setState(() {
        print(MyQuestions.length);
        QT = MyQuestions[Random().nextInt(MyQuestions.length)];
        MyQuestions.remove(QT);
        QQ = QT.Q;
      });
    }
  }

  void showResult() {
    setState(() {
//      QQ = 'You scored $T correct answers and $F wrong answers';
    if(T>F){
      Alert(
        context: context,
        type: AlertType.success,
        title: "Goodjob",
        desc: 'You scored $T correct answers and $F wrong answers',
        buttons: [
          DialogButton(
            child: Text(
              "COOL",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
    }
    else {
      Alert(
        context: context,
        type: AlertType.error,
        title: "Try Again!",
        desc: 'You scored $T correct answers and $F wrong answers',
        buttons: [
          DialogButton(
            child: Text(
              "Okay",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
    }

    });

  }

  List<Icon> score = [

  ];
  var _enabled = false;
  bool finished = false;
  String TX;
  Question QT = quiz.Questions[Random().nextInt(quiz.Questions.length)];
  String QQ = quiz.Questions[Random().nextInt(quiz.Questions.length)].Q;
  var _pressed;
  @override
  Widget build(BuildContext context) {
    if (_enabled) {
      TX = 'reset';
      _pressed = () {
        setState(() {
          _enabled = false;
          T = 0;
          F = 0;
          finished = false;
          MyQuestions = []..addAll(quiz.Questions);
          QT = MyQuestions[Random().nextInt(MyQuestions.length)];
          MyQuestions.remove(QT);
          QQ = QT.Q;
          score.clear();
        });
      };
    } else{
      TX = "";
      _pressed = null;
    }

    if (MyQuestions.contains(QT)) MyQuestions.remove(QT);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                QQ,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Row(

          children: score,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.purple,
              child: Text(
                TX,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: _pressed,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                //The user picked true.
                Checker(QT, true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                Checker(QT, false);
                //The user picked false.
              },
            ),
          ),
        ),
        //TODO: Add a Row here as your score keeper

      ],
    );
  }
}

//  'You can lead a cow down stairs but not up stairs.', false

//question2: 'Approximately one quarter of human bones are in the feet.', true,
//question3: 'A slug\'s blood is green.', true,
