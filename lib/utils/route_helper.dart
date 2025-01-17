import 'dart:async';

import 'package:flutter/material.dart';

class RouteHelper {
  static Future<T> pushWidget<T>(
    BuildContext context,
    Widget widget, {
    bool replaceRoot = false,
    bool replaceCurrent = false,
  }) {
    return pushRoute(
      context,
      MaterialPageRoute(builder: (ctx) => widget),
      replaceRoot: replaceRoot,
      replaceCurrent: replaceCurrent,
    );
  }

  static Future<T> pushRoute<T>(
    BuildContext context,
    PageRoute<T> route, {
    bool replaceRoot = false,
    bool replaceCurrent = false,
  }) {
    assert(!(replaceRoot == true && replaceCurrent == true));
    if (replaceRoot == true) {
      return Navigator.pushAndRemoveUntil(
        context,
        route,
        _rootRoute,
      );
    }
    if (replaceCurrent == true) {
      return Navigator.pushReplacement(context, route);
    }
    return Navigator.push(context, route);
  }
}

var _rootRoute = ModalRoute.withName("home");
