import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/QuestionLogic.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'Question.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
  int dogruSayisi = 0;
  String soru = questionLogic.soruDondur(0).soru;
  List<Icon> iconListesi = List();

  void butonOnClick(bool dogrulukMu) {
    setState(() {
      if (listeKontrolu()) {
        listeyeIconEkle(dogrulukMu);
        index++;
        soru = questionLogic.soruDondur(index).soru;
      } else {
        alertGoster();
      }
    });
  }

  void oyunuSifirla() {
    setState(() {
      index = 0;
      dogruSayisi = 0;
      iconListesi.clear();
    });
  }

  bool listeKontrolu() => index < questionLogic.listeBoyutu();

  void listeyeIconEkle(bool dogrulukMu) {
    Question question = questionLogic.soruDondur(index);
    if (question.dogruMu == dogrulukMu) {
      iconListesi.add(
        Icon(
          Icons.check,
          color: Colors.green,
        ),
      );
      dogruSayisi++;
    } else
      iconListesi.add(
        Icon(
          Icons.close,
          color: Colors.red,
        ),
      );
  }

  void alertGoster() {
    Alert(
      context: context,
      type: AlertType.success,
      title: "OYUN TAMAMLANDI",
      desc: "$dogruSayisi adet soru bilindi.",
      buttons: [
        DialogButton(
          child: Text(
            "Tekrar Dene",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            oyunuSifirla();
            Navigator.pop(context);
          },
          width: 140,
        )
      ],
    ).show();
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
