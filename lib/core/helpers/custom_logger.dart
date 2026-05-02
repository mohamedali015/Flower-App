// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

abstract class CustomLogger {
  static void green(String message) {
    debugPrint('\x1B[32m$message\x1B[0m');
  }

  static void red(String message) {
    debugPrint('\x1B[31m$message\x1B[0m');
  }

  static void yellow(String message) {
    debugPrint('\x1B[33m$message\x1B[0m');
  }

  static void cyan(String message) {
    debugPrint('\x1B[36m$message\x1B[0m');
  }

  static void blue(String message) {
    debugPrint('\x1B[34m$message\x1B[0m');
  }

  static void magenta(String message) {
    debugPrint('\x1B[35m$message\x1B[0m');
  }

  static void white(String message) {
    debugPrint('\x1B[37m$message\x1B[0m');
  }

  static void black(String message) {
    debugPrint('\x1B[30m$message\x1B[0m');
  }

  static void gray(String message) {
    debugPrint('\x1B[90m$message\x1B[0m');
  }

  static void bgRed(String message) {
    debugPrint('\x1B[41m$message\x1B[0m');
  }

  static void bgGreen(String message) {
    debugPrint('\x1B[42m$message\x1B[0m');
  }

  static void bgYellow(String message) {
    debugPrint('\x1B[43m$message\x1B[0m');
  }

  static void bgBlue(String message) {
    debugPrint('\x1B[44m$message\x1B[0m');
  }

  static void bgMagenta(String message) {
    debugPrint('\x1B[45m$message\x1B[0m');
  }

  static void bgCyan(String message) {
    debugPrint('\x1B[46m$message\x1B[0m');
  }

  static void bgWhite(String message) {
    debugPrint('\x1B[47m$message\x1B[0m');
  }
}
