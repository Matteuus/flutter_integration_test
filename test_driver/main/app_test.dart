import 'dart:async';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group("Counter App", () {
    final counterTextFinder = find.byValueKey('counter');
    final buttonIncrementFinder = find.byValueKey('increment');
    final buttonDecrementFinder = find.byValueKey('decrement');

    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test("começa com 0", () async {
      expect(await driver.getText(counterTextFinder), "0");
    });

    test("incrementa o contador", () async {
      await driver.tap(buttonIncrementFinder);
      Timer(Duration(seconds: 2), () async {
        expect(await driver.getText(counterTextFinder), "1");
      });
    });

    test("decrementa o contador", () async {
      await driver.tap(buttonDecrementFinder);
      Timer(Duration(seconds: 2), () async {
        expect(await driver.getText(counterTextFinder), "0");
      });
    });
  });
}
