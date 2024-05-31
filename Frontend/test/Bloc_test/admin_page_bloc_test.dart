import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:Sebawi/application/admin_page/admin_page_bloc.dart';
import 'package:Sebawi/application/admin_page/admin_page_event.dart';
import 'package:Sebawi/application/admin_page/admin_page_state.dart';
import 'package:Sebawi/data/models/accounts.dart';
import 'package:Sebawi/data/models/posts.dart';
import 'package:Sebawi/data/services/api_path.dart';
import 'package:mocktail/mocktail.dart';

class MockRemoteService extends Mock implements RemoteService {}

void main() {
  group('AdminPageBloc', () {
    late AdminPageBloc adminPageBloc;
    late MockRemoteService mockRemoteService;

    setUpAll(() {
      registerFallbackValue(Account(
        id: '1',
        name: 'Test Account',
        username: 'testuser',
        email: 'test@example.com',
        role: 'user'
      ));
      registerFallbackValue(Post(
        id: '1',
        name: 'Test Post',
        description: 'Test Description',
        contact: 'Test Contact',
        user: ''
      ));
    });

    setUp(() {
      mockRemoteService = MockRemoteService();
      adminPageBloc = AdminPageBloc();
    });

    tearDown(() {
      adminPageBloc.close();
    });

    test('initial state is AdminPageInitial', () {
      expect(adminPageBloc.state, AdminPageInitial());
    });
  });
}
