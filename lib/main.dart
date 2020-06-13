import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/QuestionLogic.dart';

import 'Question.dart';

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

QuestionLogic questionLogic = QuestionLogic();

class _QuizPageState extends State<QuizPage> {
  int index = 0;
  String soru = questionLogic.soruDondur(0).soru;
  List<Icon> iconListesi = List();

  void butonOnClick(bool dogrulukMu) {
    setState(() {
      if (listeKontrolu()) {
        listeyeIconEkle(dogrulukMu);
        index++;
        soru = questionLogic.soruDondur(index).soru;
      } else {}
    });
  }

  bool listeKontrolu() => index < questionLogic.listeBoyutu();

  void listeyeIconEkle(bool dogrulukMu) {
    Question question = questionLogic.soruDondur(index);
    if (question.dogruMu == dogrulukMu)
      iconListesi.add(
        Icon(
          Icons.check,
          color: Colors.green,
        ),
      );
    else
      iconListesi.add(
        Icon(
          Icons.close,
          color: Colors.red,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
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
                soru,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
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
                butonOnClick(true);
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
                butonOnClick(false);
              },
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: iconListesi,
        )
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
