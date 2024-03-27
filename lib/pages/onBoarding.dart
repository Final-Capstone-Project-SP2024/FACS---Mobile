import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';

class OnBoarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: OnBoardingSlider(
        headerBackgroundColor: Color(0xFFFF5722),
        finishButtonText: 'Start now',
        finishButtonStyle: FinishButtonStyle(
          backgroundColor: Color(0xFFFF5722),
        ),
        skipTextButton: Text('Skip'),
        onFinish: () {
          Navigator.pushNamed(context, "/signin");
        },
        background: [
          Image.asset('lib/assets/images/white_image.png'),
          Image.asset('lib/assets/images/white_image.png'),
          Image.asset('lib/assets/images/white_image.png')
        ],
        totalPage: 3,
        speed: 1.8,
        pageBodies: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 480,
                  child: Image.asset('lib/assets/images/pic2.png'),
                ),
                Text(
                  'Enhanced Fire Detection in Outdoor Areas',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 480,
                  child: Image.asset('lib/assets/images/pic3.png'),
                ),
                Text(
                  'Stay ahead of the flames',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 480,
                  child: Image.asset('lib/assets/images/pic4.png'),
                ),
                Text(
                  'Efficient fire detection at your fingertips',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
