import 'package:bytebankbd/database/dao/contact_dao.dart';
import 'package:bytebankbd/http/webclients/transaction_webclient.dart';
import 'package:bytebankbd/screens/dashboard.dart';
import 'package:bytebankbd/widgets/app_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(Bytebankbd(
    contactDao: ContactDao(),
    transactionWebClient: TransactionWebClient(),
  ));
}

class Bytebankbd extends StatelessWidget {
  final ContactDao contactDao;
  final TransactionWebClient transactionWebClient;

  Bytebankbd({@required this.contactDao, @required this.transactionWebClient});

  @override
  Widget build(BuildContext context) {
    return AppDependencies(
      contactDao: contactDao,
      transactionWebClient: transactionWebClient,
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.green[900],
          accentColor: Colors.blueAccent[700],
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.blueAccent[700],
            textTheme: ButtonTextTheme.primary,
          ),
        ),
        home: Dashboard(),
      ),
    );
  }
}
