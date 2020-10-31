import 'package:bytebankbd/database/dao/contact_dao.dart';
import 'package:bytebankbd/http/webclients/transaction_webclient.dart';
import 'package:mockito/mockito.dart';

class MockContactDao extends Mock implements ContactDao{}

class MockTransactionWebClient extends Mock implements TransactionWebClient{}