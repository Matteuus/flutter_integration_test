import 'dart:async';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group("Scollable App", () {
    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        await driver.close();
      }
    });

    test("verifica se a lista tem um item especifico", () async {
      final listFinder = find.byValueKey('long_list');
      final itemFinder = find.byValueKey('item_50_text');

      final timeline = await driver.traceAction(() async {
        await driver.scrollUntilVisible(listFinder, itemFinder, dyScroll: -300);
      });

      Timer(Duration(seconds: 2), () async {
        expect(await driver.getText(itemFinder), "Item 50");
      });

      final summary = new TimelineSummary.summarize(timeline);
      await summary.writeSummaryToFile('scrolling_summary', pretty: true);
      await summary.writeTimelineToFile('scrolling_timeline', pretty: true);
    });
  });
}
