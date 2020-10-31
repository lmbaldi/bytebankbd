import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bytebankbd/screens/dashboard.dart';

import '../matchers/matchers.dart';

main() {
  testWidgets('Should display the main image when the dasboard is opened',
      (WidgetTester tester) async {
        await tester.pumpWidget(MaterialApp(home: Dashboard()));
        final mainImage = find.byType(Image);
        expect(mainImage, findsOneWidget);
      });

  testWidgets('Should display the transfer feature when the dasboard is opened',
      (tester) async {
        await tester.pumpWidget(MaterialApp(home:Dashboard()));
        // final iconTransferFeatureIcon =  find.widgetWithIcon(FeatureItem, Icons.monetization_on);
        // expect(iconTransferFeatureIcon, findsOneWidget);
        // final nameTransferFeatureItem = find.widgetWithText(FeatureItem, 'Transfer');
        // expect(nameTransferFeatureItem, findsOneWidget);
        final transferFeatureItem = find.byWidgetPredicate((widget){
          return featureItemMatcher(widget, 'Transfer', Icons.monetization_on);
        });
        expect(transferFeatureItem, findsOneWidget);
      }
  );

  testWidgets('Should display the transaction feed feature when the dasboard is opened',
          (tester) async {
        await tester.pumpWidget(MaterialApp(home:Dashboard()));
        // final iconTransactionFeedFeatureIcon =  find.widgetWithIcon(FeatureItem, Icons.description);
        // expect(iconTransactionFeedFeatureIcon, findsOneWidget);
        // final nameTransactionFeedferFeatureItem = find.widgetWithText(FeatureItem, 'Transaction Feed');
        // expect(nameTransactionFeedferFeatureItem, findsOneWidget);
        final transactionFeedFeatureItem = find.byWidgetPredicate((widget){
          return featureItemMatcher(widget, 'Transaction Feed', Icons.description);
        });
        expect(transactionFeedFeatureItem, findsOneWidget);
      }
  );
}

