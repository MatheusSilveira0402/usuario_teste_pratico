import 'package:flutter_modular/flutter_modular.dart';
import 'package:usuario_teste_pratico/app/modules/auth/auth_module.dart';
import 'package:usuario_teste_pratico/app/modules/users/users_module.dart';

/// Define os módulos principais da aplicação e suas rotas.
///
/// Este módulo é responsável por declarar os submódulos que compõem
/// a estrutura principal do app, como autenticação e o módulo principal.
class AppModule extends Module {
  /// Registra dependências globais da aplicação.
  /// 
  /// Neste exemplo, nenhum binding é definido.
  @override
  void binds(Injector i) {
    // Nenhum binding global no momento.
  }

  /// Define as rotas do módulo principal da aplicação.
  ///
  /// - `'/'` redireciona para o [AuthModule] (login, registro etc).
  /// - `'/users'` redireciona para o [UsersModule] (interface principal do app).
  @override
  void routes(RouteManager r) {
    r.module('/', module: AuthModule());
    r.module('/users', module: UsersModule());
  }
}
