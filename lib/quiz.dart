import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/data/questions.dart';
import 'package:flutter_quiz_app/home_page.dart';
import 'package:flutter_quiz_app/questions_page.dart';
import 'package:flutter_quiz_app/result_page.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  List<String> selectedAnswers = [];

  var activePage = "home-page";

  void switchPage() {
    setState(() {
      activePage = "questions-page";
    });
  }

  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);

    if (selectedAnswers.length == questions.length) {
      setState(() {
        activePage = "result-page";
      });
    }
  }

  void restartQuiz() {
    setState(() {
      selectedAnswers = [];
      activePage = "home-page";
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget currentPage = HomePage(switchPage);
    if (activePage == "questions-page") {
      currentPage = QuestionsPage(
        onSelectAnswer: chooseAnswer,
      );
    } else if (activePage == "result-page") {
      currentPage = ResultPage(
        chosenAnswer: selectedAnswers,
        restartQuiz: restartQuiz,
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 78, 13, 151),
                Color.fromARGB(255, 107, 15, 168),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: currentPage,
        ),
      ),
    );
  }
}
