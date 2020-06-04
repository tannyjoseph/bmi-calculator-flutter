import 'package:bmi_calculator/results_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'reusable_card.dart';
import 'Gender.dart';
import 'constants.dart';
import 'calculator.dart';

const bottomheight = 80.0;
const bottomColour = Color(0xFFEB1555);
const inactive = Color(0xFF111328);
const activeCardColour = Color(0xFF1D1E33);

enum gender { male, female }

void main() => runApp(BMICalculator());

class BMICalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Color(0xFF090c22),
          scaffoldBackgroundColor: Color(0xFF090c22),
          accentColor: Colors.purple,
          textTheme: TextTheme(bodyText2: TextStyle(color: Colors.white))),
      home: InputPage(),
    );
  }
}

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  gender selected;
  int height = 180;
  int weight = 60;
  int age = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text('BMI CALCULATOR')),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                      child: card(
                          onPress: () {
                            setState(() {
                              selected = gender.male;
                            });
                          },
                          colour: (selected == gender.male)
                              ? activeCardColour
                              : inactive,
                          cardChild: Gender(
                              icon: FontAwesomeIcons.mars, gender: 'MALE'))),
                  Expanded(
                      child: card(
                    onPress: () {
                      setState(() {
                        selected = gender.female;
                      });
                    },
                    colour:
                        selected == gender.female ? activeCardColour : inactive,
                    cardChild: Gender(
                      icon: FontAwesomeIcons.venus,
                      gender: "FEMALE",
                    ),
                  ))
                ],
              ),
            ),
            Expanded(
                child: card(
              colour: activeCardColour,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'HEIGHT',
                    style: labelTextStyle,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        height.toString(),
                        style: numbers,
                      ),
                      Text(
                        'cm',
                        style: labelTextStyle,
                      ),
                    ],
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                        thumbColor: Color(0xFFEB1555),
                        inactiveTrackColor: Color(0xFF8D8E98),
                        activeTrackColor: Colors.white,
                        overlayColor: Color(0x29EB1555),
                        thumbShape:
                            RoundSliderThumbShape(enabledThumbRadius: 15.0),
                        overlayShape:
                            RoundSliderOverlayShape(overlayRadius: 25.0)),
                    child: Slider(
                      value: height.toDouble(),
                      min: 100.0,
                      max: 300.0,
                      onChanged: (double newValue) {
                        setState(() {
                          height = newValue.round();
                        });
                      },
                    ),
                  ),
                ],
              ),
            )),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                      child: card(
                    colour: activeCardColour,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'WEIGHT',
                          style: labelTextStyle,
                        ),
                        Text(
                          weight.toString(),
                          style: numbers,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RoundButton(
                                icon: FontAwesomeIcons.plus,
                                onPressed: () {
                                  setState(() {
                                    weight++;
                                  });
                                }),
                            SizedBox(width: 15.0),
                            RoundButton(
                                icon: FontAwesomeIcons.minus,
                                onPressed: () {
                                  setState(() {
                                    weight--;
                                  });
                                })
                          ],
                        ),
                      ],
                    ),
                  )),
                  Expanded(
                      child: card(
                    colour: activeCardColour,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('AGE', style: labelTextStyle),
                        Text(age.toString(), style: numbers),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RoundButton(
                              icon: FontAwesomeIcons.plus,
                              onPressed: () {
                                setState(() {
                                  age++;
                                });
                              },
                            ),
                            SizedBox(
                              width: 15.0,
                            ),
                            RoundButton(
                              icon: FontAwesomeIcons.minus,
                              onPressed: () {
                                setState(() {
                                  age--;
                                });
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                  ))
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                CalculatorBrain calc =
                    CalculatorBrain(height: height, weight: weight);
                String calculated = calc.calculateBMI();
                Navigator.push(context, MaterialPageRoute(builder: (context) {

                  return ResultsPage(bmi : calculated ,result : calc.getResult(), comment : calc.getComment());
                }));
              },
              child: Container(
                height: bottomheight,
                color: bottomColour,
                child: Center(
                  child: Text(
                    'CALCULATE YOUR BMI',
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}

class RoundButton extends StatelessWidget {
  RoundButton({this.icon, this.onPressed});

  final IconData icon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      shape: CircleBorder(),
      elevation: 6.0,
      onPressed: onPressed,
      child: Center(child: Icon(icon, color: Colors.white, size: 20.0)),
      constraints: BoxConstraints.tightFor(width: 45.0, height: 45.0),
      fillColor: Color(0xFF4C4F5E),
    );
  }
}
