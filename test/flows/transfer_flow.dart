import 'package:bytebankbd/components/response_dialog.dart';
import 'package:bytebankbd/components/transaction_auth_dialog.dart';
import 'package:bytebankbd/main.dart';
import 'package:bytebankbd/models/contact.dart';
import 'package:bytebankbd/models/transaction.dart';
import 'package:bytebankbd/screens/contacts_list.dart';
import 'package:bytebankbd/screens/dashboard.dart';
import 'package:bytebankbd/screens/transaction_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../matchers/matchers.dart';
import '../mocks/mocks.dart';
import 'actions.dart';

main() {
  testWidgets('should transfer to a contact', (tester) async {
    final mockContactDao = MockContactDao();
    final mockTransactionWebClient = MockTransactionWebClient();
    await tester.pumpWidget(Bytebankbd(
      contactDao: mockContactDao,
      transactionWebClient: mockTransactionWebClient,
    ));

    final dashboard = find.byType(Dashboard);
    expect(dashboard, findsOneWidget);

    //configuracao do mockito acessar o banco de dados
    final bianca = Contact(1, 'Bianca', 222);
    when(mockContactDao.findAll()).thenAnswer((invocation) async {
      debugPrint('name invocation ${invocation.memberName}');
      return [bianca];
    });

    await clickOnTheTransferFeatureItem(tester);
    await tester.pumpAndSettle();

    final contactsList = find.byType(ContactsList);
    expect(contactsList, findsOneWidget);

    verify(mockContactDao.findAll()).called(1);

    final contactItem = find.byWidgetPredicate((widget) {
      if (widget is ContactItem) {
        return widget.contact.name == 'Bianca' &&
            widget.contact.accountNumber == 222;
      }
      return false;
    });
    expect(contactItem, findsOneWidget);
    await tester.tap(contactItem);
    await tester.pumpAndSettle();

    final transactionFormat = find.byType(TransactionForm);
    expect(transactionFormat, findsOneWidget);

    final contactName = find.text('Bianca');
    expect(contactName, findsOneWidget);

    final contactAccountNumber = find.text('222');
    expect(contactAccountNumber, findsOneWidget);

    final textFieldValue = find.byWidgetPredicate((widget) {
      return textFieldByLabelTextMatcher(widget, 'Value');
    });
    expect(textFieldValue, findsOneWidget);
    await tester.enterText(textFieldValue, '222');

    final transferButton = find.widgetWithText(RaisedButton, 'Transfer');
    expect(transferButton, findsOneWidget);
    await tester.tap(transferButton);
    await tester.pumpAndSettle();

    final transactionAuthDialog = find.byType(TransactionAuthDialog);
    expect(transactionAuthDialog, findsOneWidget);

    final textFielPassword = find.byKey(
        transactionAuthDialogTextFieldPasswordKey);
    expect(textFielPassword, findsOneWidget);
    await tester.enterText(textFielPassword, '1000');

    final cancelButton = find.widgetWithText(FlatButton, 'Cancel');
    expect(cancelButton, findsOneWidget);
    final confirmButton = find.widgetWithText(FlatButton, 'Confirm');
    expect(confirmButton, findsOneWidget);

    //obs: na classe Transaction executar o comando generate hashcode
    when(mockTransactionWebClient.save(Transaction(null, 222, bianca), '1000'))
    .thenAnswer((_) async => Transaction(null, 222, bianca) );
    await tester.tap(confirmButton);
    await tester.pumpAndSettle();

    final successDialog = find.byType(SuccessDialog);
    expect(successDialog, findsOneWidget);

    final okButton = find.widgetWithText(FlatButton, 'Ok');
    await tester.tap(okButton);
    await tester.pumpAndSettle();

    final contactsListBack = find.byType(ContactsList);
    expect(contactsListBack, findsOneWidget);

  });
}
