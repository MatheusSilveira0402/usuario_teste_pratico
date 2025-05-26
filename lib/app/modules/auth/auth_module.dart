import 'package:flutter_modular/flutter_modular.dart';
import 'package:usuario_teste_pratico/app/modules/auth/pages/LOGIN_page.dart';
import 'package:usuario_teste_pratico/app/modules/auth/provider/login_provider.dart';


/// O módulo [AuthModule] gerencia as rotas e dependências relacionadas à
/// autenticação do usuário, como login e registro.
class AuthModule extends Module {
  @override
  void binds(Injector i) {
    /// Registra o [AuthStore] como uma instância singleton no módulo.
    ///
    /// O [AuthStore] é responsável por gerenciar o estado e as operações
    /// relacionadas à autenticação do usuário, como login, logout e verificação
    /// de sessão.
    //i.addSingleton(() => AuthStore());
    i.addSingleton(() => LoginProvider());
  }

  @override
  void routes(RouteManager r) {
    /// Define as rotas para as páginas de autenticação.
    ///
    /// - A rota `/` leva à página de login.
    /// - A rota `/register` leva à página de registro.
    r.child('/', child: (_) => LoginPage());
    // r.child('/register', child: (_) => const RegisterPage());
  }
}
