import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class RectButton extends StatelessWidget {
  const RectButton(
      {Key? key,
      required this.onPressed,
      required this.text,
      required this.width,
      required this.padding,
      this.red = 136,
      this.green = 99,
      this.blue = 255})
      : super(key: key);

  final void Function()? onPressed;
  final String text;
  final double width;
  final double padding;
  final int red;
  final int green;
  final int blue;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        padding: EdgeInsets.symmetric(vertical: padding),
        decoration: BoxDecoration(
          color: Color.fromRGBO(red, green, blue, 1.0),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(red, green, blue, 0.45),
              offset: Offset.zero,
              blurRadius: 15.0,
            )
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }
}

SpinKitPulse loader = const SpinKitPulse(
  color: Color(0xff8863FF),
);

class Brand extends StatelessWidget {
  const Brand({Key? key, this.brandWidth = 350.0}) : super(key: key);
  final double brandWidth;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'brand.png',
        width: brandWidth,
        filterQuality: FilterQuality.medium,
      ),
    );
  }
}
