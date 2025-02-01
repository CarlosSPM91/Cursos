import 'package:flutter_test/flutter_test.dart';
import 'package:tv_ratting_app/app/presentation/service_locator/service_locator.dart';

void main() {
  tearDown(
    () {
      ServiceLocator.instance.clear();
    },
  );
  test(
    'ServiceLocator > put',
    () {
      expect(
        () {
          ServiceLocator.instance.find<String>();
        },
        throwsAssertionError,
      );

      final name = ServiceLocator.instance.put<String>(
        'Jose',
      );
      expect(
        name,
        ServiceLocator.instance.find<String>(),
      );
    },
  );

  test(
    'ServiceLocator > put 2',
    () {
      ServiceLocator.instance.put('Jose');
      ServiceLocator.instance.put(
        'Daniels',
        tag: 'name2',
      );
      final user = ServiceLocator.instance.put(
        User('Lulu'),
      );

      final name = ServiceLocator.instance.find<String>(
        tag: 'name2',
      );
      expect(ServiceLocator.instance.find<User>(), user);

      expect(
        ServiceLocator.instance.find<String>(),
        'Jose',
      );
      expect(name, 'Daniel');
    },
  );
}

class User {
  final String name;

  User(this.name);
}