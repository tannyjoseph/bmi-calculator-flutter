import 'package:bmi_calculator/Gender.dart';
import 'package:bmi_calculator/constants.dart';
import 'package:bmi_calculator/reusable_card.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class ResultsPage extends StatelessWidget {

  ResultsPage({this.bmi, this.result, this.comment});

  final String bmi;
  final String result;
  final String comment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI CALCULATOR'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Your Result',
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: card(
                colour: activeCardColour,
                cardChild: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          result.toUpperCase(),
                          style: labelTextStyle,
                        ),
                      ),
                      Center(
                        child: Text(
                          bmi,
                          style: kresult,
                        ),
                      ),
                      Center(
                        child: Text(comment,
                          textAlign: TextAlign.center,
                            style: labelTextStyle,
                      )
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: bottomheight,
              color: bottomColour,
              child: Center(
                child: Text(
                  'RE-CALCULATE YOUR BMI',
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
