import 'package:flutter_modular/flutter_modular.dart';
import 'package:usuario_teste_pratico/app/modules/auth/pages/LOGIN_page.dart';
import 'package:usuario_teste_pratico/app/modules/auth/pages/register_page.dart';
import 'package:usuario_teste_pratico/app/modules/auth/provider/login_provider.dart';
import 'package:usuario_teste_pratico/app/modules/auth/provider/register_provider.dart';
import 'package:usuario_teste_pratico/app/modules/auth/store/login_store.dart';
import 'package:usuario_teste_pratico/app/modules/auth/store/register_store.dart';


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
    i.addSingleton(() => LoginStore());
    i.addSingleton(() => RegisterStore());
    i.addSingleton(() => LoginProvider(loginStore: LoginStore()));
    i.addSingleton(() => RegisterProvider(registerStore: RegisterStore()));
  }

  @override
  void routes(RouteManager r) {
    /// Define as rotas para as páginas de autenticação.s
    ///
    /// - A rota `/` leva à página de login.
    /// - A rota `/register` leva à página de registro.
    r.child('/', child: (_) => LoginPage());
    r.child('/register', child: (_) => RegisterPage());
  }
}
