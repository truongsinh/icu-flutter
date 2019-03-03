import 'dart:async';

import 'package:flutter/services.dart';

class ICUString {
  String _original;
  Future<List<String>> _graphemeListFuture;
  Future<Map<int, int>> _char2GraphemeFuture;
  Future<Map<int, int>> _grapheme2CharFuture;

  static const MethodChannel _channel = const MethodChannel('icu');

  ICUString(String original) {
    _original = original;
    print(original);
    init(original);
  }

  void init(String original) async {
    print(original);
    final graphemeList = List<String>.from(await _channel
        .invokeMethod<List<dynamic>>('getGraphemeList', original));

    final char2Grapheme = Map<int, int>();
    final grapheme2Char = Map<int, int>();
    var charCounter = 0;

    for (var graphemeCounter = 0;
        graphemeCounter < graphemeList.length;
        graphemeCounter++) {
      grapheme2Char[graphemeCounter] = charCounter;
      for (var index = 0;
          index < graphemeList[graphemeCounter].length;
          index++) {
        char2Grapheme[charCounter] = graphemeCounter;
        charCounter++;
      }
    }

    _graphemeListFuture = Future.value(graphemeList);
    _char2GraphemeFuture = Future.value(char2Grapheme);
    _grapheme2CharFuture = Future.value(grapheme2Char);
    print( "listFuture");
    print(await _graphemeListFuture);
    print(char2Grapheme);
    print(grapheme2Char);
  }

  @override
  String toString() {
    return _original;
  }

  Future<int> currentGraphemePosition(int currentCharPosition) async {
    return (await _char2GraphemeFuture)[currentCharPosition];
  }

  Future<int> previousGraphemePosition(int currentCharPosition) async {
    if (currentCharPosition == _original.length) {
      final currentPosition =
          await currentGraphemePosition(currentCharPosition - 1);
      final previousPosition = (await _grapheme2CharFuture)[currentPosition];
      print(
          "last currentCharPosition $currentCharPosition, previousPosition $previousPosition");
      return previousPosition;
    }
    final currentPosition = await currentGraphemePosition(currentCharPosition);
    final previousPosition = (await _grapheme2CharFuture)[currentPosition - 1];
    print(
        "currentCharPosition $currentCharPosition, previousPosition $previousPosition");
    return previousPosition ?? 0;
  }

  Future<int> nextGraphemePosition(int currentCharPosition) async {
    final currentPosition = await currentGraphemePosition(currentCharPosition);
    final nextPosition = (await _grapheme2CharFuture)[currentPosition + 1];
    print(
        "currentCharPosition $currentCharPosition, nextPosition $nextPosition");
    return nextPosition ?? _original.length;
  }
}

class Icu {
  static const MethodChannel _channel = const MethodChannel('icu');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
