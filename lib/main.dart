import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Questions.dart';
//import 'Question.dart';
void main() {
  runApp(

    MaterialApp(
       home :  MyQuiz()
     ),
  );
}
class MyQuiz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',color: Colors.white,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white24,
        body : SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 50 , horizontal: 10),
            child: Questionpage(),
          ),
         ),
      ),
    );
  }
  }
class Questionpage extends StatefulWidget {
  @override
  _QuestionpageState createState() => _QuestionpageState();
}

class _QuestionpageState extends State<Questionpage> {


  int currentQuestion = 0;// to go the next question
  int score = 0;//to display the result for user
  //now we create tow object to change the result correct and wrong
  int correctCounter =0;
  int wrongCounter =0 ;
  //we make add prameter bool to link the buttons and  texts (correct and wrong )
  //we create Object t completed the quiz
  bool quizCompleted = false;
  void nextQuestion(bool answer,BuildContext context){
     setState((){

       //we change this code to boolean like this
       if (!quizCompleted){if (questions[currentQuestion].answer == answer)
       {correctCounter++;
       score += 10;
       }
       else
         {wrongCounter++;}}
       if (questions.length -1 > currentQuestion)
          { currentQuestion++;}
       else{
         print('the Quiz is Over');
         quizCompleted = true;
         showResults(context);
       }
     });
  }



  void showResults(BuildContext context){
  showDialog(
    context: context,
    barrierDismissible: false  ,
    builder:(BuildContext context){
      return AlertDialog(
        title :Text("End Quiz ",
        style: TextStyle(fontSize : 32.0),
        textAlign: TextAlign.center),
        content: Container(
          height: 250.0 ,
          child:Column(
            children: <Widget> [
              Icon(
                Icons.tag_faces_outlined,
                size:50.0,
              ),
              SizedBox(height:50.0 ,),
              Text("thank you ", style:TextStyle(fontSize:32.0)),
              SizedBox(height:20.0),
              Text(  "your score is ($score) points"),

            ],
          ),
        ),
        actions : <Widget>[
          FlatButton(
            child : Text("Reset"),
            onPressed:(){
             setState(() {
               currentQuestion = 0;
               correctCounter =0;
               wrongCounter =0 ;
               score = 0;
               quizCompleted = false;
             });
              Navigator.of(context).pop();
            },
          )
        ],
      );
    }

  );
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex:4,
          child: Text(
              questions[currentQuestion].text,
        style:TextStyle(fontSize:25.0, color: Colors.white)
        ),
        ),
        Expanded(
          flex:1,
          child: ButtonTheme(
            minWidth:200,
            buttonColor:Colors.white,
            splashColor:Colors.green[100],
            child:RaisedButton(
              onPressed:(){
                setState ((){
                 nextQuestion(true, context);
                });
              },
              child: Text('True',style:TextStyle(fontSize:30.0)),
              shape:RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
        ),
        SizedBox(height:20.0,),
        Expanded(
          flex:1,
          child: ButtonTheme(
            minWidth:200,
            buttonColor:Colors.white,
            splashColor:Colors.red[100],
            child:RaisedButton(
              onPressed:(){
                setState ((){
                  nextQuestion(false ,context);
                });
              },
              child: Text('False',style:TextStyle(fontSize:30.0)),
              shape:RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
        ),
        SizedBox(height:20.0,),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,

            children:<Widget>[

              Column(
                children: <Widget>[
                Text(
                  "correct",
                  style: TextStyle(
                    color:Colors.white,
                    fontSize: 20.0
                  ),
                ) ,
                  Text(
                    //invoke this text to object correctCounter and casting by method
                  correctCounter.toString(),
                    style: TextStyle(
                        color:Colors.white,
                        fontSize: 20.0
                    ),
                  ) ,
                ],
              ),
              Column(
                children: <Widget>[
                  Text(
                    "wrong",
                    style: TextStyle(
                        color:Colors.white,
                        fontSize: 20.0
                    ),
                  ) ,
                  Text(
                    //invoke this text to object wrongCounter and casting by method
                    wrongCounter.toString(),
                    style: TextStyle(
                        color:Colors.white,
                        fontSize: 20.0
                    ),
                  ) ,
                ],
              ),


            ],
          ),
        ),
      ],
    );

  }
}

