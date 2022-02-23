import 'package:calculator_api_web/my_button.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(title: 'Calculator'),
    ); // MaterialApp
  }
}

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({Key? key, required this.title}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userInput = '';
  var answer = '';

  // Array of button
  final List<String> buttons = [
    'C',
    '+/-',
    '%',
    'DEL',
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    'x',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    '=',
    '+',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Calculator"),
      ), //AppBar
      backgroundColor: Colors.white38,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.centerRight,
                      child: Text(
                        userInput,
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(15),
                      alignment: Alignment.centerRight,
                      child: Text(
                        answer,
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ]),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              child: GridView.builder(
                  itemCount: buttons.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index) {
                    // Clear Button
                    if (index == 0) {
                      return MyButton(
                        buttontapped: () {
                          setState(() {
                            userInput = '';
                            answer = '0';
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.blue[50],
                        textColor: Colors.black,
                      );
                    }

                    // +/- button
                    else if (index == 1) {
                      return MyButton(
                        buttonText: buttons[index],
                        color: Colors.blue[50],
                        textColor: Colors.black,
                      );
                    }
                    // % Button
                    else if (index == 2) {
                      return MyButton(
                        buttontapped: () {
                          setState(() {
                            userInput += buttons[index];
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.blue[50],
                        textColor: Colors.black,
                      );
                    }
                    // Delete Button
                    else if (index == 3) {
                      return MyButton(
                        buttontapped: () {
                          setState(() {
                            userInput =
                                userInput.substring(0, userInput.length - 1);
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.blue[50],
                        textColor: Colors.black,
                      );
                    }
                    // Equal_to Button
                    else if (index == 18) {
                      return MyButton(
                        buttontapped: () {
                          setState(() {
                            equalPressed();
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.orange[700],
                        textColor: Colors.white,
                      );
                    }

                    //  other buttons
                    else {
                      return MyButton(
                        buttontapped: () {
                          setState(() {
                            userInput += buttons[index];
                          });
                        },
                        buttonText: buttons[index],
                        color: isOperator(buttons[index])
                            ? Colors.blueAccent
                            : Colors.white,
                        textColor: isOperator(buttons[index])
                            ? Colors.white
                            : Colors.black,
                      );
                    }
                  }), // GridView.builder
            ),
          ),
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

// function to calculate the input operation
  void equalPressed() {
    String finaluserinput = userInput;
    finaluserinput = userInput.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finaluserinput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer = eval.toString();
  }
}
// class HomePage extends StatefulWidget {
//   const HomePage({Key? key, required this.title}) : super(key: key);
//   final String title;

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   var userInput = "";
//   var answer = "";
//   final List<String> buttons = [
//     "C",
//     "+",
//     "%",
//     "DEL",
//     "7",
//     "8",
//     "9",
//     "/",
//     "4",
//     "5",
//     "6",
//     "x",
//     "1",
//     "2",
//     "3",
//     "0",
//     "-",
//     ".",
//     "=",
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//         backgroundColor: Colors.white38,
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             // ignore: avoid_unnecessary_containers
//             child: Container(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(20.0),
//                     child: Container(
//                       alignment: Alignment.centerRight,
//                       child: Text(
//                         userInput,
//                         style: const TextStyle(
//                           fontSize: 18,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(15.0),
//                     child: Container(
//                       alignment: Alignment.centerRight,
//                       child: Text(
//                         userInput,
//                         style: const TextStyle(
//                             fontSize: 30,
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Expanded(
//             flex: 3,
//             child: Container(
//               child: GridView.builder(
//                   itemCount: buttons.length,
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 4),
//                   itemBuilder: (BuildContext context, int index) {
//                     if (index == 0) {
//                       return MyButton(
//                         buttontapped: () {
//                           setState(() {
//                             userInput = "";
//                             answer = "";
//                           });
//                         },
//                         buttonText: buttons[index],
//                         color: Colors.blue[50],
//                         textColor: Colors.black,
//                       );
//                     } else if (index == 1) {
//                       return MyButton(
//                         buttonText: buttons[index],
//                         color: Colors.blue[50],
//                         textColor: Colors.black,
//                       );
//                     } else if (index == 2) {
//                       return MyButton(
//                         buttontapped: () {
//                           setState(() {
//                             userInput += buttons[index];
//                           });
//                         },
//                         buttonText: buttons[index],
//                         color: Colors.blue[50],
//                         textColor: Colors.black,
//                       );
//                     } else if (index == 3) {
//                       return MyButton(
//                         buttontapped: () {
//                           setState(() {
//                             userInput =
//                                 userInput.substring(0, userInput.length - 1);
//                           });
//                         },
//                         buttonText: buttons[index],
//                         color: Colors.blue[50],
//                         textColor: Colors.black,
//                       );
//                     }
//                     // Equal_to Button
//                     else if (index == 18) {
//                       return MyButton(
//                         buttontapped: () {
//                           setState(() {
//                             equalPressed();
//                           });
//                         },
//                         buttonText: buttons[index],
//                         color: Colors.orange[700],
//                         textColor: Colors.white,
//                       );
//                     }

//                     //  other buttons
//                     else {
//                       return MyButton(
//                         buttontapped: () {
//                           setState(() {
//                             userInput += buttons[index];
//                           });
//                         },
//                         buttonText: buttons[index],
//                         color: isOperator(buttons[index])
//                             ? Colors.blueAccent
//                             : Colors.white,
//                         textColor: isOperator(buttons[index])
//                             ? Colors.white
//                             : Colors.black,
//                       );
//                     }
//                   }), // GridView.builder
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   bool isOperator(String x) {
//     if (x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
//       return true;
//     }
//     return false;
//   }

//   // function to calculate the input operation
//   void equalPressed() {
//     String finaluserinput = userInput;
//     finaluserinput = userInput.replaceAll('x', '*');

//     Parser p = Parser();
//     Expression exp = p.parse(finaluserinput);
//     ContextModel cm = ContextModel();
//     double eval = exp.evaluate(EvaluationType.REAL, cm);
//     answer = eval.toString();
//   }
// }
