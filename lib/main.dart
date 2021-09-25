import 'package:flutter/material.dart';
import 'dart:math';
import 'dice.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var maxNum = 6;
  var dotNumberOne = 1;
  var dotNumberTwo = 1;
  var total = 0;
  var isPressedOne = true;
  var isPressedTwo = true;
  var dealerScore = 0;
  var result = 'You Lose';

  @override
  Widget build(BuildContext context) {
    Widget placeDice(num) {
      DiceBuilder dice1 = new DiceBuilder(dotNumberOne, context);
      DiceBuilder dice2 = new DiceBuilder(dotNumberTwo, context);
      return Flexible(
        flex: 1,
        fit: FlexFit.tight,
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: TextButton(
                child: Container(
                  width: double.infinity,
                  height: 300,
                  child: num == 1 ? dice1 : dice2,
                ),
                onPressed: () {
                  setState(() {
                    if (isPressedOne && num == 1) {
                      dotNumberOne = Random().nextInt(maxNum) + 1;
                      isPressedOne = false;
                      total += dotNumberOne;
                    } else if (isPressedTwo && num == 2) {
                      dotNumberTwo = Random().nextInt(maxNum) + 1;
                      isPressedTwo = false;
                      total += dotNumberTwo;
                    }
                  });
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  num == 1 ? '$dotNumberOne' : '$dotNumberTwo',
                  style: TextStyle(
                    fontSize: 36,
                    fontFamily: 'PressStart2P',
                    color:
                        Theme.of(context).textTheme.bodyText1!.decorationColor,
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget dialogBuilder(BuildContext context) {
      return SimpleDialog(
        children: [
          Text(
            '$result',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 36,
              fontFamily: 'PressStart2P',
            ),
          ),
        ],
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text(
            'Blackjack Dice',
            style: TextStyle(
              fontSize: 32,
              fontFamily: 'CinzelDecorative',
            ),
          )),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text(
                    'Dealer',
                    style: TextStyle(
                      fontSize: 36,
                      fontFamily: 'PressStart2P',
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text(
                    dealerScore > 0 ? '$dealerScore' : '',
                    style: TextStyle(
                      fontSize: 42,
                      fontFamily: 'PressStart2P',
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
                width: 300.0,
                child: Divider(
                  thickness: 2,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '$total',
                    style: TextStyle(
                      fontSize: 42,
                      fontFamily: 'PressStart2P',
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .decorationColor,
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 3,
                fit: FlexFit.tight,
                child: Row(
                  children: [
                    placeDice(1),
                    placeDice(2),
                  ],
                ),
              ),
              Builder(
                builder: (BuildContext context) {
                  return ElevatedButton(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                      child: Text(
                        'FIGHT',
                        style: TextStyle(
                          fontSize: 36,
                          fontFamily: 'PressStart2P',
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        dealerScore = Random().nextInt(6) + 1;
                        if (dealerScore < total) {
                          dealerScore += Random().nextInt(6) + 1;
                        }
                        if (dealerScore < total) {
                          result = 'You Win';
                          print('$dealerScore and $total');
                        }
                        showDialog(
                            context: context,
                            builder: (context) => dialogBuilder(context));
                      });
                    },
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10, top: 10),
                child: ElevatedButton(
                  child: Container(
                    child: Text(
                      'RESET',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'PressStart2P',
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      dotNumberOne = 1;
                      dotNumberTwo = 1;
                      total = 0;
                      isPressedOne = true;
                      isPressedTwo = true;
                      dealerScore = 0;
                      result = 'You Lose';
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
