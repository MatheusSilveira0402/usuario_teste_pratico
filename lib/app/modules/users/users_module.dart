import 'package:flutter_modular/flutter_modular.dart';
import 'package:usuario_teste_pratico/app/modules/users/pages/users_form_page.dart';
import 'package:usuario_teste_pratico/app/modules/users/pages/users_page.dart';
import 'package:usuario_teste_pratico/app/modules/users/provider/users_provider.dart';
import 'package:usuario_teste_pratico/app/modules/users/store/users_store.dart';

class UsersModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton(() => UsersStore());
    i.addSingleton(() => UsersProvider(usersStore: i.get<UsersStore>()));
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (_) => const UsersPage(),
    );
    r.child(
      '/form',
      child: (_) => UsersFormPage(),
    );
  }
}
