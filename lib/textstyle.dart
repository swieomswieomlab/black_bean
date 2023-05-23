// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

const Color mainBlack = Color(0xff020c16);
const Color mainLightBlue = Color(0xffeaf4fc);
const Color maingreyblue = Color(0xffd5e5f1);
const Color mainSkyBlue = Color(0xff43a7f5);
const Color grey00 = Color(0xffffffff);
const Color grey01 = Color(0xfff2f3f4);
const Color grey02 = Color(0xffe6e7e8);
const Color grey03 = Color(0xffd0d6d8);
const Color grey04 = Color(0xffa8afb1);
const Color grey05 = Color(0xff7e8385);
const Color grey06 = Color(0xff64696a);
const Color grey07 = Color(0xff414445);
const Color grey08 = Color(0xff373838);
const Color pointRed = Color(0xffeb4b4b);
const Color pointYellow = Color(0xfff8cb74);
const Color pointGreen = Color(0xff30d07a);

TextStyle Headline_H0(double fontsize, Color color) {
  return TextStyle(
    fontSize: 72,
    decoration: TextDecoration.none,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w700,
    height: 74 / 72,
    letterSpacing: 0,
    color: color,
  );
}

TextStyle Headline_H1(double fontsize, Color color) {
  return TextStyle(
    fontSize: fontsize,
    decoration: TextDecoration.none,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w700,
    height: 64 / 60,
    letterSpacing: 0,
    color: color,
  );
}

TextStyle Headline_H2(double fontsize, Color color) {
  return TextStyle(
    fontSize: fontsize,
    decoration: TextDecoration.none,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w600,
    height: 45 / 36,
    letterSpacing: 0,
    color: color,
  );
}

TextStyle Headline_H3(double fontsize, Color color) {
  return TextStyle(
    fontSize: fontsize,
    decoration: TextDecoration.none,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w600,
    height: 32 / 28,
    letterSpacing: 0,
    color: color,
  );
}

TextStyle Headline_H4(double fontsize, Color color) {
  return TextStyle(
    fontSize: fontsize,
    decoration: TextDecoration.none,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w600,
    height: 30 / 26,
    letterSpacing: 0,
    color: color,
  );
}

TextStyle Body_Bd1(double fontsize, Color color) {
  return TextStyle(
    fontSize: fontsize,
    decoration: TextDecoration.none,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
    height: 30 / 26,
    letterSpacing: 0,
    color: color,
  );
}

TextStyle Body_Bd2(double fontsize, Color color) {
  return TextStyle(
    fontSize: fontsize,
    decoration: TextDecoration.none,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
    height: 28 / 24,
    letterSpacing: 0,
    color: color,
  );
}

TextStyle Body_Bd3(double fontsize, Color color) {
  return TextStyle(
    fontSize: fontsize,
    decoration: TextDecoration.none,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
    height: 26 / 20,
    letterSpacing: 0,
    color: color,
  );
}

TextStyle Body_Bd4(double fontsize, Color color) {
  return TextStyle(
    fontSize: fontsize,
    decoration: TextDecoration.none,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
    height: 24 / 18,
    letterSpacing: 0,
    color: color,
  );
}

TextStyle Body_Bd4_bold(double fontsize, Color color) {
  return TextStyle(
      fontSize: fontsize,
      decoration: TextDecoration.none,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w700,
      height: 24 / 18,
      letterSpacing: 0,
      color: color);
}

TextStyle Button_Bt1(double fontsize, Color color) {
  return TextStyle(
      fontSize: fontsize,
      decoration: TextDecoration.none,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      height: 24 / 24,
      letterSpacing: 0,
      color: color);
}

TextStyle Button_Bt2(double fontsize, Color color) {
  return TextStyle(
      fontSize: fontsize,
      decoration: TextDecoration.none,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      height: 20 / 20,
      letterSpacing: 0,
      color: color);
}

TextStyle Button_Bt3(double fontsize, Color color) {
  return TextStyle(
      fontSize: fontsize,
      decoration: TextDecoration.none,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      height: 18 / 18,
      letterSpacing: 0,
      color: color);
}

TextStyle Tiny_T1(double fontsize, Color color) {
  return TextStyle(
      fontSize: fontsize,
      decoration: TextDecoration.none,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w600,
      height: 20 / 16,
      letterSpacing: 0,
      color: color);
}

TextStyle Tiny_T2(double fontsize, Color color) {
  return TextStyle(
      fontSize: fontsize,
      decoration: TextDecoration.none,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      height: 23 / 14,
      letterSpacing: 0,
      color: color);
}

TextStyle Tiny_T3(double fontsize, Color color) {
  return TextStyle(
      fontSize: fontsize,
      decoration: TextDecoration.none,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      height: 20 / 12,
      letterSpacing: 0,
      color: color);
}
