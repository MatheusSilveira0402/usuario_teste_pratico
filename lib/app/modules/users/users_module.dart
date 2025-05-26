import 'package:flutter_modular/flutter_modular.dart';
import 'package:usuario_teste_pratico/app/modules/users/pages/users_page.dart';


class UsersModule extends Module {
  @override
  void binds(Injector i) {
   
    //i.addSingleton(() => ());
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => UsersPage());
  }
}
